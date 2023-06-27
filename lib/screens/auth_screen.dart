import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kanishka_softwares_assignment/proivders/all_providers.dart';
import 'package:kanishka_softwares_assignment/screens/login_screen.dart';

import 'package:kanishka_softwares_assignment/screens/registration_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    void onTap() {
      ref.read(togglePageProvider.notifier).update((state) => !state);
    }

    return Scaffold(
      body: ref.watch(togglePageProvider)
          ? RegistrationScreen(onTap: onTap)
          : LoginScreen(onTap: onTap),
    );
  }
}
