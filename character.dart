import 'dart:math';
import 'monster.dart';


class Character{
  String name;
  int health;
  int attack;
  int defense;
  bool hasUsedItem = false;
  int originalAttack;

  Character(this.name, this.health, this.attack, this.defense) : originalAttack = attack;

  void attackMonster(Monster monster)
  {
    int damage = max(0, attack - monster.defense);
    monster.health -= damage;

    print('$name이(가) ${monster.name} 에게 $damage만큼의 데미지를 입혔습니다.');
  }

 void defend() {
    print('$name이(가) 방어 태세를 취하여 체력을 회복합니다.');
    health += 2;
  }

  void useItem() {
    if (hasUsedItem) {
      print('이미 아이템을 사용했습니다!');
      return;
    }
    hasUsedItem = true;
    attack *= 2;
    print('$name이(가) 특수 아이템을 사용하여 공격력이 두 배가 되었습니다! (현재 공격력: $attack)');
  }
  void restoreAttack() {
    attack = originalAttack; // 아이템 효과 해제
  }

  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}