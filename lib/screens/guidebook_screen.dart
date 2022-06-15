import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:phytomedicine_app/screens/pdfview_screen.dart';
import 'package:phytomedicine_app/screens/setting_screen.dart';
import 'package:phytomedicine_app/services/conditions.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/widgets/item_tile.dart';
import 'package:provider/provider.dart';

class GuideBookScreen extends StatefulWidget {
  const GuideBookScreen({Key? key}) : super(key: key);

  static const routeName = '/guidebook-screen';

  @override
  State<GuideBookScreen> createState() => _GuideBookScreenState();
}

class _GuideBookScreenState extends State<GuideBookScreen> {
  bool loading = false;
  final searchTextController = TextEditingController();
  List<Map> conditions = [];
  bool _isInit = true;
  bool searchLoading = false;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        loading = true;
      });
      final conditions = Provider.of<Conditions>(context);

      if (!conditions.isDone) {
        await conditions.getConditions('');
        if (conditions.conditions.isNotEmpty) {
          conditions.isDone = true;
        }
      }

      setState(() {
        loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final conditions = Provider.of<Conditions>(context);
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
                            'Global Medical Guide',
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
                              child: LazyLoadScrollView(
                                scrollOffset: 150,
                                onEndOfPage: () async {
                                  final result = await conditions
                                      .getConditions(searchTextController.text);

                                  if (mounted && result != null) {
                                    setState(() {});
                                  }
                                },
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 32.0,
                                          bottom: 24.0,
                                          left: 16.0,
                                          right: 16),
                                      child: TextField(
                                        controller: searchTextController,
                                        onChanged: (_) async {
                                          setState(() {
                                            searchLoading = true;
                                          });
                                          await conditions.getConditions(
                                              searchTextController.text);
                                          setState(() {
                                            searchLoading = false;
                                          });
                                        },
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
                                    searchLoading
                                        ? SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            child: const Center(
                                              child: SpinKitFadingCircle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                conditions.conditions.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) =>
                                                ItemTile(
                                                    fromInternet: true,
                                                    handlerFunction: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          PDFViewScreen
                                                              .routeName,
                                                          arguments: {
                                                            'condition': conditions
                                                                    .conditions[
                                                                index]
                                                          });
                                                    },
                                                    title: conditions
                                                        .conditions[index]
                                                        .title,
                                                    imageName: conditions
                                                        .conditions[index]
                                                        .image),
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
