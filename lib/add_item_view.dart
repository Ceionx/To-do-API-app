import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider.dart';
import './api.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final addTaskController = TextEditingController();
    bool weeklyTask = context.watch<MyState>().weeklyTask;
    bool oneTimeTask = context.watch<MyState>().oneTimeTask;
    bool importantTask = context.watch<MyState>().importantTask;

    return Scaffold(
      appBar: AppBar(title: Text('Lägg till en uppgift'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary
      ),
    body: Center(
      child: Container(
        color: Colors.amber[50],
        padding: EdgeInsets.only(top: 25, left: 50, right: 50),
        child: Column(
          children: [ TextField(
            maxLength: 30,
            controller: addTaskController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Vad är din nya uppgift?',
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Switch(value: importantTask, onChanged: (bool value) {
                  context.read<MyState>().toggleImportantTask(value);
                },
                  thumbIcon: MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Icon(Icons.check);
                    }
                      return Icon(Icons.close);
                  },
                ),
                ),
                Text("Viktig uppgift", style: TextStyle(fontSize: 14, decoration: importantTask ? TextDecoration.none : TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 40),
            child: Row(
              children: [
                Switch(value: weeklyTask, onChanged: importantTask ? null : (bool value) {
                  context.read<MyState>().toggleWeeklyTask(value);
                },
                  thumbIcon: MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Icon(Icons.event_repeat);
                    }
                    return Icon(Icons.looks_one);
                  },
                  ),
                ),
                if(!weeklyTask) Text("Engångs-uppgift", style: TextStyle(fontSize: 14),
                  ),
                if(weeklyTask) Text("Återkommande uppgift", style: TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: FloatingActionButton(
                  onPressed: () async {
                    if (addTaskController.text != '')
                    {ApiTask task = ApiTask(addTaskController.text, false, importantTask, oneTimeTask, weeklyTask);
                    context.read<MyState>().addTask(task, addTaskController.text);
                    Navigator.pop(context);}
                    else {
                      context.read<MyState>().textAlertButton(context);
                      }
                  },
                  tooltip: 'Skapa uppgiften',
                  child: Text('Skapa uppgiften'),
                ),
              ),
            ],
          ),
          ]
          ),
        ),
    ),
    );
  }
}