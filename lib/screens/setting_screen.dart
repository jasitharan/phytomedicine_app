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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth?>(context);

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
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Setting',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 48,
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32.0, top: 24),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32.0, top: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32.0, top: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
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
                                          )
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
