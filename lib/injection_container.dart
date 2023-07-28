import 'package:get_it/get_it.dart';
import 'package:news_test_task/bloc/news_bloc.dart';
import 'package:news_test_task/repositories/news_repo.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerLazySingleton<NewsInitState>(() => NewsInitState());
  sl.registerLazySingleton<NewsRepo>(() => NewsRepo());
  sl.registerLazySingleton<NewsBloc>(
    () => NewsBloc(
      initialState: sl<NewsInitState>(),
      newsRepo: sl<NewsRepo>(),
    ),
  );
}
