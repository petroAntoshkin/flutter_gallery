import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gallery/managers/cash_manager.dart';
import 'package:flutter_gallery/utils/cats_parser.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:check_inet/check_inet.dart';
import 'package:http/http.dart';

class GalleryProvider extends ChangeNotifier{
  Directory _appDirectory;
  bool _haveAnInternet = true;
  String _errorText = '';
  String _statusText = '';
  List<String> _allPictures = [];
  CashManagerImplementation _cashManager;
  final _maxImagesCount = 100;

  GalleryProvider(){
    _initCashFolder();
    _checkConnection();
  }

  void _checkConnection() async {
    // _applyCashedInfo();
    _haveAnInternet = false;
    try {
      _haveAnInternet = await CheckInet.checkInternet;
      // _applyCashedInfo();
    } on Exception {
      _haveAnInternet = false;
      _applyCashedInfo();
    }
    if(_haveAnInternet) _getImages();
    statusText = _haveAnInternet ? 'Internet connection detected' : 'No internet';
    if(!_haveAnInternet) _applyCashedInfo();
    notifyListeners();
  }

  Future<void> _getImages() async {

    final Uri _catsImagesUrl =
    Uri.https('api.thecatapi.com', '/v1/images/search', {
      'size': 'med',
      'limit': '$_maxImagesCount',
      'x-api-key': '24a960cb-3320-46d8-b3ef-6fb42d5e2df9'
    });
    Response res;
    try {
      res = await get(_catsImagesUrl);
    } catch (e) {
      print(e.toString());
    }

    if (res.statusCode == 200) {
      _allPictures = [];
      _allPictures = CatsParser.parseCatsPictures(jsonDecode(res.body));
      _cashManager.clearCash();
      // don't need in this project
      // _cashManager.cashStringData(res.body);
      statusText = 'Response arrived';
    } else {
      _errorText = res.reasonPhrase;
      statusText = _errorText;
      _applyCashedInfo();
    }
    notifyListeners();
  }

  List<String> get allPictures{
    List<String> _res = [];
    for(int i =0; i< _allPictures.length; i++)
      _res.add(_allPictures[i]);
    return _res;
  }

  String get error => _errorText;

  bool get internetConnection => _haveAnInternet;

  //-------------------------- cash section-------------------------------

  void _initCashFolder() async{
    _appDirectory = await getApplicationDocumentsDirectory();
    _cashManager = CashManagerImplementation(cashFolderString: '${_appDirectory.path}/cash/');
  }

  CashManager get cashManager => _cashManager;

  set statusText(String value){
    _statusText = value;
    notifyListeners();
  }
  String get statusText => _statusText;

  void _applyCashedInfo() {
    statusText = 'Start images from cash.';
    _allPictures = [];
    List<String> _all = _cashManager.getCashFiles();
    statusText = 'Load images from cash. Cashed ${_all.length} files';
    for(int i = 0; i< _maxImagesCount; i++){
      i < _all.length ? _allPictures.add(_all[i]) : _allPictures.add('');
    }
    notifyListeners();
  }

}