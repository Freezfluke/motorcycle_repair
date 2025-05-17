import 'package:flutter/material.dart';
import 'package:motorcycle_repair/constants/route_name.dart';
import 'package:motorcycle_repair/presentation/viewModels/theme_viewmodel.dart';
import 'package:motorcycle_repair/presentation/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'data/auth_api_service.dart';
import 'application/auth_usecase.dart';
import 'presentation/viewModels/auth_viewmodel.dart';
import 'presentation/views/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthApiService();
    final authUseCase = AuthUseCase(authRepo);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(authUseCase),
        ),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer2<ThemeViewModel, AuthViewModel>(
        builder: (context, themeProvider, authProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(color: Colors.white),
                inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Colors.grey, width: 0.5)), // your color
                )),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.currentTheme,
            home: authProvider.isLoggedIn
                ? const HomeScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
