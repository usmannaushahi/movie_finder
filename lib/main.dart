import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd/core/bloc/bloc_observer.dart';
import 'package:ombd/core/di/injection_container.dart';
import 'package:ombd/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:ombd/features/movies/presentation/screens/movies_screen.dart';

void main() async {
  runZonedGuarded(() async {
    await BlocOverrides.runZoned(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await initDI();
        runApp(const MyApp());
      },
      blocObserver: CubitObserver(),
    );
  }, (error, stack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMBD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => serviceLocator<MoviesCubit>(),
        child: const MoviesScreen(),
      ),
    );
  }
}
