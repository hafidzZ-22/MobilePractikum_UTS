import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:utsmobile/main.dart';

void main() {
  testWidgets('Splash screen tampil saat katalog dimuat',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GamerZoneApp());

    expect(find.text('GamerZone'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
