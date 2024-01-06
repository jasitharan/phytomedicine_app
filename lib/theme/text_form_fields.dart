import 'package:flutter/material.dart';

class ClassTextFormField extends StatefulWidget {
  final String? initialValue;
  final bool isPassword;
  final Function(String?) validator;
  final Function(String) onChanged;
  final String? hintText;
  final double? width;
  const ClassTextFormField({
    Key? key,
    this.isPassword = false,
    this.hintText,
    this.initialValue,
    this.width,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  State<ClassTextFormField> createState() => _ClassTextFormFieldState();
}

class _ClassTextFormFieldState extends State<ClassTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        initialValue: widget.initialValue,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(85, 84, 84, 1),
        ),
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 24, 12, 16),
          fillColor: const Color.fromRGBO(255, 255, 255, 1),
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(85, 84, 84, 0.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorMaxLines: 3,
          errorStyle: const TextStyle(fontSize: 14),
        ),
        validator: (val) => widget.validator(val),
        onChanged: (val) => widget.onChanged(val),
      ),
    );
  }
}
