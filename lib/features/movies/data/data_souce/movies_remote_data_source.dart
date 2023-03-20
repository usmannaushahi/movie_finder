import 'package:dio/dio.dart';
import 'package:ombd/core/error/exception.dart';
import 'package:ombd/core/network/network_client.dart';
import 'package:ombd/features/movies/data/models/request/movies_parameter_model.dart';

abstract class MoviesRemoteDataSource {
  Future<dynamic> getMovieDetails(MoviesParameterModel moviesParameterModel);
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  final NetworkClient networkClient;
  MoviesRemoteDataSourceImpl({required this.networkClient});

  @override
  Future getMovieDetails(MoviesParameterModel moviesParameterModel) async {
    var response = await networkClient.invoke(
      "",
      RequestType.get,
      queryParameters: moviesParameterModel.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw ServerException(
        dioError: DioError(
          error: response,
          type: DioErrorType.response,
          requestOptions: response.requestOptions,
        ),
      );
    }
  }
}
