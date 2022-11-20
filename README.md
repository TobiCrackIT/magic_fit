# magic

A new Flutter project.

## Getting Started

This project is a demo Flutter application.
This project was built using [Stacked Architecture](https://www.notion.so/bushainc/Stacked-Architecture-1f7bfd33e37c41bca3b7f500f159eab8), an MVVM -inspired architecture for Flutter

I have used the following 3rd-party packages
1. hive & [hive_flutter](https://pub.dev/packages/hive_flutter) - Flutter implementation of the hive database, a fast and secure NoSQL database
2. [stacked](https://pub.dev/packages/stacked) - App architecture
3. [intl](https://pub.dev/packages/intl) - for utilities like parsing time and date
4. [logger](https://pub.dev/packages/logger) - for logging information while in development
5. The other packages are for code generation

A few tips on how to run this project:

- Run `flutter run` to build generate hive models
- Run `flutter packages pub run build_runner build --delete-conflicting-outputs` to build generate hive models
- Run `flutter test test/unit_tests` to run the unit tests
- Run `flutter test test/widget_tests` to run the widget tests
- Run `flutter test test` to run all tests


