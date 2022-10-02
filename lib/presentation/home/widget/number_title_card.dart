import 'package:flutter/material.dart';

import '../../../core/colors/constants.dart';
import '../../widgets/main_title.dart';
import 'number_card.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
    required this.posterList,
  }) : super(key: key);

  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(
          title: "Top 10 TV Shows in India Today",
        ),
        kHeight,
        LimitedBox(
          maxHeight: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) => NumberCard(
                index: index,
                imageUrl: posterList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
