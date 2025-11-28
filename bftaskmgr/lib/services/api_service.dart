import 'dart:convert';
import 'package:http/http.dart' as http;
import 'parse_service.dart';

class ApiService {
  static const String host = "parseapi.back4app.com";

  static Map<String, String> get headers => {
        "X-Parse-Application-Id": ParseConfig.appId,
        "X-Parse-REST-API-Key": ParseConfig.restKey,
        "Content-Type": "application/json"
      };

  // ---------- USER SIGNUP ----------
  static Future<bool> signup(String email, String password) async {
    final url = Uri.https(host, "/users");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "username": email,
        "password": password,
        "email": email,
      }),
    );

    return response.statusCode == 201;
  }

  // ---------- USER LOGIN ----------
  static Future<String?> login(String email, String password) async {
    final url = Uri.https(
      host,
      "/login",
      {
        "username": email,
        "password": password,
      },
    );

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["sessionToken"]; // save and reuse
    }

    print("LOGIN ERROR: ${response.statusCode} - ${response.body}");
    return null;
  }

  // ---------- CREATE TASK ----------
  static Future<bool> createTask(String sessionToken, String title) async {
    final h = {
      ...headers,
      "X-Parse-Session-Token": sessionToken,
    };

    final url = Uri.https(host, "/classes/Task");

    final response = await http.post(
      url,
      headers: h,
      body: jsonEncode({"title": title}),
    );

    return response.statusCode == 201;
  }

  // ---------- GET TASKS ----------
  static Future<List<dynamic>> getTasks(String sessionToken) async {
    final h = {
      ...headers,
      "X-Parse-Session-Token": sessionToken,
    };

    final url = Uri.https(host, "/classes/Task");

    final response = await http.get(url, headers: h);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["results"];
    }

    print("GET TASKS ERROR: ${response.statusCode}");
    return [];
  }

  // ---------- DELETE TASK ----------
  static Future<bool> deleteTask(String sessionToken, String objectId) async {
    final h = {
      ...headers,
      "X-Parse-Session-Token": sessionToken,
    };

    final url = Uri.https(host, "/classes/Task/$objectId");

    final response = await http.delete(url, headers: h);

    return response.statusCode == 200;
  }
}
