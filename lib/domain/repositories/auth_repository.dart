import 'package:motorcycle_repair/domain/models/user.dart';

import '../models/auth.dart';

abstract class AuthRepository {
  Future<Auth> login(String email, String password);
  Future<Auth> register(String email, String password);
  Future<User> getToken(String token);
  Future<void> logout();
}
