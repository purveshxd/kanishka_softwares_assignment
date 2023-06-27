import 'dart:convert';

import 'package:kanishka_softwares_assignment/main.dart';

class AuthDatabase {
  Map usercred = {"username": "", "email": "", "password": ""};

  String getImage() {
    return prefs.getString('image').toString();
  }

  String getUsername() {
    return jsonDecode(prefs.getString('usercred')!)['username'];
  }

  List<String>? getLocation() {
    return prefs.getStringList('location');
  }

  //Register user
  Future<bool> register(
      {required String username,
      required String email,
      required String password}) async {
    usercred = {"username": username, "email": email, "password": password};
    final resp = await prefs.setString('usercred', jsonEncode(usercred));

    prefs.setBool('isLoggedIn', true);
    return resp;
  }

  // LoginUser
  bool login({required String email, required String password}) {
    if (jsonDecode(prefs.getString('usercred')!)['password'] == password &&
        jsonDecode(prefs.getString('usercred')!)['email'] == email) {
      prefs.setBool('isLoggedIn', true);
      return true;
    } else if (jsonDecode(prefs.getString('usercred')!)['password'] == null) {
      throw 'User does not exits';
    } else {
      throw 'Invalid Credentials';
    }
  }

  Future<bool> logout() async {
    return await prefs.setBool('isLoggedIn', false);
  }

  Future<bool> setImage(String imagePath) async {
    return await prefs.setString('image', imagePath);
  }

  Future<bool> setLocation(double? lat, double? long) async {
    return await prefs
        .setStringList('location', [lat.toString(), long.toString()]);
  }
}
