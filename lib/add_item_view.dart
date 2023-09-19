import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/main.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();

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
          child: TextField(
            maxLength: 30,
            controller: myController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Vad är din nya uppgift?',
            )
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          IconButton(color: Theme.of(context).colorScheme.inversePrimary, iconSize: 52, onPressed: () {
            context.read<MyState>().addTask(myController.text);
            if (myController.text != '') Navigator.pop(context);
          }, icon: Icon(Icons.add))
        ],)
        ]
        ),
      ),
    );
  }
}