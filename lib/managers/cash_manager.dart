import 'package:flutter/material.dart';
import 'dart:io';

abstract class CashManager {
  File getCashFileFromUrl(String url);

  bool isFileExist(String url);

  String getFileNameFromUrl(String url);

  String getCashedFilePathFromUrl(String url);

  void addFileToCashList(String url);
}

class CashManagerImplementation implements CashManager {
  final String cashFolderString;
  Directory _cashFolder;
  List<FileSystemEntity> _cashedFiles;

  CashManagerImplementation({@required this.cashFolderString}) {
    _cashFolder = Directory(this.cashFolderString);
    if(!_cashFolder.existsSync())
      _cashFolder.create();
    else
      _readCash();
  }

  List<String> getCashFiles() {
    List<String> _res = [];
    if(_cashedFiles != null) for (int i = 0; i < _cashedFiles.length; i++) _res.add(_cashedFiles[i].path);
    return _res;
  }

  void clearCash() {
    _cashedFiles = [];
    List<FileSystemEntity> _list = _cashFolder.listSync();
    for (int i = 0; i < _list.length; i++) File(_list[i].path).delete();
  }

  @override
  bool isFileExist(String url) {
    String _candidate = '${_cashFolder.path}${getFileNameFromUrl(url)}';
    for (int i = 0; i < _cashedFiles.length; i++) {
      if (_candidate == _cashedFiles[i].path) return true;
    }
    return false;
  }

  void cashStringData(String contents) {
    File _dataFile = File('${_cashFolder.path}/cashed.json');
    _dataFile.writeAsString(contents);
  }

  Future<String> getCashedJson() async {
    String _res = '';
    File _jsonFile = File('${_cashFolder.path}/cashed.json');
    if (await _jsonFile.exists()) _res = await _jsonFile.readAsString();
    return _res;
  }

  void _readCash(){
      _cashedFiles = [];
      _cashedFiles = _cashFolder.listSync();
  }

  @override
  String getFileNameFromUrl(String url) => url.split('/').last;

  @override
  String getCashedFilePathFromUrl(String url) =>
      '${_cashFolder.path}${getFileNameFromUrl(url)}';

  int get cashedFilesCount => _cashFolder.listSync().length;

  @override
  File getCashFileFromUrl(String url) => File(getCashedFilePathFromUrl(url));

  @override
  void addFileToCashList(String url) {
    String _path = getCashedFilePathFromUrl(url);
    _cashedFiles.add(File(_path));
  }
}
