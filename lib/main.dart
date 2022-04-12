import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/auth_model.dart';
import 'package:phytomedicine_app/screens/login_screen.dart';
import 'package:phytomedicine_app/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Auth?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {'/': (ctx) => const LoginScreen()},
      ),
    );
  }
}
