import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:phytomedicine_app/screens/leave_review_screen.dart';
import 'package:phytomedicine_app/screens/mobile_medical_clinic_screen.dart';
import 'package:phytomedicine_app/screens/phytomedicine_screen.dart';
import 'package:phytomedicine_app/screens/selection_screen.dart';
import 'package:phytomedicine_app/screens/setting_screen.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/widgets/item_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: loading
          ? const Loading()
          : SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: kToolbarHeight + 20,
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(),
                          const AutoSizeText(
                            'Global Medical Guide',
                            minFontSize: 20,
                            maxFontSize: 24,
                            style: TextStyle(color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SettingScreen.routeName);
                              },
                              icon: const Icon(
                                Icons.settings,
                                size: 32,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(24, 41, 57, 1),
                              borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(32.0),
                                  topRight: Radius.circular(45.0)),
                            ),
                            child: ScrollConfiguration(
                              behavior: CustomScroll(),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Image(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          width: double.infinity,
                                          image: const AssetImage(
                                              'assets/images/banner.png')),
                                    ),
                                    // const SizedBox(
                                    //   height: 50,
                                    // ),
                                    ItemTile(
                                        handlerFunction: () {
                                          Navigator.pushNamed(context,
                                              SelectionScreen.routeName);
                                        },
                                        title: 'Guidebook',
                                        imageName: 'healthcare'),
                                    ItemTile(
                                        handlerFunction: () {
                                          Navigator.pushNamed(context,
                                              PhytoMedicineScreen.routeName);
                                        },
                                        title: 'Phytomedicine',
                                        imageName: 'healthcare2'),
                                    ItemTile(
                                        handlerFunction: () {
                                          Navigator.pushNamed(context,
                                              LeaveReviewScreen.routeName);
                                        },
                                        title: 'Leave a Review',
                                        imageName: 'healthcare3'),
                                    ItemTile(
                                        handlerFunction: () {
                                          Navigator.pushNamed(
                                              context,
                                              MobileMedicalClinicScreen
                                                  .routeName);
                                        },
                                        title: 'Mobile Medical Clinic',
                                        imageName: 'healthcare4'),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                            )))
                  ],
                ),
                decoration: const BoxDecoration(
                    // image: DecorationImage(image: AssetImage(''))
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(26, 183, 168, 1),
                    Color.fromRGBO(94, 209, 151, 1)
                  ],
                )),
              ),
            ),
    );
  }
}
