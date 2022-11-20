import 'package:magic/app/app.locator.dart';
import 'package:magic/core/services/local_storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<LocalStorageService>(returnNullOnMissingStub: true),
    MockSpec<NavigationService>(returnNullOnMissingStub: true),
  ],
)
MockLocalStorageService getAndRegisterLocalStorageServiceMock() {
  _removeRegistrationIfExists<LocalStorageService>();
  final service = MockLocalStorageService();
  locator.registerSingleton<LocalStorageService>(service);
  return service;
}

MockNavigationService getAndRegisterNavigationServiceMock() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

void registerGenericServices() {
  getAndRegisterLocalStorageServiceMock();
  getAndRegisterNavigationServiceMock();
}

void unregisterGenericServices() {
  locator.unregister<LocalStorageService>();
  locator.unregister<NavigationService>();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
