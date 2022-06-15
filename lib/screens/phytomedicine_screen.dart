import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/folder_model.dart';
import 'package:phytomedicine_app/services/folders_provider.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:phytomedicine_app/widgets/show_dialogs.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../widgets/show_popup_menu.dart';

class PhytoMedicineScreen extends StatefulWidget {
  const PhytoMedicineScreen({Key? key}) : super(key: key);

  static const routeName = '/phyto-medicine-screen';

  @override
  State<PhytoMedicineScreen> createState() => _PhytoMedicineScreenState();
}

class _PhytoMedicineScreenState extends State<PhytoMedicineScreen> {
  bool _loading = false;
  bool _isInit = true;
  bool _isAdding = false;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      final user = Provider.of<Auth?>(context);
      final folders = Provider.of<FolderProvider>(context);
      if (!folders.isDone) {
        if (await folders.getFolders(user!.uid) != null) {
          folders.isDone = true;
        }
      }

      setState(() {
        _loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final user = Provider.of<Auth?>(context);
    final folders = Provider.of<FolderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: _loading
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
                          const SizedBox(),
                          const AutoSizeText(
                            'Phytomedicine Submission',
                            minFontSize: 20,
                            maxFontSize: 24,
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                              onTap: () {
                                _isAdding = true;
                                showFolderDialog(
                                  context: context,
                                  hanlder: (val) {
                                    FolderModel model =
                                        FolderModel(name: val, filesUrls: []);
                                    folders.folders.add(model);

                                    setState(() {});

                                    folders.addFolders(model, user!.uid);
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Image.asset('assets/images/add.png'),
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
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 1.0,
                                      mainAxisSpacing: 10.0,
                                    ),
                                    itemCount: folders.folders.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTapDown: (TapDownDetails details) {
                                          if (folders.isAdd || !_isAdding) {
                                            folders.isAdd = false;
                                            _isAdding = false;
                                            showPopupMenu(
                                                    context,
                                                    details.globalPosition,
                                                    folders.folders[index].uid!,
                                                    index % 3)
                                                .then((value) {
                                              setState(() {});
                                            });
                                          }
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/images/folder.png',
                                              width:
                                                  mediaQuery.size.width * 0.25,
                                              height:
                                                  mediaQuery.size.width * 0.25,
                                              fit: BoxFit.contain,
                                            ),
                                            AutoSizeText(
                                              folders.folders[index].name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                              minFontSize: 12,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )),
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
