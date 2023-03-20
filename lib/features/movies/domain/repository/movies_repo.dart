import 'package:dartz/dartz.dart';
import 'package:ombd/features/movies/data/models/request/movies_parameter_model.dart';
import 'package:ombd/features/movies/data/models/response/movies_response_model.dart';

abstract class MoviesRepo {
  Future<Either<Exception, MoviesResponseModel>> getMovieDetails(
      MoviesParameterModel moviesParameterModel);
}
