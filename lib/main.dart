import 'package:flutter/material.dart';
import 'package:todo/database/todo_database.dart';
import 'package:todo/widgets/alert_box.dart';
import 'package:todo/widgets/contents.dart';
import './model/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDoList',
      theme: ThemeData(
        //primarySwatch: Colors.purple,
        colorScheme: const ColorScheme.light().copyWith(
          secondary: Colors.white,
          primary: Colors.amber,
        ),
      ),
      home: const ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final myBox = Hive.box('mybox');
  Database db = Database();

  @override
  void initState() {
    if (myBox.get('WORKS') == null) {
      db.createOnInit();
    } else {
      db.loadDataBase();
    }
    super.initState();
  }

  void _removeItem(String id) {
    setState(() {
      db.works.removeWhere((element) => element.id == id);
    });
    db.updateDataBase();
  }

  void _addItem(String activity) {
    setState(() {
      db.works.insert(
        0,
        Todo(
          date: DateTime.now(),
          title: activity,
          ischecked: false,
          id: DateTime.now().toString(),
        ),
      );
    });
    db.updateDataBase();
  }

  void _replaceItem(String activity, String id) {
    setState(() {
      db.works[db.works.indexWhere((element) => element.id == id)] = Todo(
        date: DateTime.now(),
        title: activity,
        ischecked: false,
        id: DateTime.now().toString(),
      );
    });
    db.updateDataBase();
  }

  void _showDialog(int flag, String id) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertBox(
            addItem: _addItem,
            replaceItem: _replaceItem,
            flag: flag,
            id: id,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: const Text('To Do List'),
        backgroundColor: Colors.purple[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: db.works.length,
                itemBuilder: (context, index) {
                  return Contents(
                    works: db.works[index],
                    removeItems: _removeItem,
                    showDialog: _showDialog,
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.orange,
        backgroundColor: Colors.amber[600],
        onPressed: () => _showDialog(0, ''),
        child: const Icon(
          Icons.add_alert_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
