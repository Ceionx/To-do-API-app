import 'package:flutter/material.dart';
import './api.dart';

// ignore: must_be_immutable
class TaskItem extends StatelessWidget {
  final ApiTask task;
  bool? isOneTime;
  bool? isWeekly;
  bool? isImportant;

  Function(bool?)? onChanged;
  Function()? onDelete;

  TaskItem({
    super.key,
    required this.task, 
    this.isOneTime,
    this.isWeekly,
    this.isImportant,
    this.onChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( top: 2.5, bottom: 2.5),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.amber[100], borderRadius: BorderRadius.circular(5),
          ),
        child: Row(
          children: [
            Checkbox(value: task.isComplete, onChanged: (value) {onChanged?.call(value);},
            ),
            Expanded(
              child: Text(task.taskName, style: TextStyle(fontSize: 14, decoration: task.isComplete ? TextDecoration.lineThrough : TextDecoration.none),
              ),
            ),
            IconButton(icon: Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}