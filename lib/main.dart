import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';
import './home_page.dart';
import './task_item.dart';

enum TaskFilter {
  completed,
  uncompleted,
  all,
}

enum TaskType {
  important,
  oneTime,
  weekly,
}

class MyState extends ChangeNotifier {
  List<ApiTask> _items = [];
  List<ApiTask> get items => _items;

  MyState() {     // Fetch the list at start-up
    fetchList();
  }

  bool _weeklyTask = false;
  bool get weeklyTask => _weeklyTask;

  bool _importantTask = false;
  bool get importantTask => _importantTask;

  bool _oneTimeTask = true;
  bool get oneTimeTask => _oneTimeTask;

  int importantCount = 0;
  int weeklyCount = 0;
  int oneTimeCount = 0;

  void toggleWeeklyTask(bool value) {
    if (_importantTask) {_weeklyTask = false;} 
    else {_weeklyTask = value;}
    _oneTimeTask = !_weeklyTask;
    notifyListeners();
  }

  void toggleImportantTask(bool value) {
    _importantTask = value;
    if (value) {
      _weeklyTask = false;
      _oneTimeTask = false;
    } else {toggleWeeklyTask(value);}
    notifyListeners();
  }

  void fetchList() async {    // Fetch the list from API and update local list of tasks
    var items = await apiGetList();
    _items = items;
    importantCount = 0;
    weeklyCount = 0;
    oneTimeCount = 0;
    for (var item in _items) {
      if (item.isImportant ?? false) {importantCount++;}
      if (item.isWeekly ?? false) {weeklyCount++;}
      if (item.isOneTime ?? false) {oneTimeCount++;}
    }
    notifyListeners();
  }

  void updateTask(ApiTask task) async {    // Checking/unchecking the checkboxes of tasks
    var itemID = task.id;
    await apiUpdateTask(task, itemID);
    fetchList();
  }

  void addTask(ApiTask task, name) async {
    await apiAddTask(task, name);
    fetchList();
  }

  void deleteTask(ApiTask task, context) async {
    var itemID = task.id;
    await apiDeleteTask(itemID);
    Navigator.pop(context);
    fetchList();
  }

  Widget deleteAlertButton(context, item, taskName) {
    Widget confirmButton = TextButton(child: Text('Ja'),
      onPressed: () => deleteTask(item, context));
    Widget cancelButton = TextButton(child: Text('Ångra'),
      onPressed: () => Navigator.pop(context));
    AlertDialog alert = AlertDialog(
      title: Text('Radera uppgift'),
      content: Text('Är du säker på att du vill ta bort uppgiften:\n- $taskName?'),
      actions: [
        Row(children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 115),
            child: confirmButton,
              ),
            cancelButton,
          ]
        ),
      ]
    );
    showDialog(context: context, builder: (BuildContext context){return alert;});
      return alert;
  }

  Widget textAlertButton(context) {   // Pop-up window when user doesn't give any input in TextField
    Widget confirmButton = TextButton(child: Text('Ok'),
      onPressed: () => Navigator.pop(context),
      );
    AlertDialog alert = AlertDialog(
      title: Text('Felmeddelande'),
      content: Text('Du måste fylla i en text för uppgiften.'),
      actions: [confirmButton],
    );
    showDialog(context: context, builder: (BuildContext context){return alert;});
      return alert;
  }

  List<Widget> buildTaskItems(BuildContext context, TaskType taskType) {
    var taskTypeItems = filteredItems.where((item) {
      switch (taskType) {
        case TaskType.important:
          return item.isImportant ?? false;
        case TaskType.oneTime:
          return item.isOneTime ?? false;
        case TaskType.weekly:
          return item.isWeekly ?? false;
        default: 
          return false;
        }
      }
    ).toList();

      return taskTypeItems.map((item) {
        return TaskItem(
          task: item,
          onChanged: (value) {updateTask(item);},
          onDelete: () {deleteAlertButton(context, item, item.taskName);},
        );
      }
    ).toList();
  }

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
    } else {return _items;}
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