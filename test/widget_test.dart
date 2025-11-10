import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Salad Catalog basic UI test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const SaladApp());

    // Cek judul di AppBar
    expect(find.text('Katalog Salad Buah'), findsOneWidget);

    // Cek Tab List & Grid
    expect(find.text('List View'), findsOneWidget);
    expect(find.text('Grid View'), findsOneWidget);

    // Cek ada produk pertama di List
    expect(find.text('Salad Strawberry'), findsOneWidget);
    expect(find.text('Rp 15.000'), findsOneWidget);

    // Pindah ke Grid View
    await tester.tap(find.text('Grid View'));
    await tester.pumpAndSettle();

    // Pastikan produk tetap muncul di Grid View
    expect(find.text('Salad Strawberry'), findsOneWidget);
  });
}
