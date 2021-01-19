import 'services_eden.dart';

class DatabaseHelper {
  static final DatabaseHelper _helper = DatabaseHelper._internal();
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _helper;
  }

  Database _database;
  String _databasePath;
  String _path;
  bool _exists;

  Future _getDatabase() async {
    _databasePath = await getDatabasesPath();
    _path = join(_databasePath, 'myRocDB.db');
    _exists = await databaseExists(_path);

    if (!_exists) {
      try {
        await Directory(dirname(_path)).create(recursive: true);
      } catch (e) {}
      ByteData data = await rootBundle.load(join('assets', 'roc.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(_path).writeAsBytes(bytes, flush: true);
    } else {}
    _database = await openDatabase(_path);
  }

  Future getList() async {
    return await _getDatabase().then((value) {
      return _database.query('roc_buildings_queue');
    });
  }

  Future updateModel(ModelRoc model) async {
    return await _getDatabase().then((value) => _database.update(
        'roc_buildings_queue', model.toJson(),
        where: 'id = ?', whereArgs: [model.id]));
  }
}
