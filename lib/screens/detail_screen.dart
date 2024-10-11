import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/webtoon.dart';
import '../providers/webtoon_provider.dart';

class DetailScreen extends StatefulWidget {
  final Webtoon webtoon;

  const DetailScreen({super.key, required this.webtoon});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Track the current rating
  double currentRating = 0;

  @override
  void initState() {
    super.initState();
    currentRating =
        widget.webtoon.rating; // Initialize with the webtoon’s current rating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 5, 32, 80),
        title: Text(widget.webtoon.title,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16.sp,
                color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share the webtoon title
              Share.share(widget.webtoon.title);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.network(widget.webtoon.imageUrl, height: 300.h)),
              const SizedBox(height: 10),
              Text(
                widget.webtoon.description,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<WebtoonProvider>(context, listen: false)
                      .addToFavorites(widget.webtoon);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('${widget.webtoon.title} added to favorites')),
                  );
                },
                child: const Text('Add to Favorites'),
              ),
              const SizedBox(height: 20),
              _buildRatingSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rate this Webtoon:', style: TextStyle(fontSize: 16)),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < currentRating ? Icons.star : Icons.star_border,
                color: Colors.yellow,
                size: 30,
              ),
              onPressed: () {
                _updateRating(context, index + 1); // Pass the rating as 1-based
              },
            );
          }),
        ),
        const SizedBox(height: 10),
        Text('Average Rating: ${currentRating.toStringAsFixed(1)}'),
      ],
    );
  }

  void _updateRating(BuildContext context, int newRating) {
    setState(() {
      currentRating = newRating.toDouble(); // Update the local state
      widget.webtoon.rating = currentRating; // Update the webtoon rating
    });

    Provider.of<WebtoonProvider>(context, listen: false).notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('You rated ${widget.webtoon.title} $newRating stars')),
    );
  }
}
