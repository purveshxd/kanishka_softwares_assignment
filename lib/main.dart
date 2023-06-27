import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanishka_softwares_assignment/homescreen.dart';

import 'package:kanishka_softwares_assignment/screens/auth_screen.dart';
import 'package:kanishka_softwares_assignment/style.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
late bool isLoggedIn;
// late List<String> locationData;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;
  @override
  void initState() {
    getLocationPermission();

    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    super.initState();
  }

  Future<void> getLocationPermission() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  onChanged(value) {
    setState(() {
      isDarkTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Style.themeData(isDarkTheme, context),
      home: isLoggedIn
          ? HomeScreen(
              onChanged: (value) => onChanged(value),
              isDarktheme: isDarkTheme,
            )
          : const AuthScreen(),
    );
  }
}
