import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/auth_model.dart';
import 'package:phytomedicine_app/screens/setting_screen.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/shared/snackbar.dart';
import 'package:provider/provider.dart';

class LeaveReviewScreen extends StatefulWidget {
  const LeaveReviewScreen({Key? key}) : super(key: key);

  static const routeName = '/leave-review-screen';

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  String? dropdownvalue;
  String additionalValue = '';

  final _formKeyForReview = GlobalKey<FormState>();

  // List of items in our dropdown menu
  var items = [
    'Bug',
    'Feedback',
    'Suggestion',
    'Collaborate',
  ];
  bool loading = false;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth?>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: loading
          ? const Loading()
          : SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: kToolbarHeight + 20,
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    mediaQuery.size.width <= 350 ? 8.0 : 16.0),
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
                          const AutoSizeText(
                            'Leave a Review',
                            minFontSize: 20,
                            maxFontSize: 24,
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right:
                                    mediaQuery.size.width <= 350 ? 8.0 : 16.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SettingScreen.routeName);
                                },
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
                                child: Form(
                                  key: _formKeyForReview,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 80,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      26, 183, 168, 1),
                                                  Color.fromRGBO(
                                                      94, 209, 151, 1)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              iconEnabledColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              dropdownDecoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              64, 78, 91, 1),
                                                      width: 2),
                                                  color: const Color.fromRGBO(
                                                      37, 55, 72, 1)),
                                              isExpanded: true,
                                              hint: const Text(
                                                'Select option',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              items: items
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: dropdownvalue,
                                              onChanged: (value) {
                                                setState(() {
                                                  dropdownvalue =
                                                      value as String;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 32.0, left: 16.0),
                                        child: Text(
                                          'Additional information',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  189, 189, 189, 1)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: TextFormField(
                                          onChanged: (val) {
                                            setState(() {
                                              additionalValue = val;
                                            });
                                          },

                                          validator: (val) => val!.isEmpty
                                              ? 'Please Enter Additional information'
                                              : null,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        165, 165, 165, 0.21),
                                                    width: 1.5)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        165, 165, 165, 0.21),
                                                    width: 1.5)),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        165, 165, 165, 0.21),
                                                    width: 1.5)),
                                            filled: true,
                                            fillColor:
                                                Color.fromRGBO(37, 55, 72, 1),
                                          ),
                                          minLines:
                                              14, // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(24.0),
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
                                                  onPressed: () async {
                                                    if (_formKeyForReview
                                                            .currentState!
                                                            .validate() &&
                                                        dropdownvalue != null) {
                                                      setState(() {
                                                        loading = true;
                                                      });
                                                      try {
                                                        String uid = user!.uid;
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'reviews')
                                                            .doc(uid)
                                                            .collection(
                                                                'reviews')
                                                            .add({
                                                          'category':
                                                              dropdownvalue,
                                                          'additionalInfo':
                                                              additionalValue
                                                        });

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                getSnackBar(
                                                                    'Submitted Successfully'));
                                                      } catch (e) {
                                                        // print(e);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                getSnackBar(
                                                                    'Submission Failure'));
                                                        setState(() {
                                                          loading = false;
                                                        });
                                                      }

                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    } else if (dropdownvalue ==
                                                        null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(getSnackBar(
                                                              'Please Select the option'));
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Submit',
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
