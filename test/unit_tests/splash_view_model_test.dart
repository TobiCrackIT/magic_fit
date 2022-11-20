import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/app.router.dart';
import 'package:magic/ui/splash/splash_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import '../helpers/test_helpers.dart';

void main() {
  late NavigationService navigationService;

  late SplashViewModel model;

  setUp(() {
    registerGenericServices();
    navigationService = getAndRegisterNavigationServiceMock();
    model = SplashViewModel();
  });

  tearDown(unregisterGenericServices);

  group('SplashViewModel - ', () {
    group('initialise - ', () {
      test('should navigate to workoutListView when called', () async{
        model.initialise();
        await Future.delayed(const Duration(milliseconds: 1500), (){});
        verify(navigationService.clearStackAndShow(Routes.workOutListView));
      });
    });
  });
}
