import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/webtoon.dart';
import '../screens/detail_screen.dart';

class WebtoonTile extends StatelessWidget {
  final Webtoon webtoon;

  const WebtoonTile({required this.webtoon, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 5, 32, 80),
      child: ListTile(
        leading: Image.network(
          webtoon.imageUrl,
          width: 50.w, // Set a fixed size for the image
          height: 50.h,
          fit: BoxFit.cover, // Ensures the image is cropped properly
        ),
        title: Text(
          webtoon.title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14.sp), // Enhancing title appearance
        ),
        subtitle: Text(webtoon.description,
            maxLines: 2,
            // Limit the subtitle to two lines
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp) // Add ellipsis for overflowing text
            ),
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  DetailScreen(webtoon: webtoon),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // Start from the right side
                const end = Offset.zero; // End at the center
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
