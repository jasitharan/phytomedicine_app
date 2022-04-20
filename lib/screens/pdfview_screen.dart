import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phytomedicine_app/models/condition_model.dart';
import 'package:phytomedicine_app/models/step_model.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:phytomedicine_app/api/pdf_api.dart';
import 'package:phytomedicine_app/widgets/guide_expansion_tile.dart';

class PDFViewScreen extends StatefulWidget {
  const PDFViewScreen({Key? key}) : super(key: key);

  static const routeName = '/pdf-screen';

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;
  bool _isInit = true;
  File? file;
  bool loading = false;
  late List<StepModel> stepModel;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        loading = true;
      });

      //${args!['content'].toString()}
      var url = 'jsons/sample.json';
      file = await PDFApi.loadFirebase(url);
      // print(file);

      dynamic myFunc(StepModel? step, StepModel? parent) {
        if (step == null) {
          return;
        }

        print('parent ${parent?.title} + ${step.title}');

        if (step.steps != null) {
          for (StepModel i in step.steps!) {
            myFunc(i, step);
          }
        }

        return;
      }

      Future<dynamic> readJson() async {
        final String response = await rootBundle.loadString(file!.path);
        final data = await json.decode(response);
        //print(data);
        stepModel = Condition.fromJson(data[1]).steps!;
      }

      await readJson();

      setState(() {
        loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;

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
                              'Medical Guide',
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
                            child: file == null
                                ? const Center(
                                    child: Text(
                                      'Guide not found',
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.white),
                                    ),
                                  )
                                : ScrollConfiguration(
                                    behavior: CustomScroll(),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/images/banner.png')),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0,
                                                top: 24,
                                                bottom: 22),
                                            child: Text(
                                              args!['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Color.fromRGBO(
                                                      26, 183, 168, 1)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: stepModel.length,
                                                itemBuilder: (ctx, i) {
                                                  return GuideExpansionTile(
                                                      title:
                                                          stepModel[i].title ??
                                                              '',
                                                      leadingText: '${i + 1}.',
                                                      childs:
                                                          stepModel[i].steps);
                                                }),
                                          ),
                                          const SizedBox(
                                            height: 50,
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
