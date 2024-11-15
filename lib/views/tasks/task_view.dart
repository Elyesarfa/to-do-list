import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_list/extensions/space_exs.dart';
import 'package:todo_list/utils/app_colors.dart';
import 'package:todo_list/utils/app_str.dart';
import 'package:todo_list/views/home/widget/task_view_app_bar.dart';
import 'package:todo_list/views/tasks/components/rep_textfield.dart';
import 'package:todo_list/models/task.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // appbar
      appBar: const TaskViewAppBar(),

      // body
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // top side texts
              _buildTopSideTexts(textTheme),

              // main task view activity
              _buildMainTaskViewActivity(
                textTheme,
                context,
              ),

              // bottom side buttons
              _buildBottonSideButtons()
            ],
          ),
        ),
      ),
    );
  }

  // bottom side buttons
  Widget _buildBottonSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Save task
          MaterialButton(
            onPressed: () {
              final newTask = Task(
                title: titleTaskController.text,
                description: descriptionTaskController.text,
              );
              Navigator.of(context).pop(newTask);
              log("New Task Has Been Added!");
            },
            minWidth: 150,
            color: AppColors.primarycolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: const Text(
              AppStr.addTaskString,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // main task view activity
  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title of text field
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          // task title input
          RepTextField(
            controller: titleTaskController,
          ),

          10.h,

          // task description input
          RepTextField(
            controller: descriptionTaskController,
            isForDescription: true,
          ),
        ],
      ),
    );
  }

  // top side texts (App bar text)
  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // divider grey
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),

          // add new task or update task
          RichText(
            text: TextSpan(
              text: AppStr.addNewTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: AppStr.taskString,
                  style: TextStyle(fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
