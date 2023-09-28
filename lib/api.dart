import 'package:http/http.dart' as http;
import 'dart:convert';

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se/todos';
const String KEY = '?key=e52bba1f-a6ba-4d46-8dc9-159681239f67';

class ApiTask {
  String taskName;
  bool isComplete;
  bool? isImportant;
  bool? isOneTime;
  bool? isWeekly;
  String? id;

  ApiTask(this.taskName, this.isComplete, [this.isImportant, this.isOneTime, this.isWeekly, this.id]);

  factory ApiTask.fromJson(Map<String, dynamic> json) {
    List<String> titleParts = (json['title'] as String).split('|');
    
    if (titleParts.length == 1) {
      return ApiTask(
        titleParts[0].trim(),
        json['done'],
      );
    }

    bool isImportant = titleParts[1].trim() == 'true';
    bool isOneTime = titleParts[2].trim() == 'true';
    bool isWeekly = titleParts[3].trim() == 'true';

    return ApiTask(
      titleParts[0].trim(),
      json['done'],
      isImportant,
      isOneTime,
      isWeekly,
      json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": '$taskName|${isImportant ?? false}|${isOneTime ?? false}|${isWeekly ?? false}',
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