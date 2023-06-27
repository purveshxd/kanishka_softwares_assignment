// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanishka_softwares_assignment/proivders/all_providers.dart';
import 'package:location/location.dart';

import 'package:kanishka_softwares_assignment/screens/auth_screen.dart';
import 'package:kanishka_softwares_assignment/service/shared_pref_auth.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

AuthDatabase _authDatabase = AuthDatabase();
final ImagePicker picker = ImagePicker();

double? lat = 0;
double? long = 0;

void logout(context) async {
  bool resp = await _authDatabase.logout();
  if (resp) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const AuthScreen(),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Can't logout"),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Future<LocationData> getLocation() async {
    Location location = Location();
    return await location.getLocation();
  }

  void pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image == null) return;
      var tempImage = XFile(image.path).path;
      var currentLocation = await getLocation();
      setState(() {});
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      _authDatabase.setLocation(lat, long);
      _authDatabase.setImage(tempImage);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String>? location = _authDatabase.getLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text(_authDatabase.getUsername()),
        actions: [
          Consumer(builder: (context, ref, child) {
            return Switch(
              value: ref.watch(themeProvider),
              onChanged: (value) {
                ref.refresh(themeProvider.notifier).update((state) => value);
              },
            );
          }),
          IconButton(
              onPressed: () => logout(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.file(
              File(
                _authDatabase.getImage().toString(),
              ),
              errorBuilder: (context, error, stackTrace) {
                return const Text("Check-in to add a Image");
              },
              fit: BoxFit.fitWidth,
            ),
          ),
          const Spacer(),
          Text("Latitude: ${location?[0]}"),
          Text("Longitude: ${location?[1]}"),
          const Spacer(),
          TextButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.camera_rounded),
              label: const Text('Check-in')),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
