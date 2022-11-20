import 'dart:async';

import 'package:magic/app/app.locator.dart';
import 'package:magic/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  initialise() {
    Future.delayed(Duration(milliseconds: 1500), () {
      _navigationService.clearStackAndShow(Routes.workOutListView);
    });
  }

}
