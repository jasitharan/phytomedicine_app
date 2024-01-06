import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/auth_model.dart';
import 'package:phytomedicine_app/screens/login_screen.dart';
import 'package:phytomedicine_app/services/auth.dart';
import 'package:phytomedicine_app/shared/constants.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/shared/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../theme/text_form_fields.dart';
import '../theme/validators.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  static const routeName = '/setting-screen';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKeyForSetting = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  bool _isHidden = true;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        loading = true;
      });
      final user = Provider.of<Auth?>(context);

      email = (user?.email.split('@')[1] == 'somemail.com'
              ? user?.email.split('@')[0]
              : user?.email) ??
          '';
      setState(() {
        loading = false;
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _delete(BuildContext context, String email) {
    String password = '';
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text(
              'Please enter your password to delete the account',
              style: TextStyle(color: Colors.black54),
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(101, 101, 101, 1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: ClassTextFormField(
                  isPassword: true,
                  onChanged: (val) {
                    password = val;
                  },
                  validator: (val) => !passwordValidator.hasMatch(val!)
                      ? "Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, and one number."
                      : null,
                ),
              ),
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Next'))
            ],
          );
        }).then((value) {
      if (password.isEmpty) {
        return;
      }
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text('Please Confirm'),
              content: const Text(
                'Are you sure to delete the account?',
                style: TextStyle(color: Colors.black54),
              ),
              actions: [
                // The "Yes" button
                TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();

                      setState(() {
                        loading = true;
                      });

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .delete();
                      var result = await FirebaseAuth.instance.currentUser
                          ?.reauthenticateWithCredential(
                              EmailAuthProvider.credential(
                                  email: email, password: password));

                      await result?.user?.delete();

                      setState(() {
                        loading = false;
                      });

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName,
                          (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'))
              ],
            );
          });
    });
  }

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
                            'Setting',
                            minFontSize: 20,
                            maxFontSize: 24,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 32 +
                                (mediaQuery.size.width <= 350 ? 8.0 : 16.0),
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
                                child: Column(
                                  children: [
                                    Form(
                                      key: _formKeyForSetting,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 43,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 32.0, top: 24),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image(
                                                    color: Colors.white,
                                                    image: AssetImage(
                                                        'assets/images/email.png')),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Email / Username',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0, vertical: 16),
                                            child: TextFormField(
                                              initialValue: email,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                hintText: 'Email / Username',
                                              ),
                                              validator: (val) => !isEmail(val!)
                                                  ? 'Enter an Email / Username'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() {
                                                  email = val.trim();
                                                });
                                              },
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 32.0, top: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image(
                                                    color: Colors.white,
                                                    image: AssetImage(
                                                        'assets/images/password.png')),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Password',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0, vertical: 16),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                hintText: 'Password',
                                                suffix: InkWell(
                                                  onTap: _togglePasswordView,
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0),
                                                    child: Text(
                                                      'Show',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              26, 183, 168, 1)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              validator: (val) => val!.length <
                                                      6
                                                  ? 'Enter a password 6+ chars long'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() {
                                                  password = val;
                                                });
                                              },
                                              obscureText: _isHidden,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 32.0, top: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image(
                                                    color: Colors.white,
                                                    image: AssetImage(
                                                        'assets/images/password.png')),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Confirm Password',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0, vertical: 16),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                hintText: 'Confirm Password',
                                                suffix: InkWell(
                                                  onTap: _togglePasswordView,
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0),
                                                    child: Text(
                                                      'Show',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              26, 183, 168, 1)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              validator: (val) => val! !=
                                                      password
                                                  ? 'Confirm Password Incorrect'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() {
                                                  confirmPassword = val;
                                                });
                                              },
                                              obscureText: _isHidden,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 60,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Color.fromRGBO(
                                                            94, 209, 151, 1),
                                                        Color.fromRGBO(
                                                            26, 183, 168, 1)
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ElevatedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
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
                                                                      .all(
                                                                      16.0)),
                                                      onPressed: () async {
                                                        if (_formKeyForSetting
                                                            .currentState!
                                                            .validate()) {
                                                          setState(() {
                                                            loading = true;
                                                          });

                                                          if (!isEmail(email)) {
                                                            email = email +
                                                                '@somemail.com';
                                                          }

                                                          var result = await _auth
                                                              .changeEmail(
                                                                  oldEmail: user!
                                                                      .email,
                                                                  newEmail:
                                                                      email,
                                                                  password:
                                                                      password);

                                                          if (result is Auth) {
                                                            setState(() {
                                                              user.email =
                                                                  email;
                                                              loading = false;
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    getSnackBar(
                                                                        'Successfully Updated'));
                                                          } else {
                                                            setState(() {
                                                              loading = false;
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    getSnackBar(
                                                                        result));
                                                          }
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Save',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ))),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0, vertical: 2),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    // gradient:
                                                    //     const LinearGradient(
                                                    //   begin:
                                                    //       Alignment.topCenter,
                                                    //   end: Alignment
                                                    //       .bottomCenter,
                                                    //   colors: [
                                                    //     Color.fromRGBO(
                                                    //         94, 209, 151, 1),
                                                    //     Color.fromRGBO(
                                                    //         26, 183, 168, 1)
                                                    //   ],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ElevatedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
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
                                                                      .all(
                                                                      16.0)),
                                                      onPressed: () async {
                                                        dynamic result =
                                                            await _auth
                                                                .signOut();

                                                        if (result != null) {
                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                                  LoginScreen
                                                                      .routeName,
                                                                  (Route<dynamic>
                                                                          route) =>
                                                                      false);
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Logout',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ))),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0, vertical: 2),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    // gradient:
                                                    //     const LinearGradient(
                                                    //   begin:
                                                    //       Alignment.topCenter,
                                                    //   end: Alignment
                                                    //       .bottomCenter,
                                                    //   colors: [
                                                    //     Color.fromRGBO(
                                                    //         94, 209, 151, 1),
                                                    //     Color.fromRGBO(
                                                    //         26, 183, 168, 1)
                                                    //   ],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ElevatedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
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
                                                                      .all(
                                                                      16.0)),
                                                      onPressed: () async =>
                                                          _delete(
                                                              context, email),
                                                      child: const Text(
                                                        'Delete Account',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ))),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
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
