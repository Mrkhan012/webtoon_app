import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/webtoon.dart';

class WebtoonProvider with ChangeNotifier {
  List<Webtoon> _webtoons = [];
  final _storage = const FlutterSecureStorage();

  List<Webtoon> get webtoons => _webtoons;

  // Fetch webtoons (hardcoded as an example)
  void fetchWebtoons() {
    _webtoons = [
      Webtoon(
        id: 1,
        title: 'Lore Olympus',
        imageUrl:
            'https://animemangatoon.com/wp-content/uploads/2024/06/Screenshot-2024-10-01-090334-750x375.webp',
        description: 'One of the best action fantasy manhwa and the most talked about adaptation in recent times is undoubtedly Solo Leveling. It is set in a world where humans have discovered supernatural skills, while our protagonist, Sung Jin-Woo, is a nobody with his E-Rank hunting skills. Things will take an interesting turn for him when he becomes the sole survivor of a dungeon raid. Awakened with strange new powers, Sung Jin-Woo will level up from being the weakest Hunter and eventually become the most powerful entity in the universe.',
      ),
      Webtoon(
        id: 2,
        title: 'Tower of God',
        imageUrl:
            'https://animemangatoon.com/wp-content/uploads/2024/06/Screenshot-2024-10-01-090334-750x375.webp',
        description:
            'A boy embarks on an epic journey to reach the top of the tower.',
      ),
      // Add more webtoons...
    ];
    notifyListeners();
  }

  // Save favorite
  Future<void> addToFavorites(Webtoon webtoon) async {
    await _storage.write(key: webtoon.id.toString(), value: webtoon.title);
    notifyListeners();
  }

  // Fetch favorites
  Future<List<String>> getFavorites() async {
    return _storage.readAll().then((allItems) => allItems.values.toList());
  }
}
