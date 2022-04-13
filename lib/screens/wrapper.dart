import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/auth_model.dart';
import 'package:phytomedicine_app/screens/home_screen.dart';
import 'package:phytomedicine_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth?>(context);
    // return either home or authenticate widget
    return user == null ? const LoginScreen() : const HomeScreen();
  }
}
