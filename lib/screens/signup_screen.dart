import 'package:flutter/material.dart';
import 'package:phytomedicine_app/screens/home_screen.dart';
import 'package:phytomedicine_app/screens/login_screen.dart';
import 'package:phytomedicine_app/services/apple_signin_available.dart';
import 'package:phytomedicine_app/services/auth.dart';
import 'package:phytomedicine_app/shared/constants.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/shared/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:validators/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routeName = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String name = '';
  String error = '';
  bool loading = false;
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: loading
          ? const Loading()
          : SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: const GridTile(
                          footer: SizedBox(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image:
                                        AssetImage('assets/images/world.png')),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    'Global Medical Guide',
                                    style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white60,
                                BlendMode.srcIn,
                              ),
                              image: AssetImage(
                                'assets/images/background.png',
                              ))),
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
                              const SizedBox(
                                height: 15,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 43,
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Create Your Account',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 32.0, top: 24),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image(
                                              color: Colors.white,
                                              image: AssetImage(
                                                  'assets/images/user.png')),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 24,
                                          left: 24.0,
                                          top: 16,
                                          bottom: 16),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration:
                                            textInputDecoration.copyWith(
                                          hintText: 'Name',
                                        ),
                                        validator: (val) => val!.isEmpty
                                            ? 'Enter an name'
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            name = val;
                                          });
                                        },
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 32.0, top: 12),
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
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
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
                                          hintText: 'Email / Username',
                                        ),
                                        validator: (val) => val!.isEmpty
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
                                      padding:
                                          EdgeInsets.only(left: 32.0, top: 12),
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
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
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
                                        validator: (val) => val!.length < 6
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
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0)),
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    if (!isEmail(email)) {
                                                      email = email +
                                                          '@somemail.com';
                                                    }
                                                    dynamic result = await _auth
                                                        .registerWithEmailAndPassword(
                                                            name,
                                                            email,
                                                            password);
                                                    if (result != null) {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              HomeScreen
                                                                  .routeName);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(getSnackBar(
                                                              'Please provide valid information'));
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: const Text(
                                                  'Sign Up',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          const Text(
                                            'Already have an account? ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      LoginScreen.routeName);
                                            },
                                            child: const Text(
                                              'Login Here',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      26, 183, 168, 1)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'or continue with',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              loading = true;
                                            });

                                            var result =
                                                await _auth.signInwithGoogle();

                                            if (result != null) {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  HomeScreen.routeName);
                                            } else {
                                              setState(() {
                                                loading = false;
                                              });
                                            }
                                          },
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Image.asset(
                                                    'assets/images/google.png'),
                                              )),
                                        ),
                                        if (appleSignInAvailable.isAvailable)
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        if (appleSignInAvailable.isAvailable)
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                                loading = true;
                                              });

                                              var result = await _auth
                                                  .signInWithApple(scopes: [
                                                Scope.email,
                                                Scope.fullName
                                              ]);

                                              if (result != null) {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    HomeScreen.routeName);
                                              } else {
                                                setState(() {
                                                  loading = false;
                                                });
                                              }
                                            },
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: Image.asset(
                                                    'assets/images/apple.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
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
