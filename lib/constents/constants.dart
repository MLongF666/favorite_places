import 'package:flutter/material.dart';
import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
class kFrameWidget extends StatelessWidget {
  const kFrameWidget({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: content,
    );
  }
}
class ConstConfig {
  static const AMapApiKey amapApiKeys = AMapApiKey(iosKey: "22222",androidKey: "3bdfd45c544900d1fa036e23aed55638");

  static AMapPrivacyStatement amapPrivacyStatement= const AMapPrivacyStatement(hasContains: true,hasShow: true,hasAgree: true);
}
