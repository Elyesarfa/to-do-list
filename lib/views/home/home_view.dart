import 'package:flutter/material.dart';
import 'package:todo_list/extensions/space_exs.dart';
import 'package:todo_list/utils/app_colors.dart';
import 'package:todo_list/utils/app_str.dart';
import 'package:todo_list/views/home/components/fab.dart';
import 'package:todo_list/views/home/widget/task_widget.dart';
import 'package:todo_list/models/task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // List of tasks
  List<Task> tasks = [];
  // Method to handle adding a new task
  void _onTaskAdded(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  // Method to toggle task completion (check/uncheck)
  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;

    // Calculate completion percentage
    int completedTasks = tasks
        .where((task) => task.isCompleted)
        .length;
    double completionPercentage =
    tasks.isEmpty ? 0.0 : (completedTasks / tasks.length);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Fab(onTaskAdded: _onTaskAdded),

      // Body of the HomeView
      body: _buildHomeBody(textTheme, completedTasks, completionPercentage),
    );
  }

  /// Home body
  Widget _buildHomeBody(TextTheme textTheme, int completedTasks,
      double completionPercentage) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [

          /// Custom app bar
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// Circular progress indicator showing task completion
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: completionPercentage,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                      const AlwaysStoppedAnimation(
                          AppColors.primarycolor),
                      strokeWidth: 5,
                    ),
                  ),
                ),

                /// Title with task completion percentage
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    3.h,
                    Text(
                      "$completedTasks of ${tasks.length} task${tasks.length > 1
                          ? 's'
                          : ''}",
                      style: textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          /// Conditional message when there are no tasks
          if (tasks.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.edit,
                      size: 50,
                      color: AppColors
                          .primarycolor,
                    ),
                    const SizedBox(height: 20),
                    // Add space between the icon and the text
                    Text(
                      'NO TASKS YET.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        // Slightly dark text for visibility
                        fontSize: 36,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    // Add space between text and subtext
                    Text(
                      'Tap the "+" button to add a new task!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else

          /// Tasks list
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    onDismissed: (_) {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    background: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.grey,
                        ),
                        Text(
                          AppStr.deleteTask,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    key: Key(task.title),
                    // Ensure you use a unique key
                    child: TaskWidget(
                      task: task, // Pass the Task object here
                      onTaskCompleted: _toggleTaskCompletion,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}