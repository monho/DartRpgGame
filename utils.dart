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
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }

}

 List<Monster> loadMonsterStats() {
    List<Monster> monsters = [];

    try {
      final file = File('monsters.txt');
      if (!file.existsSync()) throw Exception('몬스터 파일이 없습니다.');

      final lines = file.readAsLinesSync();
      for (var line in lines) {
        final stats = line.split(',');
        if (stats.length != 3) continue;

        String name = stats[0];
        int health = int.parse(stats[1]);
        int attack = int.parse(stats[2]);

        monsters.add(Monster(name, health, attack));
      }
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }

    return monsters;
  }

  void applyHealthBonus(Character player) {
    if (Random().nextInt(100) < 30) { 
      player.health += 10;
      print('보너스 체력을 얻었습니다! 현재 체력: ${player.health}');
    }
  }

  void saveResult(Character player, String result) {
    final file = File('result.txt');
    file.writeAsStringSync('캐릭터: ${player.name}, 남은 체력: ${player.health}, 결과: $result\n', mode: FileMode.append);
    print('게임 결과가 result.txt에 저장되었습니다.');
  }
