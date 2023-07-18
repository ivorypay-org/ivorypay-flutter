import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ivorypay_flutter_alt_platform_interface.dart';

/// An implementation of [IvorypayFlutterAltPlatform] that uses method channels.
class MethodChannelIvorypayFlutterAlt extends IvorypayFlutterAltPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ivorypay_flutter_alt');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
