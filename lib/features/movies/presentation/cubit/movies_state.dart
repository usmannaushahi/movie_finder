part of 'movies_cubit.dart';

enum MoviesStatus {
  initial,
  loading,
  success,
  failure,
}

class MoviesState extends Equatable {
  final String? message;
  final MoviesStatus? status;
  final MoviesResponseModel? moviesResponseModel;

  const MoviesState(
      {this.message = "",
      this.status = MoviesStatus.initial,
      this.moviesResponseModel});

  MoviesState copyWith({
    MoviesStatus? status,
    String? message,
    MoviesResponseModel? moviesResponseModel,
  }) {
    return MoviesState(
        status: status ?? this.status,
        message: message ?? this.message,
        moviesResponseModel: moviesResponseModel ?? this.moviesResponseModel);
  }

  @override
  List<Object?> get props => [status, message, moviesResponseModel];
}
