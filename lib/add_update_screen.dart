import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_app/db_handler.dart';
import 'package:todo_app/model.dart';

class AddUpdateTask extends StatefulWidget {
  const AddUpdateTask({super.key});

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
