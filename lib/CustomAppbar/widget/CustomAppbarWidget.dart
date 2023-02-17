// ignore_for_file: unused_element, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, always_use_package_imports, lines_longer_than_80_chars, flutter_style_todos, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/l10n.dart';
import '../CustomAppbar.dart';

// void main() {
//   Widget _wrapWithMaterialApp(Widget CustomAppBar) {
//     return MaterialApp(
//       home: CustomAppBar,
//     );
//   }
// }

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // ignore: todo
    // TODO: implement build
    return AppBar(
      // systemOverlayStyle:
//             SystemUiOverlayStyle(statusBarColor: Colors.transparent),
//         backgroundColor: Colors.transparent,
//         elevation: 1,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               Transition(
//                 child: CategoryScreen(),
//                 transitionEffect: TransitionEffect.LEFT_TO_RIGHT,
//               ),
//             );
//           },
//           icon: Icon(
//             Icons.amp_stories_outlined,
//             size: 30,
//           ),
//         ),
      title: Text(
        l10n.counterAppBarTitle,
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          elevation: 1,
          itemBuilder: (context) {
            return AppLocalizations.supportedLocales.map(
              (locale) {
                return PopupMenuItem<String>(
                  value: locale.languageCode,
                  child: Text(
                    Utils.localeToCountryName(locale),
                  ),
                );
              },
            ).toList();
          },
          onSelected: (value) {
            context.read<AppbarConfigCubit>().changeLanguage(
                  Locale(value),
                );
          },
        ),
      ],
    );
    // throw UnimplementedError();
  }
}

// systemOverlayStyle:
//             SystemUiOverlayStyle(statusBarColor: Colors.transparent),
//         backgroundColor: Colors.transparent,
//         elevation: 1,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               Transition(
//                 child: CategoryScreen(),
//                 transitionEffect: TransitionEffect.LEFT_TO_RIGHT,
//               ),
//             );
//           },
//           icon: Icon(
//             Icons.amp_stories_outlined,
//             size: 30,
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text(
//               'News',
//               style: TextStyle(color: Color(0xff50A3A4)),
//             ),
//             Text(
//               'One',
//               style: TextStyle(color: Color.fromARGB(255, 56, 180, 252)),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               // await themeProvider.toggleThemeData();
//               // setState(() {
//               //   themeIcon = themeProvider.themeIcon();
//               // });
//             },
//             icon: themeIcon,
//           ),
//         ],
  
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => throw UnimplementedError();
// }
