import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/token/login/',
        data: {'username': username, 'password': password},
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String username, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/token/register/',
        data: {'username': username, 'password': password},
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to register');
    }
  }

  Future<List<Map<String, dynamic>>> getNotes(String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/api/notes/',
        options: Options(
          headers: {'Authorization': 'Token $token'},
        ),
      );
      return List<Map<String, dynamic>>.from(response.data);
    } catch (error) {
      throw Exception('Failed to fetch notes');
    }
  }

  Future<void> deleteNote(String token, int id) async {
    try {
      await _dio.delete(
        '$baseUrl/api/notes/$id/delete/',
        options: Options(
          headers: {'Authorization': 'Token $token'},
        ),
      );
    } catch (error) {
      throw Exception('Failed to delete note');
    }
  }

  Future<Map<String, dynamic>> getUserData(String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/auth/users/me/',
        options: Options(
          headers: {'Authorization': 'Token $token'},
        ),
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch user data');
    }
  }
}
