import 'package:flutter/material.dart';
import 'package:todo_app/add_update_screen.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "App",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              "Notas",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
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
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: dataList,
            builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.length == 0) {
                return Center(
                  child: Text(
                    " NINGUNA NOTA",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    int todoId = snapshot.data![index].id!.toInt();
                    String todoTitle = snapshot.data![index].title.toString();
                    String todoDdesc = snapshot.data![index].desc.toString();
                    String todoDT =
                        snapshot.data![index].dateandtime.toString();
                    return Dismissible(
                      key: ValueKey<int>(todoId),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.redAccent,
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          dbHelper!.delete(todoId);
                          dataList = dbHelper!.getDataList();
                          snapshot.data!.remove(snapshot.data![index]);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 180, 228, 244),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  todoTitle,
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                              subtitle: Text(
                                todoDdesc,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 0.8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todoDT,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddUpdateTask(
                                              todoId: todoId,
                                              todoTitle: todoTitle,
                                              todoDesc: todoDdesc,
                                              todoDT: todoDT,
                                              update: true,
                                            ),
                                          ));
                                    },
                                    child: Icon(
                                      Icons.edit_note,
                                      size: 50,
                                      color: Color.fromARGB(255, 11, 11, 11),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AddUpdateTask())));
            },
          ),
        ],
      ),
    );
  }
}
