import 'dart:convert';
import 'package:http/http.dart' as http;
import 'parse_service.dart';

class TaskService {
  static Map<String, String> headers(String sessionToken) => {
        "X-Parse-Application-Id": ParseConfig.appId,
        "X-Parse-REST-API-Key": ParseConfig.restKey,
        "X-Parse-Session-Token": sessionToken,
        "Content-Type": "application/json",
      };

  /// Create Task
  static Future<Map<String, dynamic>> createTask(
      String title, String description, String sessionToken) async {
    final url = Uri.parse("${ParseConfig.baseUrl}/classes/Tasks");

    final response = await http.post(url,
        headers: headers(sessionToken),
        body: jsonEncode({
          "title": title,
          "description": description,
        }));

    return jsonDecode(response.body);
  }

  /// Get All Tasks
  static Future<List<dynamic>> getTasks(String sessionToken) async {
    final url = Uri.parse("${ParseConfig.baseUrl}/classes/Tasks");

    final response = await http.get(url, headers: headers(sessionToken));

    final data = jsonDecode(response.body);
    return data["results"] ?? [];
  }

  /// Update Task
  static Future<bool> updateTask(
      String objectId, String title, String description, String sessionToken) async {
    final url =
        Uri.parse("${ParseConfig.baseUrl}/classes/Tasks/$objectId");

    final response = await http.put(
      url,
      headers: headers(sessionToken),
      body: jsonEncode({
        "title": title,
        "description": description,
      }),
    );

    return response.statusCode == 200;
  }

  /// Delete Task
  static Future<bool> deleteTask(String objectId, String sessionToken) async {
    final url =
        Uri.parse("${ParseConfig.baseUrl}/classes/Tasks/$objectId");

    final response = await http.delete(url, headers: headers(sessionToken));

    return response.statusCode == 200;
  }
}
