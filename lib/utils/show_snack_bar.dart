import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: primaryColor,
  ));
}
