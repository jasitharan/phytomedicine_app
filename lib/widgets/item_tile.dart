import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final Function handlerFunction;
  final String imageName;
  final String title;
  const ItemTile(
      {Key? key,
      required this.handlerFunction,
      required this.title,
      required this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              color: const Color.fromRGBO(37, 55, 72, 1),
              border:
                  Border.all(color: const Color.fromRGBO(165, 165, 165, 0.21))),
          height: 125,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage('assets/images/$imageName.png')),
              SizedBox(
                width: 150,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromRGBO(189, 189, 189, 1)),
                ),
              ),
              const SizedBox(),
              const SizedBox(),
            ],
          )),
    );
  }
}
