import 'package:crud_sqlite_app/data_base/tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  int version = 1;
  String name = "myDiary";

  Future<Database> open() async {
    String path = join(await getDatabasesPath(), name);
    return openDatabase(
      path,
      version: version,
      onConfigure: onConfigure,
      onCreate: onCreate,
    );
  }

  onCreate(Database db, int version) async {
    for (var table in tables) {
      await db.execute(table);
    }
  }

  onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }
}
