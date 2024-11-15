import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/views/tasks/task_view.dart';
import '../../../models/task.dart';
import '../../../utils/app_colors.dart';

class Fab extends StatelessWidget {
  final void Function(Task) onTaskAdded;

  const Fab({super.key, required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => const TaskView(),
          ),
        );
        if (result is Task) {
          onTaskAdded(result);
        }
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}