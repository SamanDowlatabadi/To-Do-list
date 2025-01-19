import 'package:hive_flutter/hive_flutter.dart';

class LocalDataBase {
  List toDoList = [];
  final _myBox = Hive.box('MyBox');

  void createInitialData() {
    toDoList = [
      ['Make Tutorial', 'YouTube C++', false, '15:45'],
      ['Do Exercise', '', true, '13:05'],
    ];
    updateDataBase();
  }

  bool nullCheck() {
    return _myBox.get('TODOLIST') == null;
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }

  void addNewTask(
      String taskName, String taskDescription, String taskDeadlines) {
    toDoList.add([taskName, taskDescription, false, taskDeadlines]);
    updateDataBase();
  }

  List readTaskData(int index) {
    return _myBox.get('TODOLIST')[index];
  }

  void deleteTask(int index) {
    toDoList.removeAt(index);
    updateDataBase();
  }

  void editTask(int index, String taskName, String taskDescription,
      String taskDeadlines) {
    toDoList[index][0] = taskName;
    toDoList[index][1] = taskDescription;
    toDoList[index][3] = taskDeadlines;
    updateDataBase();
  }

  void taskCompletion(int index) {
    toDoList[index][2] = !toDoList[index][2];
    updateDataBase();
  }

  int taskLength() {
    loadData();
    return toDoList.length;
  }

  int taskLeftCounter() {
    loadData();
    int taskLeft = 0;
    for (int i = 0; i < toDoList.length; i++) {
      if (toDoList[i][2] == false) {
        taskLeft += 1;
      }
    }
    return taskLeft;
  }
}
