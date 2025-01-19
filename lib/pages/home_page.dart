import 'package:flutter/material.dart';
import 'package:to_do_list/data/local_database.dart';
import 'package:to_do_list/widgets/app_bar.dart';
import 'package:to_do_list/widgets/task_container.dart';
import '../widgets//draggable_scroll_sheet.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // create an instance
  final LocalDataBase db = LocalDataBase();

  final formKey = GlobalKey<FormState>();

  // initialize controller for text fields
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerDeadline = TextEditingController();

  // The first state the user sees
  @override
  void initState() {
    if (db.nullCheck()) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // clear the controllers
  void clearControllers() {
    _controllerDeadline.clear();
    _controllerDescription.clear();
    _controllerTitle.clear();
  }

  // customized time picker
  void showTimePickerVoid() {
    showTimePicker(
      barrierColor: Colors.white,
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            textTheme: const TextTheme(
              bodySmall: TextStyle(color: Colors.white),
            ),
            colorScheme: const ColorScheme.dark(
              primary: Colors.black,
              onSurface: Colors.white,
            ),
            timePickerTheme: TimePickerThemeData(
              dayPeriodBorderSide:
              const BorderSide(color: Colors.black, width: 0),
              dayPeriodColor: Colors.white,
              dialHandColor: Colors.white,
              dialBackgroundColor: Colors.black,
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: const BorderSide(color: Colors.black, width: 0),
              ),
              backgroundColor: Colors.black,
              hourMinuteColor: Colors.white,
              hourMinuteTextColor: Colors.black,
              confirmButtonStyle: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              cancelButtonStyle: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              entryModeIconColor: Colors.white,
              helpTextStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _controllerDeadline.text = value!.format(context).toString();

      });
    });
  }

  // add a new task function
  void addTask() {
    showModalBottomSheet(
      showDragHandle: false,
      useSafeArea: true,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => DraggableScrollSheet(
        saveButtonFunction: () {
          setState(() {
            if (formKey.currentState!.validate() == true) {
              db.addNewTask(_controllerTitle.text, _controllerDescription.text,
                _controllerDeadline.text,);
            }
          });
          clearControllers();
          Navigator.of(context).pop();
        },
        formKey: formKey,
        closeModalBottomSheet: () {clearControllers();
        Navigator.of(context).pop();
        db.updateDataBase();},
        controllerTitle: _controllerTitle,
        controllerDescription: _controllerDescription,
        showTimePickerVoid: () => showTimePickerVoid(),
        controllerDeadline: _controllerDeadline,
      ),
    );
  }

  // open model bottom sheet to a specific edit task
  void editTask(int index) {
    _controllerTitle.text = db.readTaskData(index)[0];
    _controllerDescription.text = db.readTaskData(index)[1];
    _controllerDeadline.text = db.readTaskData(index)[3];
    showModalBottomSheet(
      showDragHandle: false,
      useSafeArea: true,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => DraggableScrollSheet(
        saveButtonFunction: () {
          setState(() {
            if (formKey.currentState!.validate() == true) {
              db.editTask(index, _controllerTitle.text,
                _controllerDescription.text, _controllerDeadline.text,);
            }
          });
          clearControllers();
          Navigator.of(context).pop();
        },
        formKey: formKey,
        closeModalBottomSheet: () {
          clearControllers();
          Navigator.of(context).pop();
          db.updateDataBase();
        },
        controllerTitle: _controllerTitle,
        controllerDescription: _controllerDescription,
        showTimePickerVoid: () => showTimePickerVoid(),
        controllerDeadline: _controllerDeadline,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('You have ${db.taskLeftCounter()} task left.'),
                  ],
                ),
                ElevatedButton(
                  onPressed: addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text('Add Task'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: db.taskLength(),
                itemBuilder: (context, index) {
                  return TaskContainer(
                    task: db.readTaskData(index),
                    deleteTask: () {
                      setState(() {
                        db.deleteTask(index);
                      });
                    },
                    completeTask: () {
                      setState(() {
                        db.taskCompletion(index);

                      });
                      db.updateDataBase();
                    },
                    editTask: () => editTask(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
