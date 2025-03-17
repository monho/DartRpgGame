import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';
import 'utils.dart';

class Game {
  Character? player;
  List<Monster> monsters = [];
  int defeatedMonsters = 0;

  Game() {
    player = loadCharacterStats();
    monsters = loadMonsterStats();
    applyHealthBonus(player!);
  }

  void startGame() {
    if (player == null) {
      print('캐릭터 데이터를 불러오지 못했습니다.');
      return;
    }

    print('\n게임을 시작합니다!');
    player!.showStatus();

    while (player!.health > 0 && defeatedMonsters < monsters.length) {
      Monster monster = getRandomMonster();
      print('\n새로운 몬스터가 나타났습니다!');
      monster.showStatus();

      battle(monster);

      if (player!.health <= 0) {
        print('\n게임 오버! 패배하였습니다.');
        saveResult(player!, '패배');
        return;
      }

      print('\n다음 몬스터와 싸우시겠습니까? (y/n)');
      String? input = stdin.readLineSync();
      if (input == null || input.toLowerCase() != 'y') {
        print('게임을 종료합니다.');
        saveResult(player!, '중도 종료');
        return;
      }
    }

    print('\n축하합니다! 모든 몬스터를 물리쳤습니다!');
    saveResult(player!, '승리');
  }

  void battle(Monster monster) {
    int turn = 0;

    while (player!.health > 0 && monster.health > 0) {
      turn++;
      print('\n${player!.name}의 턴');
      print('행동을 선택하세요 (1: 공격, 2: 방어, 3: 아이템 사용):');
      String? action = stdin.readLineSync();

      if (action == '1') {
        player!.attackMonster(monster);
      } else if (action == '2') {
        player!.defend();
      } else if (action == '3') {
        player!.useItem();
      } else {
        print('잘못된 입력입니다. 다시 입력하세요.');
        continue;
      }

      if (monster.health <= 0) {
        print('${monster.name}을(를) 물리쳤습니다!');
        defeatedMonsters++;
        player!.gainExperience(5); // 경험치 처치 보상 경험치 추가
        player!.restoreAttack(); // 아이템 효과 초기화
        player!.earnGold(10);
        
        print('\n뽑기를 하시겠습니까? (y/n)');
          String? input = stdin.readLineSync();
          if (input == 'y') {
            player!.gachaDraw();
          }

      }

      print('\n${monster.name}의 턴');
      monster.attackCharacter(player!);
      monster.increaseDefense(); 

      player!.showStatus();
      monster.showStatus();
    }
  }

Monster getRandomMonster() {
  List<Monster> aliveMonsters = monsters.where((m) => m.health > 0).toList();

  if (aliveMonsters.isEmpty) {
    print("모든 몬스터를 처치했습니다! 게임을 종료합니다.");
    exit(0);
  }

  return aliveMonsters[Random().nextInt(aliveMonsters.length)];
}
}
