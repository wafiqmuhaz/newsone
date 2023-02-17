// ignore_for_file: prefer_single_quotes, constant_identifier_names, always_use_package_imports, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

class MenuItems {
  MenuItems(this.context);

  final BuildContext context;

  String get copy =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!.copyLink;
  String get openInBrowser =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!
          .openInBrowser;
  String get share =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!.shareVia;

  List<String> get choices => <String>[
        copy,
        openInBrowser,
        share,
      ];
}


// class MenuItems {
//   static const String Copy = "Copy Link";
//   static const String Open_In_Browser = "Open in Browser";
//   static const String Share = "Share via...";

//   static const List<String> choices = <String>[
//     Copy,
//     Open_In_Browser,
//     Share,
//   ];
// }
