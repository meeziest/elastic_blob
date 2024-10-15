import 'package:elastic_blob/elastic_blob.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const blobRadius = 50.0;
    return Scaffold(
      body: Center(
        child: ElasticBlob(
          radius: blobRadius,
          underBlobWidget: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onSurface,
            size: blobRadius,
          ),
          aboveBlobWidget: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onPrimary,
            size: blobRadius,
          ),
          duration: const Duration(milliseconds: 350),
        ),
      ),
    );
  }
}
