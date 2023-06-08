import 'package:flutter_test/flutter_test.dart';
import 'package:ivorypay_flutter/ivorypay_flutter.dart';
import 'package:ivorypay_flutter/ivorypay_flutter_platform_interface.dart';
import 'package:ivorypay_flutter/ivorypay_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIvorypayFlutterPlatform
    with MockPlatformInterfaceMixin
    implements IvorypayFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IvorypayFlutterPlatform initialPlatform = IvorypayFlutterPlatform.instance;

  test('$MethodChannelIvorypayFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIvorypayFlutter>());
  });

  test('getPlatformVersion', () async {
    IvorypayFlutter ivorypayFlutterPlugin = IvorypayFlutter();
    MockIvorypayFlutterPlatform fakePlatform = MockIvorypayFlutterPlatform();
    IvorypayFlutterPlatform.instance = fakePlatform;

    expect(await ivorypayFlutterPlugin.getPlatformVersion(), '42');
  });
}