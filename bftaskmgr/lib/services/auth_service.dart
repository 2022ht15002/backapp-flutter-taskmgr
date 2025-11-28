import 'dart:convert';
import 'package:http/http.dart' as http;
import 'parse_service.dart';

class AuthService {
  static Map<String, String> get headers => {
        "X-Parse-Application-Id": ParseConfig.appId,
        "X-Parse-REST-API-Key": ParseConfig.restKey,
        "Content-Type": "application/json",
      };

  /// Register User
  static Future<Map<String, dynamic>> signup(
      String email, String password) async {
    final url = Uri.parse("${ParseConfig.baseUrl}/users");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "username": email,
        "password": password,
        "email": email,
      }),
    );

    return jsonDecode(response.body);
  }

  /// Login User
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse("${ParseConfig.baseUrl}/login");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "username": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Login failed: ${response.statusCode}, ${response.body}");
      return null;
    }
  }


  /// Logout
  static Future<bool> logout(String sessionToken) async {
    final url = Uri.parse("${ParseConfig.baseUrl}/logout");

    final response = await http.post(
      url,
      headers: {
        ...headers,
        "X-Parse-Session-Token": sessionToken,
      },
    );

    return response.statusCode == 200;
  }
}
