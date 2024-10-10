import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/webtoon_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WebtoonProvider()..fetchWebtoons(), // Updated method name
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: const TextTheme(
            // You can customize your text theme here
            ),
      ),
      home: const HomeScreen(),
    );
  }
}
