import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
    fillColor: const Color.fromRGBO(165, 165, 165, 0.21),
    filled: true,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(12.0),
    ),
    hintStyle: const TextStyle(color: Color.fromRGBO(189, 189, 189, 1)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
    ));

const years = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
