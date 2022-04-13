import 'package:flutter/material.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/widgets/item_tile.dart';

class LeaveReviewScreen extends StatefulWidget {
  const LeaveReviewScreen({Key? key}) : super(key: key);

  static const routeName = '/leave-review-screen';

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
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
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 32,
                                color: Colors.white,
                              )),
                          const Text(
                            'Leave a Review',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {},
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
                                        handlerFunction: () {},
                                        title: 'Guidebook',
                                        imageName: 'healthcare'),
                                    ItemTile(
                                        handlerFunction: () {},
                                        title: 'Phytomedicine',
                                        imageName: 'healthcare2'),
                                    ItemTile(
                                        handlerFunction: () {},
                                        title: 'Leave a Review',
                                        imageName: 'healthcare3'),
                                    ItemTile(
                                        handlerFunction: () {},
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
