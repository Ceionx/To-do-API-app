import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String taskName; 
  bool isComplete;
  Function(bool?)? onChanged;
  Function()? onDelete;

  TaskItem({
    super.key,
    required this.taskName, 
    required this.isComplete, 
    this.onChanged,
    this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.amber[100], borderRadius: BorderRadius.circular(10),
          ),
        child: Row(
          children: [
            Checkbox(value: isComplete, onChanged: (value) {onChanged?.call(value);},
            ),
            Expanded(
              child: Text(taskName, style: TextStyle(fontSize: 18, decoration: isComplete ? TextDecoration.lineThrough : TextDecoration.none),
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