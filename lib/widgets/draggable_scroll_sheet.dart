import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DraggableScrollSheet extends StatelessWidget {
  final Function() saveButtonFunction;
  final Function() closeModalBottomSheet;
  final Function() showTimePickerVoid;
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerTitle;
  final TextEditingController controllerDescription;
  final TextEditingController controllerDeadline;

  const DraggableScrollSheet({
    super.key,
    required this.saveButtonFunction,
    required this.formKey,
    required this.closeModalBottomSheet,
    required this.controllerTitle,
    required this.controllerDescription,
    required this.showTimePickerVoid,
    required this.controllerDeadline,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.949,
      builder: (context, controller) => Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, -5),
              blurRadius: 25,
            ),
          ],
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () => closeModalBottomSheet(),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 70,
                child: TextFormField(
                  cursorColor: Colors.black,
                  cursorErrorColor: Colors.black,
                  controller: controllerTitle,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Description (Optional)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 70,
                child: TextFormField(
                  cursorColor: Colors.black,
                  cursorErrorColor: Colors.black,
                  controller: controllerDescription,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'Deadline',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 70,
                child: TextFormField(
                  cursorColor: Colors.black,
                  cursorErrorColor: Colors.black,
                  onTap: () => showTimePickerVoid(),
                  controller: controllerDeadline,
                  readOnly: true,
                  decoration: const InputDecoration(
                    focusColor: Colors.amber,
                    hoverColor: Colors.amber,
                    suffixIcon: Icon(CupertinoIcons.clock),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Deadline';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => saveButtonFunction(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
