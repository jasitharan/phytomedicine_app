import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/auth_model.dart';
import 'package:phytomedicine_app/screens/guidebook_screen.dart';
import 'package:phytomedicine_app/screens/home_screen.dart';
import 'package:phytomedicine_app/screens/leave_review_screen.dart';
import 'package:phytomedicine_app/screens/login_screen.dart';
import 'package:phytomedicine_app/screens/mobile_medical_clinic_screen.dart';
import 'package:phytomedicine_app/screens/pdfview_screen.dart';
import 'package:phytomedicine_app/screens/phytomedicine_screen.dart';
import 'package:phytomedicine_app/screens/setting_screen.dart';
import 'package:phytomedicine_app/screens/signup_screen.dart';
import 'package:phytomedicine_app/screens/wrapper.dart';
import 'package:phytomedicine_app/services/auth.dart';
import 'package:phytomedicine_app/services/conditions.dart';
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
      child: MultiProvider(
        providers: [
          Provider.value(value: Conditions()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (ctx) => const Wrapper(),
            PDFViewScreen.routeName: (ctx) => const PDFViewScreen(),
            SignUpScreen.routeName: (ctx) => const SignUpScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            GuideBookScreen.routeName: (ctx) => const GuideBookScreen(),
            LeaveReviewScreen.routeName: (ctx) => const LeaveReviewScreen(),
            MobileMedicalClinicScreen.routeName: (ctx) =>
                const MobileMedicalClinicScreen(),
            PhytoMedicineScreen.routeName: (ctx) => const PhytoMedicineScreen(),
            SettingScreen.routeName: (ctx) => const SettingScreen()
          },
        ),
      ),
    );
  }
}
