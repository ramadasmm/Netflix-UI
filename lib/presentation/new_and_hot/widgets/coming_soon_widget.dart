import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/colors/constants.dart';
import '../../home/widget/custom_button_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String url;
  final String description;

  const ComingSoonWidget(
      {super.key,
      required this.id,
      required this.month,
      required this.day,
      required this.posterPath,
      required this.movieName,
      required this.url,
      required this.description});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                month,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 7),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 60,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.network(
                      url,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      CustomButtonWidget(
                        icon: CupertinoIcons.bell,
                        title: "Remind Me",
                        iconSize: 30,
                        textSize: 14,
                      ),
                      kWidth,
                      CustomButtonWidget(
                        icon: CupertinoIcons.info_circle,
                        title: "Info",
                        iconSize: 30,
                        textSize: 14,
                      ),
                      kWidth,
                    ],
                  ),
                ],
              ),
              kHeight,
              Text(
                "Coming On $day $month",
                style: TextStyle(color: Colors.grey.shade100),
              ),
              kHeight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: -1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHeight,
              Text(
                description,
                maxLines: 4,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
