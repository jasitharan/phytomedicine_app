import 'package:flutter/material.dart';

import '../screens/files_screen.dart';

void showPopupMenu(
    BuildContext context, Offset globalPosition, String uid, int index) async {
  double left = globalPosition.dx;
  double right = globalPosition.dx;
  double top = globalPosition.dy;

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
        value: 1,
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
        default:
      }
    }
  });
}
