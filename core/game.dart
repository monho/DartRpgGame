import 'dart:io';
import 'dart:math';
import '../character/character.dart';
import '../monster/monster.dart';
import '../utils/utils.dart';

final List<Monster> bossMonsters = [
  Monster("Ultron", 70, 40, isBoss: true),
  Monster("Magneto", 50, 35, isBoss: true),
  Monster("SilverSurfer", 80, 50, isBoss: true),
  Monster("DarkPhoenix", 90, 60, isBoss: true),
  Monster("Galactus", 150, 80, isBoss: true)
];

class Game {
  Character? player;
  List<Monster> monsters = [];
  int defeatedMonsters = 0;
  Random random = Random();

  Game() {
    player = loadCharacterStats();
    monsters = loadMonsterStats();
    applyHealthBonus(player!);
  }

  // ------------------------------ //
  //          게임 시작            //
  // ------------------------------ //
  void startGame() {
    if (player == null) {
      print('⚠️ 캐릭터 데이터를 불러오지 못했습니다.');
      return;
    }

    printStyled("\n🌟 게임을 시작합니다! 🌟", "green");
    player!.showStatus();

    while (player!.health > 0 && defeatedMonsters < monsters.length) {
      Monster monster = getRandomMonster();
      printStyled("\n💀 새로운 몬스터가 나타났습니다! 💀", "red");
      monster.showStatus();

      battle(monster);

      if (player!.health <= 0) {
        printStyled("\n💀 게임 오버! 패배하였습니다. 💀", "red");
        saveResult(player!, '패배');
        return;
      }

      printStyled("\n🎮 다음 몬스터와 싸우시겠습니까? (y/n)", "cyan");
      String? input = stdin.readLineSync();
      if (input == null || input.toLowerCase() != 'y') {
        printStyled("🎮 게임을 종료합니다.", "yellow");
        saveResult(player!, '중도 종료');
        return;
      }
    }

    printStyled("\n🏆 축하합니다! 모든 몬스터를 물리쳤습니다! 🏆", "green");
    saveResult(player!, '승리');
  }

  // ------------------------------ //
  //        배틀 시스템            //
  // ------------------------------ //
  void battle(Monster monster) {
    while (player!.health > 0 && monster.health > 0) {
      printStyled("\n⚔️ ${player!.name}의 턴 ⚔️", "blue");
      printStyled("👉 행동을 선택하세요 (1: 공격, 2: 방어, 3: 아이템 사용)", "white");

      String? action = stdin.readLineSync();

      if (action == '1') {
        player!.attackMonster(monster);
      } else if (action == '2') {
        player!.defend();
      } else if (action == '3') {
        player!.useItem();
      } else {
        printStyled("❌ 잘못된 입력입니다. 다시 입력하세요.", "red");
        continue;
      }

      // 몬스터 처치 확인
      if (monster.health <= 0) {
        printStyled("\n✅ ${monster.name}을(를) 물리쳤습니다! ✅", "green");

        defeatedMonsters++;
        monsters.remove(monster);
        player!.gainExperience(5);
        player!.restoreAttack();

        int goldReward = monster.isBoss ? 60 : 10;
        player!.earnGold(goldReward);

        if (monster.isBoss) {
          printStyled("💰 보스를 처치하여 추가 골드 50을 지급받았습니다! (총 $goldReward 골드 획득)", "yellow");
        } else {
          printStyled("💰 골드를 $goldReward 획득했습니다!", "yellow");
        }

        // 가챠 선택
        printStyled("\n🎲 뽑기를 하시겠습니까? (y/n)", "cyan");
        String? input = stdin.readLineSync();
        if (input == 'y') {
          player!.gachaDraw();
        }

        // 무기 강화 선택
        printStyled("\n🛠️ 무기를 강화하시겠습니까? (y/n)", "cyan");
        input = stdin.readLineSync();
        if (input == 'y') {
          player!.upgradeWeapon();
        }

        return;
      }

      // 몬스터 턴
      printStyled("\n🔥 ${monster.name}의 턴 🔥", "red");
      monster.attackCharacter(player!);
      monster.increaseDefense();

      player!.showStatus();
      monster.showStatus();
    }
  }

  // ------------------------------ //
  //      랜덤 몬스터 선택         //
  // ------------------------------ //
  Monster getRandomMonster() {
    bool isBossSpawn = random.nextInt(100) < 20; // 20% 확률로 보스 몹 등장

    if (isBossSpawn) {
      Monster boss = bossMonsters[random.nextInt(bossMonsters.length)];
      printStyled("👿 보스 몬스터 ${boss.name}이(가) 등장했습니다! 👿", "purple");
      return boss;
    }

    List<Monster> aliveMonsters = monsters.where((m) => m.health > 0).toList();
    if (aliveMonsters.isEmpty) {
      printStyled("🎉 모든 몬스터를 처치했습니다! 게임을 종료합니다. 🎉", "green");
      exit(0);
    }

    return aliveMonsters[random.nextInt(aliveMonsters.length)];
  }

  // ------------------------------ //
  //      터미널 색상 적용 함수      //
  // ------------------------------ //
  void printStyled(String text, String color) {
    Map<String, String> colors = {
      "red": "\x1B[31m",
      "green": "\x1B[32m",
      "yellow": "\x1B[33m",
      "blue": "\x1B[34m",
      "purple": "\x1B[35m",
      "cyan": "\x1B[36m",
      "white": "\x1B[37m",
      "reset": "\x1B[0m",
    };
    print("${colors[color]}$text${colors['reset']}");
  }
}
