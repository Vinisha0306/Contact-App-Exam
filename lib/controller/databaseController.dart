import 'package:flutter/material.dart';

import '../helper/databaseHelper.dart';
import '../model/databaseModel.dart';

class DbController extends ChangeNotifier {
  List<Contact> allContactData = [];

  DbController() {
    initData();
  }

  Future<void> initData() async {
    DbHelper.dbHelper.initDb();
    allContactData = await DbHelper.dbHelper.getAllData();
    print(allContactData[0].name);
    notifyListeners();
  }

  void insertData({required Contact contact}) {
    DbHelper.dbHelper.insertData(contact: contact);
    initData();
  }

  void deleteData({required Contact contact}) {
    DbHelper.dbHelper.deleteData(contact: contact);
    initData();
  }

  Future<void> updateData({required Contact contact, required int id}) async {
    await DbHelper.dbHelper.updataData(contact: contact, id: id);
    initData();
  }
}
