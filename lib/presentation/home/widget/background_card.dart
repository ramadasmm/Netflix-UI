import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import 'custom_button_widget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/r8LPeldxskHrGJTPfhICguCip2H.jpg"))),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomButtonWidget(
                  icon: Icons.add,
                  title: "My List",
                ),
                _PlayButton(),
                const CustomButtonWidget(
                  icon: Icons.info,
                  title: "Info",
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextButton _PlayButton() {
    return TextButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kWhiteColor)),
        onPressed: () {},
        icon: const Icon(
          Icons.play_arrow,
          color: kBlackColor,
          size: 25,
        ),
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            "Play",
            style: TextStyle(
              fontSize: 20,
              color: kBlackColor,
            ),
          ),
        ));
  }
}
