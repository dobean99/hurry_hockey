class PngAssets {
  //get full path file name .png ==> example "assets/images/blue_ballon.png"
  static String get logo => 'logo_text'.png;
  static String get backgroundImage => 'background_image'.png;
  static String get homeIcon => 'home_icon'.png;
  static String get playIcon => 'play_icon'.png;
  static String get settingsIcon => 'settings_icon'.png;
  static String get infoIcon => 'info_icon'.png;

  static String get volumeIcon => 'volume_icon'.png;
  static String get volumeOffIcon => 'volume_off_icon'.png;

  static String get engIcon => 'eng'.png;
  static String get porIcon => 'por'.png;
  static String get rusIcon => 'rus'.png;

  static String get pauseIcon => 'pause_icon'.png;
  static String get arrowRightIcon => 'arrow_right_icon'.png;
  static String get arrowBackIcon => 'arrow_back_icon'.png;
  static String get playAgainIcon => 'play_again_icon'.png;

  static String get cupIcon => 'cup_icon'.png;
  static String get boardBackground => 'board_background'.png;
  static String get backgroundGameplay => 'background_gameplay'.png;

//get only file name .png ==> example "blue_ballon.png"
  static String get player => 'player'.src;
  static String get background => 'background_image'.src;
  static String get clockIcon => 'clock'.src;
  const PngAssets._();
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get src => '$this.png';
}
