import 'package:flutter/material.dart';
import '../../features/app_state.dart';

class AppStateScope extends InheritedWidget {
  final AppState appState;

  const AppStateScope({
    super.key,
    required this.appState,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final AppStateScope? result =
    context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(result != null, 'No AppStateScope found in context');
    return result!.appState;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return appState != oldWidget.appState;
  }
}