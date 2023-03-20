import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd/core/common_widgets/common_search_bar.dart';
import 'package:ombd/core/common_widgets/common_snack_bars.dart';
import 'package:ombd/features/movies/data/models/response/movies_response_model.dart';
import 'package:ombd/features/movies/presentation/cubit/movies_cubit.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoviesCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Movie Finder'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                hintText: "Search a Movie..",
                textEditingController: _textEditingController,
                onPressed: () async {
                  await cubit.getMovieDetails(
                      searchFilter: _textEditingController.text);
                },
              ),
            ),
            BlocConsumer<MoviesCubit, MoviesState>(
              buildWhen: (context, state) =>
                  state.status == MoviesStatus.success ||
                  state.status == MoviesStatus.failure ||
                  state.status == MoviesStatus.loading,
              listener: (context, state) {
                if (state.status == MoviesStatus.failure) {
                  commonSnackBar(
                      context: context,
                      msg: state.message ??
                          "Something went wrong, please try again!",
                      status: SnackBarStatusEnum.failure);
                }
              },
              builder: (context, state) {
                List<Search> moviesList =
                    state.moviesResponseModel?.search ?? [];
                return state.status == MoviesStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: moviesList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(
                                    moviesList[index].poster ?? ""),
                                title: Text(moviesList[index].title ?? "-"),
                                subtitle: Text(moviesList[index].type ?? ""),
                                trailing: Text(moviesList[index].year ?? ""),
                              );
                            }),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
