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

  final _fromkey = GlobalKey<FormState>();

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
    final titleController = TextEditingController();
    final descController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add/update/ Task",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _fromkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Note Title",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter some text";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
