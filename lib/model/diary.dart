import 'package:crud_sqlite_app/data_base/crud.dart';
import 'package:crud_sqlite_app/data_base/tables.dart';

class Diary extends Crud {
  int id;
  String type;
  String enterCode;

  Diary({
    this.id = 0,
    this.type = "",
    this.enterCode = "",
  }) : super(diaryTable);

  @override
  String toString() {
    return "Id: $id\nType: $type,\nEnterCode: $enterCode";
  }

  Map<String, dynamic> _toMap() {
    return {
      "id": id > 0 ? id : null,
      "type": type,
      "enterCode": enterCode,
    };
  }

  Diary _toObject(Map<dynamic, dynamic> data) {
    return Diary(
      id: data["id"],
      type: data["type"],
      enterCode: data["enterCode"],
    );
  }

  Future<int> save() async {
    return await ((id > 0) ? update(_toMap()) : create(_toMap()));
  }

  Future<int> remove() async {
    return await delete(id);
  }

  Future<List<Diary>> getDiaries() async {
    var result = await query("SELECT * FROM $diaryTable");
    return _getListObjects(result);
  }

  List<Diary> _getListObjects(List parsed) {
    return parsed.map((e) => _toObject(e)).toList();
  }

  Future<Diary> checkEnterCode() async {
    var result = await query(
      "SELECT * FROM $diaryTable WHERE id=? AND enterCode=?",
      args: [id, enterCode],
    );

    return _toObject(result[0]);
  }
}
