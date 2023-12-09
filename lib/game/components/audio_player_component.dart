import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:provider/provider.dart';
import 'package:hurry_hockey/config/assets/audio_assets.dart';
import 'package:hurry_hockey/game/hurry_hockey.dart';

import '../../models/models.dart';

class AudioPlayerComponent extends Component
    with HasGameReference<HurryHockey> {
  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache.loadAll([AudioAssets.bgAudio]);
    return super.onLoad();
  }

  void playBgm(String filename) {
    if (!FlameAudio.audioCache.loadedFiles.containsKey(filename)) return;

    if (game.buildContext != null) {
      if (Provider.of<Settings>(game.buildContext!, listen: false).bgm) {
        FlameAudio.bgm.play(filename);
      }
    }
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
