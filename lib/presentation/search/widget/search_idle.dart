import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/applicaton/search/search_bloc.dart';
import 'package:netflix/core/colors/constants.dart';
import 'package:netflix/presentation/search/widget/title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text("Oops"),
                );
              } else if (state.idleList.isEmpty) {
                return const Center(
                  child: Text("List is Empty"),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final movie = state.idleList[index];
                  return TopSearchItemTile(
                      title: movie.title ?? "No title Provided",
                      imageUrl: '$imageAppendUrl${movie.posterPath}');
                },
                separatorBuilder: (context, index) => kHeight20,
                itemCount: state.idleList.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Icon(
          CupertinoIcons.play_circle,
          color: Colors.white,
          size: 50,
        )
      ],
    );
  }
}
