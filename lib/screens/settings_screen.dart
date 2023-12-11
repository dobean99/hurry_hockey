import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hurry_hockey/config/assets/assets.dart';
import 'package:hurry_hockey/config/l10n/l10n.dart';
import 'package:hurry_hockey/screens/main_menu.dart';
import 'package:hurry_hockey/widgets/commons/base_layout.dart';
import 'package:hurry_hockey/widgets/commons/circle_stroke_button.dart';
import 'package:hurry_hockey/widgets/commons/title_screen.dart';
import '../models/models.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              TitleScreen(
                text: context.l10n!.settings,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Selector<Settings, bool>(
                      selector: (_, settings) => settings.bgm,
                      builder: (context, bgm, __) {
                        return CircleStrokeButton(
                          isEnable: bgm,
                          onPressed: () {
                            bool newValue = !bgm;
                            Provider.of<Settings>(context, listen: false).bgm =
                                newValue;
                          },
                          iconPath: PngAssets.volumeIcon,
                        );
                      }),
                  const SizedBox(
                    width: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Consumer<LocaleProvider>(
                      builder: (context, provider, snapshot) {
                    var lang = provider.locale;
                    return CircleStrokeButton(
                      onPressed: () {
                        Locale locale = _changeLanguage(lang);
                        context.read<LocaleProvider>().setLocale(locale);
                      },
                      iconPath: provider.getIcon(lang),
                    );
                  })
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 30),
              child: CircleStrokeButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ));
                },
                iconPath: PngAssets.homeIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _changeLanguage(Locale lang) {
    switch (lang.languageCode) {
      case 'en':
        return AppLocalizations.supportedLocales[1];
      case 'pt':
        return AppLocalizations.supportedLocales[2];
      case 'ru':
        return AppLocalizations.supportedLocales[0];
    }
  }
}
