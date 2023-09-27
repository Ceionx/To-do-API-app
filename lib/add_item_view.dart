import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main.dart';
import './api.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final addTaskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Lägg till en uppgift'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary
      ),
    body: Container(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 300,
            child: TextField(
              maxLength: 20,
              controller: addTaskController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Vad är din nya uppgift?',
              )
            ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          IconButton(color: Theme.of(context).colorScheme.inversePrimary, iconSize: 52, 
            onPressed: () async {
              if (addTaskController.text != '') 
              {ApiTask task = ApiTask(addTaskController.text, false);
              context.read<MyState>().addTask(task, addTaskController.text);
              Navigator.pop(context);}
              else {
                context.read<MyState>().textAlertButton(context);
              }
            }, 
          icon: Icon(Icons.add))
            ],
          )
        ]
        ),
      ),
    );
  }
}