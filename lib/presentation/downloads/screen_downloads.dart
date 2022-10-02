import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/applicaton/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constants.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({Key? key}) : super(key: key);

  final _widgetList = [
    const _SmartDownloads(),
    const Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SafeArea(
          child: AppBarWidget(
            title: 'Downloads',
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(5),
        itemBuilder: (context, index) => _widgetList[index],
        separatorBuilder: (context, index) => const SizedBox(height: 25),
        itemCount: _widgetList.length,
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          "Indroducing Downloads for You",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        kHeight,
        const Text(
          "We will indroduce a personalized selection of\nmovies and shows for you, so there's\nalways something to watch on your\ndevice",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        kHeight,
        kHeight,
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.4,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                        ),
                        DownloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads[0].posterPath}',
                          margin: const EdgeInsets.only(left: 170, top: 50),
                          angle: 20,
                          size: Size(size.width * 0.35, size.width * 0.55),
                        ),
                        DownloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads[1].posterPath}',
                          margin: const EdgeInsets.only(right: 170, top: 50),
                          angle: -20,
                          size: Size(size.width * 0.35, size.width * 0.55),
                        ),
                        DownloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads[2].posterPath}',
                          radius: 8,
                          margin: const EdgeInsets.only(bottom: 30, top: 50),
                          size: Size(size.width * 0.4, size.width * 0.6),
                        ),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Set up",
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kHeight,
        kHeight,
        MaterialButton(
          color: kButtonColorWhite,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See what you can download",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kWidth,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth,
        Text("Smart Downloads")
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    Key? key,
    this.angle = 0,
    required this.imageList,
    required this.margin,
    required this.size,
    this.radius = 10,
  }) : super(key: key);

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageList,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
