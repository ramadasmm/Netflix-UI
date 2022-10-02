import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

import '../../../core/colors/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({
    Key? key,
    required this.index,
    required this.imageUrl,
  }) : super(key: key);

  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 50,
              height: 250,
            ),
            Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 20,
          bottom: -25,
          child: BorderedText(
            strokeWidth: 4,
            strokeColor: kWhiteColor,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 150,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationColor: kWhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
