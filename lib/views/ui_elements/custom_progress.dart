//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:exomind_case/data/static.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildButton() => OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: BorderSide(width: 2, color: Colors.blue.shade600),
      ),
      child: FittedBox(
        child: Text(
          "Test Button",
          style: TextStyle(
            fontSize: 25,
            color: Colors.blue.shade600,
          ),
        ),
      ),
      onPressed: () {},
    );

Widget buildLoadingButton() => Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade600),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
