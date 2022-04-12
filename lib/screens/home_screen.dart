import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: GridTile(
                    footer: const SizedBox(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(image: AssetImage('assets/images/world.png')),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                    ],
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
