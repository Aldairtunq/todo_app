import 'package:flutter/material.dart';
import 'package:todo_app/db_handler.dart';
import 'package:todo_app/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "DP-TODO",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.help_outline_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: dataList,
          builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center();
            }
          },
        ))
      ]),
    );
  }
}
