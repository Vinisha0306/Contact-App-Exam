import 'package:sqflite/sqflite.dart';

import '../model/databaseModel.dart';

enum StudentTable { id, name, contact }

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();

  String sql = '';
  String dbName = "my_dataBase";
  String tableName = "Student";

  late Database database;

  Future<void> initDb() async {
    String path = await getDatabasesPath();

    database = await openDatabase(
      "$path/$tableName",
      version: 1,
      onCreate: (db, version) {
        String query =
            """create table if not exists $tableName (${StudentTable.id.name} integer primary key autoincrement,
                          ${StudentTable.name.name} text not null,
                          ${StudentTable.contact.name} text unique
                          )""";

        db
            .execute(query)
            .then(
              (value) => print("Table Create successfully"),
            )
            .onError(
              (error, stackTrace) => print("ERROR : $error"),
            );
      },
    );
  }

  Future<void> insertData({required Contact contact}) async {
    sql = "insert into $tableName(name,contact) values(?,?)";
    List args = [
      contact.name,
      contact.contact,
    ];
    await database.rawInsert(sql, args);
  }

  Future<void> updataData({required Contact contact, required int id}) async {
    await database
        .update(tableName, contact.getContact, where: 'id = $id')
        .then(
          (value) => print('updated'),
        )
        .onError((error, stackTrace) => 'error : $error');
  }

  Future<void> deleteData({required Contact contact}) async {
    await database
        .delete(
          tableName,
          where: "id=?",
          whereArgs: [contact.id],
        )
        .then(
          (value) => print('Deleted'),
        )
        .onError(
          (error, stackTrace) => print('Error : $error'),
        );
  }

  Future<List<Contact>> getAllData() async {
    List<Contact> allContact = [];

    sql = "select * from $tableName;";
    List Data = await database.rawQuery(sql);
    allContact = Data.map((e) => Contact.fromSQL(data: e)).toList();

    return allContact;
  }
}
