import 'package:magic/core/services/local_storage_service.dart';
import 'package:magic/ui/splash/splash_view.dart';
import 'package:magic/ui/workout/workout_view.dart';
import 'package:magic/ui/workout_list/workout_list_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CustomRoute(
      page: SplashView,
      initial: true,
      durationInMilliseconds: 300,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    AdaptiveRoute(page: WorkOutListView),
    AdaptiveRoute(page: WorkoutView),
  ],
  dependencies: [
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
  ],
  logger: StackedLogger(disableReleaseConsoleOutput: true),
)
class AppSetup {}
