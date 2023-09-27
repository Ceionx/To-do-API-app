import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main.dart';
import './task_item.dart';
import './add_item_view.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var filteredItems = context.watch<MyState>().filteredItems;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text('Att göra-listan'),
            ),
            PopupMenuButton<TaskFilter>(
              onSelected: (TaskFilter choice) {
                context.read<MyState>().setFilter(choice);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<TaskFilter>>[
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.completed,
                  child: Text('Visa avklarade uppgifter'),
                ),
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.uncompleted,
                  child: Text('Visa ofärdiga uppgifter'),
                ),
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.all,
                  child: Text('Visa alla uppgifter'),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            return TaskItem(
              task: filteredItems[index],
              onChanged: (value) {context.read<MyState>().updateTask(index, filteredItems[index]);
            },
            onDelete: () {
              context.read<MyState>().deleteAlertButton(context, index, filteredItems[index].taskName);
            },
          );
        },
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