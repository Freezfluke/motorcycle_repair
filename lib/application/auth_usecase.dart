import 'package:motorcycle_repair/domain/models/user.dart';

import '../domain/models/auth.dart';
import '../domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<Auth> login(String email, String password) {
    return repository.login(email, password);
  }

  Future<Auth> register(String email, String password) {
    return repository.register(email, password);
  }

  Future<User> gerProfile(String token) {
    return repository.getToken(token);
  }
}
