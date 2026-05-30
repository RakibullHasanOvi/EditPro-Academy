import 'package:flutter/material.dart';

final ScrollController appScroll = ScrollController();

final GlobalKey heroKey     = GlobalKey();
final GlobalKey coursesKey  = GlobalKey();
final GlobalKey featuresKey = GlobalKey();
final GlobalKey footerKey   = GlobalKey();

void scrollTo(GlobalKey key) {
  final ctx = key.currentContext;
  if (ctx != null) {
    Scrollable.ensureVisible(ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }
}
