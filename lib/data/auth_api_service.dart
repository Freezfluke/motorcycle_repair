import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motorcycle_repair/domain/models/user.dart';
import '../domain/models/auth.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthApiService implements AuthRepository {
  final String baseUrl = 'http://localhost:3000';

  @override
  Future<Auth> login(String email, String password) async {
    return Auth(token: 'adadasdasdasdasdasd');
    // final response = await http.post(
    //   Uri.parse('$baseUrl/login'),
    //   body: {'email': email, 'password': password},
    // );

    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   return Auth(token: json['token']);
    // } else {
    //   throw Exception('Login failed');
    // }
  }

  @override
  Future<Auth> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Auth(token: json['token']);
    } else {
      throw Exception('Register failed');
    }
  }

  @override
  Future<User> getToken(String token) async {
    return User(
        email: 'freezflukezazu@gmail.com',
        phoneNumber: '0991238203',
        role: 'ADMIN',
        name: "Yanaphon",
        lastName: "Chatkaewmanewong");
    // final response = await http.post(
    //   Uri.parse('$baseUrl/login'),
    //   body: {'email': email, 'password': password},
    // );

    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   return User(email: email, token: json['token']);
    // } else {
    //   throw Exception('Login failed');
    // }
  }

  @override
  Future<bool> logout() async {
    return true;
    // final response = await http.post(
    //   Uri.parse('$baseUrl/login'),
    //   body: {'email': email, 'password': password},
    // );

    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   return User(email: email, token: json['token']);
    // } else {
    //   throw Exception('Login failed');
    // }
  }
}
