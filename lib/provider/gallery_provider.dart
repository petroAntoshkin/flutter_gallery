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
    // List.generate(_maxImagesCount, (index) => _allPictures.add(''));
    _haveAnInternet = false;
    try {
      _haveAnInternet = await CheckInet.checkInternet;
    } on Exception {
      _haveAnInternet = false;
    }
    if(_haveAnInternet) _getImages();
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
    } else {
      _errorText = res.reasonPhrase;
      statusText = _errorText;
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
    if(!_haveAnInternet) _applyCashedInfo();
  }

  CashManager get cashManager => _cashManager;

  set statusText(String value){
    _statusText = value;
    notifyListeners();
  }
  String get statusText => _statusText;

  void _applyCashedInfo() {
    _allPictures = [];
    List<String> _all = _cashManager.getCashFiles();
    // statusText = 'cash folder: ${Directory('${_appDirectory.path}/cash/').existsSync()} files count:${_all.length}';
    for(int i = 0; i < _maxImagesCount; i++){
      _allPictures.add(i < _all.length ? _all[i] : '');
    }
    // statusText = 'array of pictures filled files count:${_allPictures.length}';
    notifyListeners();
  }

}