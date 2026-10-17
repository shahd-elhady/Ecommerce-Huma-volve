import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app_huma_volve/core/di/injection.dart';
import 'package:ecommerce_app_huma_volve/main.dart';

void main() {
  testWidgets('App launches splash branding', (WidgetTester tester) async {
    AppInjector.init();
    await tester.pumpWidget(const MyApp());
    expect(find.text('Huma-volve'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
