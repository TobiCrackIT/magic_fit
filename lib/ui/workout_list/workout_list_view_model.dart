import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic/app/app.locator.dart';
import 'package:magic/app/app.router.dart';
import 'package:magic/core/enums/workout_status.dart';
import 'package:magic/core/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WorkOutListViewModel extends BaseViewModel {
  final _localStorageService = locator<LocalStorageService>();
  final _navigationService = locator<NavigationService>();
  final _snackBarService = locator<SnackbarService>();

  late Box box;
  late ValueListenable<Box> workoutBox;

  initialise() {
    setBusy(true);
    box = _localStorageService.getBox();
    workoutBox = box.listenable();
    setBusy(false);
  }

  void viewDetail(int index) {
    _localStorageService.selectedIndex = index;
    _localStorageService.workoutStatus = WorkoutStatus.detail;
    _navigationService.navigateTo(Routes.workoutView);
  }

  void addWorkOut() async {
    _localStorageService.workoutStatus = WorkoutStatus.add;
    var response = await _navigationService.navigateTo(Routes.workoutView);
    if (response != null && response == true) {
      _snackBarService.showSnackbar(
        title: 'Success',
        message: 'Workout added',
      );
    }
  }

  Future<bool> deleteWorkOut(int index) async {
    bool response = await _localStorageService.deleteWorkout(index);
    return response;
  }
}
