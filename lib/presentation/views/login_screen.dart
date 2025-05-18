import 'package:flutter/material.dart';
import 'package:motorcycle_repair/constants/route_name.dart';
import 'package:motorcycle_repair/presentation/viewModels/theme_viewmodel.dart';
import 'package:motorcycle_repair/widgets/amimation_list_top.dart';
import 'package:motorcycle_repair/widgets/animation_float_top.dart';
import 'package:provider/provider.dart';
import '../viewModels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(30, 8),
                  bottomRight: Radius.elliptical(30, 8),
                ),
              ),
              child: SlideUpOnLoad(
                  child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: SlideUpList(
                            itemDelay: const Duration(milliseconds: 150),
                            animationDuration:
                                const Duration(milliseconds: 500),
                            children: [
                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (vm.errorMessage != null)
                            Text(vm.errorMessage!,
                                style: const TextStyle(color: Colors.red)),
                          TextField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: passController,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                        ])),
                    vm.isLoading
                        ? const CircularProgressIndicator()
                        : Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  // Navigator.pushNamed(context, RouteNames.home),
                                  vm.login(
                                emailController.text.trim(),
                                passController.text.trim(),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
