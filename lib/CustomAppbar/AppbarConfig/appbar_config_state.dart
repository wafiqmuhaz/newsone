part of 'appbar_config_cubit.dart';

// @immutable
// abstract class AppbarConfigState {}

// class AppbarConfigInitial extends AppbarConfigState {}
class AppbarConfigState {
  const AppbarConfigState({
    this.currentLocale = const Locale('en'),
  });
  final Locale currentLocale;

  AppbarConfigState copyWith({
    Locale? currentLocale,
  }) {
    return AppbarConfigState(
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
}
