import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ombd/core/bloc/base_cubit.dart';
import 'package:ombd/core/network/network_constants.dart';
import 'package:ombd/features/movies/data/models/request/movies_parameter_model.dart';
import 'package:ombd/features/movies/data/models/response/movies_response_model.dart';
import 'package:ombd/features/movies/domain/repository/movies_repo.dart';

part 'movies_state.dart';

class MoviesCubit extends BaseCubit<MoviesState> {
  MoviesCubit({required this.moviesRepo}) : super(const MoviesState());

  final MoviesRepo moviesRepo;

  Future getMovieDetails({required String searchFilter}) async {
    try {
      emit(state.copyWith(status: MoviesStatus.loading));

      MoviesParameterModel moviesParameterModel =
          MoviesParameterModel(apiKey: kAPIKey, search: searchFilter);
      final response = await moviesRepo.getMovieDetails(moviesParameterModel);

      response.fold((failure) {
        emit(state.copyWith(
            status: MoviesStatus.failure, message: handleException(failure)));
      }, (r) {
        emit(state.copyWith(
            status: MoviesStatus.success,
            moviesResponseModel: r,
            message: "Successfully fetched movie details"));
      });
    } catch (e, s) {
      emit(state.copyWith(
          status: MoviesStatus.failure,
          message: "Something went wrong, please try again!"));
      debugPrint(e.toString());
    }
  }
}
