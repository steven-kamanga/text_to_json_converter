import 'dart:convert';
import 'dart:io';

void main() async {
  const String text = '''
No. 2
Ino ndi nthawi yomwe aneneri,
Ananena za tsiku lalikulu,
Lomwe Ulemerero wa Mulungu,
Udzawalira pa dziko lonseli.
Ndiye Bahá’u’lláh Wolonjezedayo,
Iye ndi Ulemerero wa Mulungu.
Monga mphenzi ing’anima kum’mawa,
Nionekera mpaka kwa kalonza,
Choncho Ulemerero wa Mulungu,
Udzawalira pa dziko lonseli.
Ndiye Bahá’u’lláh Wolonjezedayo,
Iye ndi Ulemerero wa Mulungu.
3Ndipo mitundu yonse ya padziko,
Ikulandira Uthenga Wakewo,
Nizindikira Ulemererowo,
Ndikufalitsa kwa anthu onsewo.
Ndiye Bahá’u’lláh Wolonjezedayo,
Iye ndi Ulemerero wa Mulungu.
''';

  List<Map<String, String>> songs = [];
  Map<String, String> currentSong = {'lyrics': ''};

  List<String> lines = text.split('\n');

  for (String line in lines) {
    RegExp regExp = RegExp(r'^No\. (\d+)$');
    RegExpMatch? match = regExp.firstMatch(line);
    if (match != null) {
      if (currentSong.isNotEmpty) {
        songs.add(currentSong);
      }
      currentSong = {
        'number': 'No. ${match.group(1) ?? ''}',
        'lyrics': '${(currentSong['lyrics'])!}\n$line',
      };
    } else if (currentSong.isNotEmpty) {
      currentSong['lyrics'] = '${currentSong['lyrics']}\n$line';
    }
  }

  if (currentSong.isNotEmpty) {
    songs.add(currentSong);
  }

  String json = jsonEncode(songs);

  // Write the JSON content to a file named 'file.json'
  File file = File('file.json');
  await file.writeAsString(json);
  print('JSON content saved to file.json');
}
