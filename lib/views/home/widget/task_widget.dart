import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final void Function(Task) onTaskCompleted;

  const TaskWidget({
    super.key,
    required this.task,
    required this.onTaskCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle completion status when clicked
        onTaskCompleted(task);
      },
      child: AnimatedContainer(
        margin:
        const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.primarycolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        duration:
        const Duration(
            milliseconds: 300,
        ),
        child: ListTile(
          leading: Icon(
            task.isCompleted
                ? Icons.check_circle :
            Icons.radio_button_unchecked,
            color: task.isCompleted
                ? AppColors.primarycolor : Colors.grey,
          ),
          title: Text(
            task.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            task.description,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w300,
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
