import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ivorypay_flutter_method_channel.dart';

abstract class IvorypayFlutterPlatform extends PlatformInterface {
  /// Constructs a IvorypayFlutterPlatform.
  IvorypayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static IvorypayFlutterPlatform _instance = MethodChannelIvorypayFlutter();

  /// The default instance of [IvorypayFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelIvorypayFlutter].
  static IvorypayFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IvorypayFlutterPlatform] when
  /// they register themselves.
  static set instance(IvorypayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
