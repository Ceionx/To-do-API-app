import 'package:flutter/material.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lägg till en uppgift'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    body: Container(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: TextField(
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
          Text('Lägg till'),
          Icon(Icons.add)
        ],)
        ]
        ),
      ),
    );
  }
}