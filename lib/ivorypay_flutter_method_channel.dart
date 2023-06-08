import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ivorypay_flutter_platform_interface.dart';

/// An implementation of [IvorypayFlutterPlatform] that uses method channels.
class MethodChannelIvorypayFlutter extends IvorypayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ivorypay_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
