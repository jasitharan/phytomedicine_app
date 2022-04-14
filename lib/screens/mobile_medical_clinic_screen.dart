import 'package:flutter/material.dart';
import 'package:phytomedicine_app/shared/constants.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/widgets/item_tile.dart';
import 'package:validators/validators.dart';

class MobileMedicalClinicScreen extends StatefulWidget {
  const MobileMedicalClinicScreen({Key? key}) : super(key: key);

  static const routeName = '/mobile-medical-clinic-screen';

  @override
  State<MobileMedicalClinicScreen> createState() =>
      _MobileMedicalClinicScreenState();
}

class _MobileMedicalClinicScreenState extends State<MobileMedicalClinicScreen> {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 32,
                                  color: Colors.white,
                                )),
                          ),
                          const Text(
                            'Mobile Medical Clinic',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.settings,
                                  size: 32,
                                  color: Colors.white,
                                )),
                          )
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
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      (kToolbarHeight +
                                          20 +
                                          MediaQuery.of(context).padding.top),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                          image: AssetImage(
                                              'assets/images/telescope.png')),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'COMING ',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        26, 183, 168, 1),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: 'SOON!',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: const TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'We are working on this page and we will launch it way soon. ',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          189, 189, 189, 1),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              TextSpan(
                                                  text:
                                                      'Get notify when we launch!',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          26, 183, 168, 1),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 16),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration:
                                              textInputDecoration.copyWith(
                                            hintText: 'Email',
                                          ),
                                          validator: (val) => !isEmail(val!)
                                              ? 'Enter an Email'
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              //email = val;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 16),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        94, 209, 151, 1),
                                                    Color.fromRGBO(
                                                        26, 183, 168, 1)
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: ElevatedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0)),
                                                  onPressed: () async {},
                                                  child: const Text(
                                                    'Subscribe',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ))),
                                        ),
                                      ),
                                    ],
                                  ),
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
