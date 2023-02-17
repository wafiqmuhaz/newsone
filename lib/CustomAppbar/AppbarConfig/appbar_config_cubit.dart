// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'appbar_config_state.dart';

class AppbarConfigCubit extends Cubit<AppbarConfigState> {
  AppbarConfigCubit() : super(const AppbarConfigState());

  void changeLanguage(Locale locale) {
    emit(state.copyWith(currentLocale: locale));
  }
}
