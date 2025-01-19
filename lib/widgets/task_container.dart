import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final List task;
  final Function() editTask;
  final Function() deleteTask;
  final Function() completeTask;

  const TaskContainer({
    super.key,
    required this.deleteTask,
    required this.completeTask,
    required this.task,
    required this.editTask,
  });

  @override
  Widget build(BuildContext context) {
    bool descriptionActive = task[1] == '';
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 8),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: completeTask,
                child: task[2]
                    ? const Icon(
                  Icons.check_box,
                  size: 25,
                )
                    : const Icon(
                  Icons.check_box_outline_blank,
                  size: 25,
                ),
              ),
              Text(
                task[0],
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  decoration: task[2]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              InkWell(
                onTap: editTask,
                child: const Icon(
                  Icons.edit,
                ),
              ),
              InkWell(
                onTap: deleteTask,
                child: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          descriptionActive
              ? const SizedBox(
            height: 0,
            width: 0,
          )
              : Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.transparent,
                size: 25,
              ),
              Text(
                task[1],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.transparent,
                size: 25,
              ),
              Text(
                task[3],
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
