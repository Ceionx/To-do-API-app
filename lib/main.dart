import 'package:flutter/material.dart';
import 'add_item.dart';
import 'list_item.dart';
import 'add_item_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      useMaterial3: true,),
      home: ToDoList());
  }
}

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<TaskItem> items = [
      TaskItem('Styrketräning'),
      TaskItem('Boka resa'),
      TaskItem('Skriva färdigt uppsatsen'),
      TaskItem('Mata guldfiskarna'),
      TaskItem('Lösa programmeringsuppgiften'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('To-Do listan')),
            Icon(Icons.menu),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          itemBuilder: (context, index) {
            //return _listItem(context, items[index]);
            return ListItem(items[index]);
          },
          itemCount: items.length,
        ),
      ),
      floatingActionButton: _addItemButton(context)
      );
  }

  Widget _addItemButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
              width: 275,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemView()));
                },
                tooltip: 'Lägg till ny uppgift',
                child: Text('Lägg till en ny uppgift'),
              ),
            ),
      ],
    );
    }
}