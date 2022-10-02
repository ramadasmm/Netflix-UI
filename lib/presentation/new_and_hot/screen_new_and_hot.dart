import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/dom_parsing.dart';
import 'package:intl/intl.dart';
import 'package:netflix/applicaton/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching.dart';
import '../../core/colors/constants.dart';
import 'widgets/coming_soon_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
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
            bottom: TabBar(
              labelColor: kBlackColor,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: kWhiteColor,
              isScrollable: true,
              indicator:
                  BoxDecoration(color: kWhiteColor, borderRadius: kRadius30),
              tabs: const [
                Tab(
                  text: "🍿 Coming Soon",
                ),
                Tab(
                  text: "👀 Everyone's Watching",
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ComingSoonList(
              key: Key('coming_soon'),
            ),
            EveryOneIsWatchingList(
              key: Key('everyone_is_watching'),
            )
          ],
        ),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInCommingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInCommingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(child: Text('Oops'));
          } else if (state.comingSoonList.isEmpty) {
            return const Center(child: Text('List is Empty'));
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  final _date = DateTime.parse(movie.releaseDate!);
                  final formatedDate = DateFormat.yMMMMd('en_US').format(_date);
                  return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: formatedDate
                        .split(' ')
                        .first
                        .substring(0, 3)
                        .toUpperCase(),
                    day: movie.releaseDate!.split('-')[1],
                    posterPath: '$imageAppendUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No title',
                    description: movie.overview ?? 'No Description',
                    url: '$imageAppendUrl${movie.posterPath}',
                  );
                });
          }
        },
      ),
    );
  }
}

class EveryOneIsWatchingList extends StatelessWidget {
  const EveryOneIsWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(child: Text('Oops'));
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(child: Text('List is Empty'));
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: state.everyOneIsWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.everyOneIsWatchingList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  final tv = state.everyOneIsWatchingList[index];
                  return EveryonesWatchingWidget(
                    posterPath: '$imageAppendUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No Name',
                    description: tv.overview ?? 'No Description',
                  );
                });
          }
        },
      ),
    );
  }
}
