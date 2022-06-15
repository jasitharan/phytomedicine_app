import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/folder_model.dart';
import 'package:phytomedicine_app/widgets/show_dialogs.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../screens/files_screen.dart';
import '../services/folders_provider.dart';

Future showPopupMenu(
    BuildContext context, Offset globalPosition, String uid, int index) async {
  double left = globalPosition.dx;
  double right = globalPosition.dx;
  double top = globalPosition.dy;

  final user = Provider.of<Auth?>(context, listen: false);
  final folders = Provider.of<FolderProvider>(context, listen: false);

  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, right, 0),
    color: const Color.fromRGBO(37, 55, 72, 1),
    items: [
      PopupMenuItem(
        value: 1,
        child: RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  Icons.remove_red_eye,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: "   ",
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: "Open",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  Icons.edit,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: "   ",
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: "Rename",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      PopupMenuItem(
        value: 3,
        child: RichText(
          text: const TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  Icons.delete,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: "   ",
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    if (value != null) {
      switch (value) {
        case 1:
          Navigator.pushNamed(context, FilesScreen.routeName, arguments: {
            'uid': uid,
          });
          break;
        case 2:
          showFolderDialog(
            context: context,
            isEdit: true,
            hanlder: (val) {
              FolderModel model =
                  folders.folders.where((element) => element.uid == uid).first;
              model.name = val;
              folders.editFolders(model, user!.uid);
            },
          );
          break;
        case 3:
          FolderModel model =
              folders.folders.where((element) => element.uid == uid).first;
          String folderId = model.uid!;

          folders.folders.removeWhere((element) => element.uid == uid);

          folders.deleteFolders(folderId, user!.uid);
          break;
        default:
      }
    }
  });
}
