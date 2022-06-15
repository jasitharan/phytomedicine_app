import 'package:flutter/material.dart';

Future<void> showFolderDialog({
  required BuildContext context,
  bool isEdit = false,
  required Function hanlder,
}) async {
  String value = '';
  bool error = false;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(37, 55, 72, 1),
        titlePadding: const EdgeInsets.all(0.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(26, 183, 168, 1)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(26, 183, 168, 1),
                  Color.fromRGBO(94, 209, 151, 1)
                ],
              )),
          width: double.infinity,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Text(
                isEdit ? 'Rename' : 'Create',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/close.png',
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Entre the file name that you want to ' +
                      (isEdit ? 'rename' : 'create'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(26, 42, 56, 1),
                    border: InputBorder.none,
                    errorText: error ? 'Please enter valid input' : null,
                  ),
                  onChanged: (val) {
                    value = val;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  child: Text(
                    isEdit ? 'Save' : 'Create',
                    style: const TextStyle(
                      color: Color.fromRGBO(26, 183, 168, 1),
                    ),
                  ),
                  onPressed: () {
                    if (value.isNotEmpty) {
                      hanlder(value);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        error = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
