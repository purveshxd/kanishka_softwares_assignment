import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanishka_softwares_assignment/homescreen.dart';

import 'package:kanishka_softwares_assignment/service/shared_pref_auth.dart';

import 'package:kanishka_softwares_assignment/widgets/auth_textfield.dart';

class RegistrationScreen extends ConsumerWidget {
  final void Function()? onTap;
  RegistrationScreen({super.key, required this.onTap});

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordConfirmController =
      TextEditingController();

  void registerUser(context) async {
    if (passwordConfirmController.text == passwordController.text) {
      await AuthDatabase().register(
          username: nameController.text,
          email: emailController.text,
          password: passwordController.text);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(
       
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password doesn't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Register User
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(height: 100),
              // login icon
              const Icon(Icons.login_rounded, size: 220),
              // textfield for name
              AuthTextField(controller: nameController, label: 'Enter name'),
              const SizedBox(height: 10),

              // textfield for password
              AuthTextField(controller: emailController, label: 'Enter email'),
              const SizedBox(height: 10),

              // textfield for email
              AuthTextField(
                label: 'Enter password',
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              // textfield for confirm password
              AuthTextField(
                label: 'Re-enter passowrd',
                controller: passwordConfirmController,
              ),
              const SizedBox(height: 10),

              // button for registration
              MaterialButton(
                color: Colors.amber.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: (MediaQuery.of(context).size.shortestSide / 100) * 14,
                onPressed: () => registerUser(context),
                minWidth: double.infinity,
                child: const Text('Register'),
              ),
              const SizedBox(height: 10),

              // text for login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(onPressed: onTap, child: const Text("Login here"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
