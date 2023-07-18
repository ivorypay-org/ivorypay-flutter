import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ivorypay_flutter_alt_method_channel.dart';

abstract class IvorypayFlutterAltPlatform extends PlatformInterface {
  /// Constructs a IvorypayFlutterAltPlatform.
  IvorypayFlutterAltPlatform() : super(token: _token);

  static final Object _token = Object();

  static IvorypayFlutterAltPlatform _instance = MethodChannelIvorypayFlutterAlt();

  /// The default instance of [IvorypayFlutterAltPlatform] to use.
  ///
  /// Defaults to [MethodChannelIvorypayFlutterAlt].
  static IvorypayFlutterAltPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IvorypayFlutterAltPlatform] when
  /// they register themselves.
  static set instance(IvorypayFlutterAltPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
