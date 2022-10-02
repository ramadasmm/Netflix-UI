import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/colors/constants.dart';
import '../../home/widget/custom_button_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryonesWatchingWidget(
      {super.key,
      required this.posterPath,
      required this.movieName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieName,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: -2,
            ),
          ),
          kHeight,
          Text(
            description,
            maxLines: 5,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          kHeight,
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  posterPath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 3,
                right: 3,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_up,
                      color: kWhiteColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          kHeight,
          kHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              CustomButtonWidget(
                icon: Icons.telegram,
                title: "Share",
                iconSize: 30,
                textSize: 14,
              ),
              kWidth20,
              CustomButtonWidget(
                icon: CupertinoIcons.add,
                title: "My list",
                iconSize: 30,
                textSize: 14,
              ),
              kWidth20,
              CustomButtonWidget(
                icon: CupertinoIcons.play_fill,
                title: "Play",
                iconSize: 30,
                textSize: 14,
              ),
              kWidth20,
            ],
          ),
        ],
      ),
    );
  }
}
