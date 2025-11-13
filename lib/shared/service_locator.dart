import 'package:flutter_pract/features/app_state.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator(AppState appState) {
  locator.registerSingleton<AppState>(appState);
}