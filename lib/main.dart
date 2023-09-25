import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';
import './home_page.dart';

enum TaskFilter {
  completed,
  uncompleted,
  all,
}

class MyState extends ChangeNotifier {
  List<ApiTask> _items = [];

  List<ApiTask> get items => _items;

  MyState() {     // Fetch the list at start-up
    fetchList();
  }

  void fetchList() async {    // Fetch the list from API and update _items list
    var items = await apiGetList();
    _items = items;
    notifyListeners();
  }

  void updateTask(int index, ApiTask task) async {    // Checking/unchecking the checkboxes of tasks
    int itemIndex = _items.indexOf(filteredItems[index]);
    var itemID = _items[itemIndex].id;
    await apiUpdateTask(task, itemID);
    fetchList();
  }

  void addTask(ApiTask task, name) async {    // Adding tasks
    await apiAddTask(task, name);
    fetchList();
  }

  void deleteTask(int index) async {    // Removing tasks
    int itemIndex = _items.indexOf(filteredItems[index]);
    var itemID = _items[itemIndex].id;
    await apiDeleteTask(itemID);
    fetchList();
  }

  Widget alertButton(context) {   // Pop-up window when user doesn't give any input in TextField
    Widget confirmButton = TextButton(child: Text('Ok'),
      onPressed: () => Navigator.pop(context, )
      ,);
    AlertDialog alert = AlertDialog(
      title: Text('Felmeddelande'),
      content: Text('Du måste fylla i en text för uppgiften.'),
      actions: [
        confirmButton,
      ],
    );
    showDialog(context: context, builder: (BuildContext context){return alert;});
    return alert;
  }

  // Filtering tasks by completed, uncompleted or show all

  TaskFilter selectedFilter = TaskFilter.all;
  
  void setFilter(TaskFilter filter) {
      selectedFilter = filter;
      notifyListeners();
    }

  List<ApiTask> get filteredItems {
    if (selectedFilter == TaskFilter.completed) {
      return _items.where((item) => item.isComplete).toList();
    } else if (selectedFilter == TaskFilter.uncompleted) {
      return _items.where((item) => !item.isComplete).toList();
    } else {
      return _items;
    }
  }

}

  // Main Code

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