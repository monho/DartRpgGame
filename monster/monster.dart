import 'dart:math';
import '../character/character.dart';

class Monster {
  String name;
  int health;
  int attack;
  int defense = 0;
  int turnCounter = 0;
  bool isBoss;

  Monster(this.name, this.health, this.attack, {this.isBoss = false});

  // ------------------------------ //
  //        몬스터 공격 기능        //
  // ------------------------------ //
  void attackCharacter(Character character) {
    int damage = max(0, attack - character.defense);
    character.health -= damage;
    print('$name이(가) ${character.name}에게 $damage의 데미지를 입혔습니다.');
  }

  // ------------------------------ //
  //       몬스터 방어력 증가       //
  // ------------------------------ //
  void increaseDefense() {
    if (++turnCounter % 3 == 0) {
      defense += 2;
      print('$name의 방어력이 증가했습니다! 현재 방어력: $defense');
    }
  }

  // ------------------------------ //
  //       몬스터 상태 출력        //
  // ------------------------------ //
  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense ${isBoss ? "(보스)" : ""}');
  }
}
