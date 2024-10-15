import 'package:elastic_blob/src/elastic_blob_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ElasticBlob widget test', (WidgetTester tester) async {
    const testKey = Key('elastic_blob');

    // Build the ElasticBlob widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElasticBlob(
            key: testKey,
            radius: 50,
            underBlobWidget: Container(color: Colors.blue),
            aboveBlobWidget: Container(color: Colors.red),
          ),
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);

    final gesture = await tester.startGesture(const Offset(100, 100));
    await gesture.moveBy(const Offset(50, 50));
    await gesture.up();

    await tester.pump();
  });
}
