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
        description:
            'One of the best action fantasy manhwa and the most talked about adaptation in recent times is undoubtedly Solo Leveling. It is set in a world where humans have discovered supernatural skills, while our protagonist, Sung Jin-Woo, is a nobody with his E-Rank hunting skills. Things will take an interesting turn for him when he becomes the sole survivor of a dungeon raid. Awakened with strange new powers, Sung Jin-Woo will level up from being the weakest Hunter and eventually become the most powerful entity in the universe.',
      ),
      Webtoon(
        id: 2,
        title: 'Tower of God',
        imageUrl:
            'https://animemangatoon.com/wp-content/uploads/2024/06/Screenshot-2024-10-01-090334-750x375.webp',
        description:
            'A boy embarks on an epic journey to reach the top of the tower.',
      ),
      Webtoon(
        id: 3,
        title: 'Hades',
        imageUrl:
            'https://animemangatoon.com/wp-content/uploads/2024/05/64u47lg4-360x504.png.webp',
        description:
            'In the Lore Olympus webtoon, Hades, the God of the underworld, takes center stage. Often depicted as a handsome blue man in a business suit, Hades runs the Underworld Corporation, serves as the older brother of Zeus and Poseidon, and plays a role in the Six Traitor Dynasty. His character takes on the burden of leadership and pursuing personal interests',
      ),
      Webtoon(
        id: 4,
        title: 'Persephone',
        imageUrl:
            'https://animemangatoon.com/wp-content/uploads/2024/05/myq53tdb-360x504.png.webp',
        description:
            ' Persephone, the goddess of spring, is the story’s heroine alongside the underworld. Initially portrayed as an innocent and naive young woman, her character develops dramatically as she faces more challenges.      In the Lore Olympus webtoon, Hades, the God of the underworld, takes center stage. Often depicted as a handsome blue man in a business suit, Hades runs the Underworld Corporation, serves as the older brother of Zeus and Poseidon, and plays a role in the Six Traitor Dynasty. His character takes on the burden of leadership and pursuing personal interests',
      ),
      Webtoon(
        id: 5,
        title: 'Zeus',
        imageUrl:
            'https://animemangatoon.com/wp-content/uploads/2024/05/ilzxkblr-350x350.png.webp',
        description:
            ' Zeus, the king of the gods, is depicted as a yellow-skinned man with long, straight hair. Known for his promiscuity and egotism, Zeus’ actions often brought chaos to Olympus. A member of the Six Realms of Lies, he has intimate relationships with many characters, including his brothers Hades and Poseidon, and many lovers. His character provides a lens through which to examine issues of power and corruption.',
      ),
      Webtoon(
        id: 6,
        title: 'Poseidon',
        imageUrl:
            'https://animemangatoon.com/wp-content/uploads/2024/05/ccgqrffp-360x504.png.webp',
        description:
            'Poseidon, the God of the sea, is Zeus’s brother from the underworld. He is usually characterized by a carefree and quick temperament, portrayed with green skin and long, wavy hair. Despite being slightly less witted, Poseidon is very loyal to his family. His relationship with his wife Amphitrite and their polygamous arrangement add an intriguing dynamic to his character.',
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
