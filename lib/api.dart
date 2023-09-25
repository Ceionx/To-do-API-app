import 'package:http/http.dart' as http;
import 'dart:convert';

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se/todos';
const String KEY = '?key=2e55d5dd-fa72-4093-9582-f85b124e893b';

class ApiTask {
  String taskName;
  bool isComplete;
  String? id;

  ApiTask(this.taskName, this.isComplete, [this.id]);

  factory ApiTask.fromJson(Map<String, dynamic> json) {
    return ApiTask( 
      json['title'], 
      json['done'] ?? false,
      json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": taskName,
      "done": isComplete,
      "id": id,
    };
  }
}

Future<List<ApiTask>> apiGetList() async {
  http.Response response = await http.get(Uri.parse('$ENDPOINT$KEY'));
  String body = response.body;
  List<dynamic> tasksJson = jsonDecode(body);
  return tasksJson.map((json) => ApiTask.fromJson(json)).toList();
}

Future<void> apiAddTask(ApiTask task, String name) async {
  await http.post(Uri.parse('$ENDPOINT$KEY'),
  headers: {"Content-Type": "application/json"},
  body: jsonEncode(task.toJson()),
  );
}

Future<void> apiDeleteTask(id) async {
  await http.delete(Uri.parse('$ENDPOINT/$id$KEY'));
}

Future<void> apiUpdateTask(ApiTask task, id) async {
  task.isComplete = !task.isComplete;
  await http.put(Uri.parse('$ENDPOINT/$id$KEY'),
  headers: {"Content-Type": "application/json"},
  body: jsonEncode(task.toJson())
  );
}