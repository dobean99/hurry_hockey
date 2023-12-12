import 'package:flutter/material.dart';
import 'package:hurry_hockey/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:hurry_hockey/config/assets/assets.dart';
import 'package:hurry_hockey/screens/main_menu.dart';
import 'package:hurry_hockey/widgets/commons/base_layout.dart';
import 'package:hurry_hockey/widgets/commons/circle_stroke_button.dart';
import '../models/models.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.5),
              ),
              constraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                  maxWidth: MediaQuery.sizeOf(context).width - 300,
                  maxHeight: MediaQuery.sizeOf(context).height - 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Selector<Settings, bool>(
                      selector: (_, settings) => settings.bgm,
                      builder: (context, bgm, __) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleStrokeButton(
                              isEnable: bgm,
                              onPressed: () {
                                Provider.of<Settings>(context, listen: false)
                                    .bgm = true;
                              },
                              iconPath: PngAssets.volumeIcon,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            CircleStrokeButton(
                              isEnable: !bgm,
                              onPressed: () {
                                Provider.of<Settings>(context, listen: false)
                                    .bgm = false;
                              },
                              iconPath: PngAssets.volumeOffIcon,
                            )
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<LocaleProvider>(
                          builder: (context, provider, snapshot) {
                        var lang = provider.locale;
                        return CircleStrokeButton(
                          isEnable: lang.languageCode == 'ru',
                          onPressed: () {
                            context
                                .read<LocaleProvider>()
                                .setLocale(const Locale('ru'));
                          },
                          iconPath: PngAssets.rusIcon,
                        );
                      }),
                      const SizedBox(
                        width: 40,
                      ),
                      Consumer<LocaleProvider>(
                          builder: (context, provider, snapshot) {
                        var lang = provider.locale;
                        return CircleStrokeButton(
                          isEnable: lang.languageCode == 'en',
                          onPressed: () {
                            context
                                .read<LocaleProvider>()
                                .setLocale(const Locale('en'));
                          },
                          iconPath: PngAssets.engIcon,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 30),
              child: CircleStrokeButton(
                scale: 1.5,
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
}
