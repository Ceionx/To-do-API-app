import 'package:flutter/material.dart';
import 'home_page.dart';
import 'task_item.dart';
import 'package:provider/provider.dart';

enum TaskFilter {
  completed,
  uncompleted,
  all,
}

class MyState extends ChangeNotifier {
  final List<TaskItem> _items = [
      TaskItem(taskName: 'Styrketräning', isComplete: true),
      TaskItem(taskName: 'Boka resa', isComplete: true),
      TaskItem(taskName: 'Skriva färdigt uppsatsen', isComplete: false),
      TaskItem(taskName: 'Mata guldfiskarna', isComplete: false),
      TaskItem(taskName: 'Lösa programmeringsuppgiften', isComplete: false),
      TaskItem(taskName: 'Mata guldfiskarna', isComplete: false),
      TaskItem(taskName: 'Lösa programmeringsuppgiften', isComplete: false),
    ];

  TaskFilter selectedFilter = TaskFilter.all;

  List<TaskItem> get filteredItems {
    if (selectedFilter == TaskFilter.completed) {
      return _items.where((item) => item.isComplete).toList();
    } else if (selectedFilter == TaskFilter.uncompleted) {
      return _items.where((item) => !item.isComplete).toList();
    } else {
      return _items;
    }
  }

  void setFilter(TaskFilter filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void taskUpdated(int index) {
    int itemIndex = _items.indexOf(filteredItems[index]);
    _items[itemIndex].isComplete = !_items[itemIndex].isComplete;
    notifyListeners();
  }

  void addTask(String name) {
    if (name != '') {_items.add(TaskItem(taskName: name, isComplete: false));}
    notifyListeners();
  }

  void deleteTask(int index) {
    int itemIndex = _items.indexOf(filteredItems[index]);
    _items.removeAt(itemIndex);
    notifyListeners();
  }  
}

void main() {
  MyState state = MyState();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}