import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ivorypay_flutter/ivorypay_flutter_method_channel.dart';

void main() {
  MethodChannelIvorypayFlutter platform = MethodChannelIvorypayFlutter();
  const MethodChannel channel = MethodChannel('ivorypay_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
