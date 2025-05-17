import 'package:flutter/material.dart';
import 'package:motorcycle_repair/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/auth.dart';
import '../../application/auth_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthUseCase _authUseCase;
  bool isLoading = false;
  late Auth auth;
  String? errorMessage;
  User? currentUser;
  bool get isLoggedIn => currentUser != null;

  AuthViewModel(this._authUseCase) {
    init();
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      auth = await _authUseCase.login(email, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', auth.token);
      await getProfile(auth.token);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      auth = await _authUseCase.register(email, password);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getProfile(String token) async {
    try {
      isLoading = true;
      notifyListeners();
      currentUser = await _authUseCase.gerProfile(token);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      getProfile(token);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    currentUser = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
