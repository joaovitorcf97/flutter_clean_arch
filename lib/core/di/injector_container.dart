import 'package:flutter_clean_arch/features/habits/data/datasource/habit_local_datasource.dart';
import 'package:flutter_clean_arch/features/habits/data/datasource/habit_local_datasource_impl.dart';
import 'package:flutter_clean_arch/features/habits/data/repositories/habit_repository_impl.dart';
import 'package:flutter_clean_arch/features/habits/domain/repositories/habit_repository.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/get_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/insert_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/update_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Data sources
  sl.registerLazySingleton<HabitLocalDatasource>(
    () => HabitLocalDatasourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(sl<HabitLocalDatasource>()),
  );

  // Usecases
  sl.registerLazySingleton<GetHabitUseCase>(
    () => GetHabitUseCase(sl<HabitRepository>()),
  );
  sl.registerLazySingleton<InsertHabitUseCase>(
    () => InsertHabitUseCase(sl<HabitRepository>()),
  );
  sl.registerLazySingleton<UpdateHabitUseCase>(
    () => UpdateHabitUseCase(sl<HabitRepository>()),
  );
  sl.registerLazySingleton<DeleteHabitUseCase>(
    () => DeleteHabitUseCase(sl<HabitRepository>()),
  );

  // Cubit
  sl.registerLazySingleton<HabitCubit>(
    () => HabitCubit(
      sl<GetHabitUseCase>(),
      sl<InsertHabitUseCase>(),
      sl<UpdateHabitUseCase>(),
      sl<DeleteHabitUseCase>(),
    ),
  );
}
