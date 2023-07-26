import 'package:todo/model/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

final myBox = Hive.box('mybox');

class Database {
  List<Todo> works = [];
  void createOnInit() {
    works = [];
  }

  void loadDataBase() {
    works = myBox.get('WORKS').cast<Todo>();
  }

  void updateDataBase() {
    myBox.put('WORKS', works);
  }
}
