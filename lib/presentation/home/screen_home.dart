import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/applicaton/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constants.dart';
import 'package:netflix/presentation/home/widget/background_card.dart';
import 'package:netflix/presentation/widgets/main_title_card.dart';
import 'widget/number_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                return true;
              },
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                    if (state.isLoading) {
                      const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.isError) {
                      return const Center(
                        child: Text(
                          'Error',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
//relesedpastyear
                    final _releasesPastYear = state.pastYearMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

//trending
                    final _trending = state.trendingrMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
//tensedramas
                    final _tenseDramas = state.tenseDramasMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
//southindiancinema
                    final _sothIndianCinema =
                        state.southIndianMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

// top 10 tv shows
                    final _top10TvShow = state.trendingTvList.map((t) {
                      return '$imageAppendUrl${t.posterPath}';
                    }).toList();

                    return ListView(
                      children: [
                        const BackgroundCard(),
                        MainTitleCard(
                          title: 'Released in the Past Year',
                          posterList: _releasesPastYear.sublist(0, 10),
                        ),
                        kHeight,
                        MainTitleCard(
                          title: 'Trending Now',
                          posterList: _trending.sublist(0, 10),
                        ),
                        kHeight,
                        NumberTitleCard(
                          posterList: _top10TvShow.sublist(0, 10),
                        ),
                        kHeight,
                        MainTitleCard(
                          title: 'Tense Drama',
                          posterList: _tenseDramas.sublist(0, 10),
                        ),
                        kHeight,
                        MainTitleCard(
                          title: 'South Indian Cinema',
                          posterList: _sothIndianCinema.sublist(0, 10),
                        ),
                      ],
                    );
                  }),
                  scrollNotifier.value == true
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 100,
                          color: Colors.black.withOpacity(0.4),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    "https://www.freepnglogos.com/uploads/netflix-logo-circle-png-5.png",
                                    width: 70,
                                    height: 70,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.cast,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  kWidth,
                                  Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.blue,
                                  ),
                                  kWidth,
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "TV Shows",
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    "Movies",
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    "Categories",
                                    style: kHomeTitleText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : kHeight,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
