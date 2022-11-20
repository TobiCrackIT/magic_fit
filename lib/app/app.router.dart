// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/splash/splash_view.dart';
import '../ui/workout/workout_view.dart';
import '../ui/workout_list/workout_list_view.dart';

class Routes {
  static const String splashView = '/';
  static const String workOutListView = '/work-out-list-view';
  static const String workoutView = '/workout-view';
  static const all = <String>{
    splashView,
    workOutListView,
    workoutView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.workOutListView, page: WorkOutListView),
    RouteDef(Routes.workoutView, page: WorkoutView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SplashView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    WorkOutListView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const WorkOutListView(),
        settings: data,
      );
    },
    WorkoutView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const WorkoutView(),
        settings: data,
      );
    },
  };
}
