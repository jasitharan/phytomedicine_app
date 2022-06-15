import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phytomedicine_app/models/auth_model.dart';
import 'package:phytomedicine_app/models/folder_model.dart';
import 'package:phytomedicine_app/shared/custom_scroll.dart';
import 'package:phytomedicine_app/shared/loading.dart';
import 'package:provider/provider.dart';

import '../services/folders_provider.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({Key? key}) : super(key: key);

  static const routeName = '/files-screen';

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  bool _loading = false;
  bool _isInit = true;
  String uid = '';
  String name = '';
  List<String> files = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final folders = Provider.of<FolderProvider>(context);
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

      FolderModel thisFolder =
          folders.folders.where((element) => element.uid == args['uid']).first;

      files = thisFolder.filesUrls!;
      name = thisFolder.name;
      uid = args['uid']!;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final folders = Provider.of<FolderProvider>(context);
    final user = Provider.of<Auth>(context);

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
                          AutoSizeText(
                            '$name Images',
                            minFontSize: 20,
                            maxFontSize: 24,
                            style: const TextStyle(color: Colors.white),
                          ),
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
                                    height: 40,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      setState(() {
                                        _loading = true;
                                      });
                                      String? imageUrl =
                                          await folders.uploadFile(
                                              ImageSource.gallery, user.uid);

                                      if (imageUrl != null) {
                                        FolderModel model = folders.folders
                                            .where(
                                                (element) => element.uid == uid)
                                            .first;
                                        model.filesUrls?.add(imageUrl);
                                        setState(() {
                                          _loading = false;
                                        });
                                        folders.editFolders(model, user.uid);
                                      } else {
                                        setState(() {
                                          _loading = false;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.upload),
                                    label: const Text('Upload Image'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromRGBO(
                                                  26, 183, 168, 1)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                      ),
                                      itemCount: files.length,
                                      itemBuilder: (context, index) {
                                        return CachedNetworkImage(
                                          alignment: Alignment.center,
                                          imageUrl: files[index],
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const SpinKitCubeGrid(
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        );
                                      },
                                    ),
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
