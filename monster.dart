import 'dart:math';
import 'character.dart';

class Monster {
  String name;
  int health;
  int attack;
  int defense = 0;
  int turnCounter = 0; 

  Monster(this.name, this.health, this.attack);

  void attackCharacter(Character character) {
    int damage = max(0, attack - character.defense);
    character.health -= damage;
    print('$name이(가) ${character.name}에게 $damage의 데미지를 입혔습니다.');
  }

  void increaseDefense() {
    if (++turnCounter % 3 == 0) {
      defense += 2;
      print('$name의 방어력이 증가했습니다! 현재 방어력: $defense');
    }
  }

  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}
