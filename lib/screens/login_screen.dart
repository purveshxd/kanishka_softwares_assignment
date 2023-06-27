import 'package:flutter/material.dart';
import 'package:kanishka_softwares_assignment/homescreen.dart';
import 'package:kanishka_softwares_assignment/service/shared_pref_auth.dart';

import 'package:kanishka_softwares_assignment/widgets/auth_textfield.dart';

class LoginScreen extends StatelessWidget {
  final void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Login user
    void loginUser() async {
      try {
        bool resp = AuthDatabase().login(
            email: emailController.text, password: passwordController.text);

        if (resp) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>  const HomeScreen(),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(height: 100),
              // login icon
              const Icon(Icons.person_rounded, size: 220),

              // textfield for password
              AuthTextField(controller: emailController, label: 'Enter email'),
              const SizedBox(height: 10),

              // textfield for email
              AuthTextField(
                label: 'Enter password',
                controller: passwordController,
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
                onPressed: loginUser,
                minWidth: double.infinity,
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),

              // text for login
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New user?"),
                  TextButton(
                      onPressed: onTap, child: const Text("Register here"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
