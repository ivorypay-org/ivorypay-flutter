import 'package:ivorypay_flutter/model/Initiate_ivorypay_transaction.dart';
import 'package:ivorypay_flutter/widget/checkout_service.dart';
import 'package:ivorypay_flutter/widget/inapp_webview.dart';

import 'ivorypay_flutter_platform_interface.dart';

class IvorypayFlutter {
  Future<String?> getPlatformVersion() {
    return IvorypayFlutterPlatform.instance.getPlatformVersion();
  }

// static runWebView() {
//   return InAppWebView(
//     url: 'https://www.ivorypay.io/',
//   );
// }
}
