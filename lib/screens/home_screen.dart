import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_app/screens/favorites_screen.dart';
import '../providers/webtoon_provider.dart';
import '../widget/webtoon_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Fantasy Manhwa',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigate to the FavoritesScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<WebtoonProvider>(
        builder: (context, webtoonProvider, child) {
          final webtoons = webtoonProvider.webtoons;
          return ListView.builder(
            itemCount: webtoons.length,
            itemBuilder: (context, index) {
              return WebtoonTile(webtoon: webtoons[index]);
            },
          );
        },
      ),
    );
  }
}
