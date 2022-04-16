import 'package:flutter/material.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:phytomedicine_app/api/pdf_api.dart';

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

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        loading = true;
      });
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;

      var url = 'pdfs/${args!['content'].toString()}';
      file = await PDFApi.loadFirebase(url);
      setState(() {
        loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
                            'Medical Guide',
                            style: TextStyle(fontSize: 24, color: Colors.white),
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
                                : PDFView(
                                    filePath: file!.path,

                                    // autoSpacing: false,
                                    // swipeHorizontal: true,
                                    // pageSnap: false,
                                    // pageFling: false,
                                    onRender: (pages) =>
                                        setState(() => this.pages = pages!),
                                    onViewCreated: (controller) => setState(
                                        () => this.controller = controller),
                                    onPageChanged: (indexPage, _) => setState(
                                        () => this.indexPage = indexPage!),
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
