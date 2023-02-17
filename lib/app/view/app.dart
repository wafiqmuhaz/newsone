// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsone/l10n/l10n.dart';

import '../../CustomAppbar/AppbarConfig/appbar_config_cubit.dart';
import '../../news/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppbarConfigCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
              colorScheme: ColorScheme.fromSwatch(
                accentColor: const Color(0xFF13B9FF),
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: context.watch<AppbarConfigCubit>().state.currentLocale,
            home: HomeScreen(
              category: 'terkini',
            ),
          );
        },
      ),
    );
    // BlocProvider(
    //   create: (context) => AppbarConfigCubit(),
    //   child:

    //   ),
    // );
  }
}
