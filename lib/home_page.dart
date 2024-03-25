import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider.dart';
import './add_item_view.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var importantCount = context.watch<MyState>().importantCount;
    var weeklyCount = context.watch<MyState>().weeklyCount;
    var oneTimeCount = context.watch<MyState>().oneTimeCount;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('Att göra-listan'),
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
      body: Container(
        height: 700,
        color: Colors.amber[50],
        child: ListView(
          children: [
            ExpansionTile(
              backgroundColor: Colors.amber[50],
              collapsedBackgroundColor: Colors.amber[200],
              initiallyExpanded: true,
              title: Text('$importantCount Viktiga uppgifter', style: TextStyle(decoration: TextDecoration.underline)),
              children: context.watch<MyState>().buildTaskItems(context, TaskType.important),
            ),
            ExpansionTile(
              backgroundColor: Colors.amber[50],
              collapsedBackgroundColor: Colors.amber[200],
              initiallyExpanded: true,
              title: Text('$oneTimeCount Engångs-uppgifter', style: TextStyle(decoration: TextDecoration.underline)),
              children: context.watch<MyState>().buildTaskItems(context, TaskType.oneTime),
            ),
            ExpansionTile(
              backgroundColor: Colors.amber[50],
              collapsedBackgroundColor: Colors.amber[200],
              initiallyExpanded: true,
              title: Text('$weeklyCount Återkommande uppgifter', style: TextStyle(decoration: TextDecoration.underline)),
              children: context.watch<MyState>().buildTaskItems(context, TaskType.weekly),
            ),
          ],
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
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemView()));
          },
          tooltip: 'Lägg till ny uppgift',
          child: Text('Lägg till en ny uppgift'),
        ),
      ),
    ],
  );
}
}