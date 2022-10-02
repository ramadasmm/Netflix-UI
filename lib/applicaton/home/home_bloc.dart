import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/applicaton/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new_resp/hot_and_new_service.dart';

import '../../domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeServie;
  HomeBloc(this._homeServie) : super(HomeState.initial()) {
    //on event get home screen data
    on<GetHomeScreenData>((event, emit) async {
      //send loading to UI
      emit(state.copyWith(isLoading: true, isError: false));
      //get Data
      final _movieResult = await _homeServie.getHotAndNewMovieData();
      final _tvResult = await _homeServie.getHotAndNewTvData();

      //transform data
      final _state1 = _movieResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingrMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          final pastYear = resp.results;
          final trending = resp.results;
          final dramas = resp.results;
          final southIndian = resp.results;

          pastYear.shuffle();
          trending.shuffle();
          dramas.shuffle();
          southIndian.shuffle();
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            trendingrMovieList: trending,
            tenseDramasMovieList: dramas,
            southIndianMovieList: southIndian,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(_state1);

      final _state2 = _tvResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingrMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          final top10List = resp.results;
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            trendingrMovieList: top10List,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: top10List,
            isLoading: false,
            isError: false,
          );
        },
      );
      //send to UI
      emit(_state2);
    });
  }
}
