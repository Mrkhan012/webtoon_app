import 'package:flutter/material.dart';
import '../models/webtoon.dart';
import '../screens/detail_screen.dart';

class WebtoonTile extends StatelessWidget {
  final Webtoon webtoon;

  const WebtoonTile({required this.webtoon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          webtoon.imageUrl,
          width: 50, // Set a fixed size for the image
          height: 50,
          fit: BoxFit.cover, // Ensures the image is cropped properly
        ),
        title: Text(
          webtoon.title,
          style: const TextStyle(fontWeight: FontWeight.bold), // Enhancing title appearance
        ),
        subtitle: Text(
          webtoon.description,
          maxLines: 2, // Limit the subtitle to two lines
          overflow: TextOverflow.ellipsis, // Add ellipsis for overflowing text
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(webtoon: webtoon),
            ),
          );
        },
      ),
    );
  }
}
