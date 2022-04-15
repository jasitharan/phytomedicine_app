import 'package:flutter/material.dart';
import 'package:phytomedicine_app/screens/pdfview_screen.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/widgets/item_tile.dart';

class GuideBookScreen extends StatefulWidget {
  const GuideBookScreen({Key? key}) : super(key: key);

  static const routeName = '/guidebook-screen';

  @override
  State<GuideBookScreen> createState() => _GuideBookScreenState();
}

class _GuideBookScreenState extends State<GuideBookScreen> {
  bool loading = false;
  final searchTextController = TextEditingController();

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
                            'Global Medical Guide',
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
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 32.0,
                                          bottom: 24.0,
                                          left: 16.0,
                                          right: 16),
                                      child: TextField(
                                        controller: searchTextController,
                                        onChanged: (_) async {},
                                        style: const TextStyle(
                                            color: Colors.white70),
                                        // autofocus: true,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 18,
                                                    horizontal: 24.0),
                                            fillColor: const Color.fromRGBO(
                                                37, 55, 72, 1),
                                            filled: true,
                                            //  contentPadding: ,
                                            suffixIcon: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Icon(
                                                Icons.search,
                                                size: 24,
                                                color: Color.fromRGBO(
                                                    26, 183, 168, 1),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            hintText: "Filter by keyword",
                                            hintStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.31))),
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount: conditions.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => ItemTile(
                                          handlerFunction: () {
                                            Navigator.pushNamed(context,
                                                PDFViewScreen.routeName,
                                                arguments: {
                                                  'content': conditions[index]
                                                      ['content']
                                                });
                                          },
                                          title: conditions[index]['title'],
                                          imageName: 'conditions/' +
                                              conditions[index]['image']),
                                    ),
                                    const SizedBox(
                                      height: 15,
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

List<Map> conditions = [
  {'image': 'malaria', 'title': 'Malaria', 'content': 'tuberculosis'},
  {'image': 'tuberculosis', 'title': 'Tuberculosis', 'content': 'tuberculosis'},
  {'image': 'hiv', 'title': 'HIV/AIDS', 'content': 'tuberculosis'},
  {
    'image': 'heart_disease',
    'title': 'Heart Disease',
    'content': 'tuberculosis'
  },
  {'image': 'diabetes', 'title': 'Diabetese', 'content': 'tuberculosis'}
];
