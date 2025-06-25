import 'package:flutter_task/providers/auth_provider.dart';
import 'package:flutter_task/providers/note_provider.dart';
import 'package:flutter_task/repositories/auth_repository.dart';
import 'package:flutter_task/repositories/firestore_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerLocators() async{
  getIt.registerSingleton<AuthRepository>(AuthRepository());
  getIt.registerSingleton<FireStoreRepository>(FireStoreRepository());
  getIt.registerLazySingleton(() => AuthProvider(getIt()));
  getIt.registerLazySingleton(() => NotesProvider(getIt()));
}