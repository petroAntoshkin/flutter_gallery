class CatsParser{
  static List<String> parseCatsPictures(var data) {
    List<String> _allCats = [];
    int _len = (data as List).length;
    for (int i = 0; i < _len; i++) {
      String _url = (data[i]['url']);
      _allCats.add(_url);
    }
    return _allCats;
  }
}