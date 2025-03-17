import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';



Character loadCharacterStats() {
  try{
    final file = File('characters.txt');
      if (!file.existsSync()) throw Exception('캐릭터 파일이 없습니다.');

      final stats = file.readAsStringSync().split(',');
      if (stats.length != 3) throw FormatException('잘못된 캐릭터 데이터');

      print('\n캐릭터의 이름을 입력하세요:');
      String? name = stdin.readLineSync();
      if (name == null || name.isEmpty || !RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(name)) {
        print('잘못된 이름입니다. 영문 또는 한글만 입력 가능합니다.');
        exit(1);
      }

      return Character(name, int.parse(stats[0]), int.parse(stats[1]), int.parse(stats[2]));
  }
  catch(e)
  {

  }

}