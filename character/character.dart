import 'dart:math';
import '../monster/monster.dart';
import 'dart:io';

class Character {
  // 기본 속성
  String name;
  int health;
  int attack;
  int defense;
  int originalAttack;
  bool hasUsedItem = false;

  // 레벨 및 경험치 시스템
  int level = 1;
  int experience = 0;

  // 골드 및 무기 강화 관련 변수
  int gold = 0;
  int weaponLevel = 0;

  Character(this.name, this.health, this.attack, this.defense) 
      : originalAttack = attack;

  // ------------------------------ //
  //           무기 강화           //
  // ------------------------------ //
  void upgradeWeapon() {
    if (weaponLevel >= 5) {
      print('이미 최고 강화 단계입니다.');
      return;
    }

    Map<int, int> upgradeCost = {1: 10, 2: 15, 3: 20, 4: 30, 5: 50};
    Map<int, int> attackBonus = {1: 2, 2: 3, 3: 4, 4: 6, 5: 10};
    Map<int, int> successRate = {1: 90, 2: 80, 3: 70, 4: 50, 5: 30};

    int cost = upgradeCost[weaponLevel + 1]!;
    int bonus = attackBonus[weaponLevel + 1]!;
    int chance = successRate[weaponLevel + 1]!;

    if (gold < cost) {
      print('보유하신 골드가 부족합니다. (필요 골드: $cost, 보유 골드: $gold)');
      return;
    }
    gold -= cost;

    print('\n무기 강화를 시도합니다... (강화 단계: +${weaponLevel + 1}, 성공 확률: $chance%)');
    int roll = Random().nextInt(100);

    if (roll < chance) {
      weaponLevel++;
      attack += bonus;
      print('무기 강화 성공! 현재 무기 강화 단계: +$weaponLevel');
      print('공격력이 증가했습니다! (현재 공격력: $attack)');
    } else {
      print('무기 강화 실패!');
      if (weaponLevel >= 4) {
        print('무기가 초기화되었습니다!');
        weaponLevel = 0;
        attack -= attackBonus.values.reduce((a, b) => a + b);
      } else {
        weaponLevel--;
        print('무기 단계가 한 단계 하락했습니다. (현재: +$weaponLevel)');
      }
    }
  }

  // ------------------------------ //
  //          골드 획득 기능        //
  // ------------------------------ //
  void earnGold(int amount) {
    gold += amount;
    print('골드를 $amount 획득하였습니다! (현재 골드: $gold)');
  }

  // ------------------------------ //
  //         가챠(뽑기) 시스템       //
  // ------------------------------ //
  void gachaDraw() {
    if (gold < 10) {
      print('현재 소유한 골드가 부족합니다. (필요 골드: 10, 보유 골드: $gold)');
      return;
    }
    gold -= 10; // 뽑기 비용 차감
    print('\n가챠를 돌립니다...');

    int chance = Random().nextInt(100);

    if (chance < 70) {
      attack += 2;
      defense += 1;
      print('[일반] 무기 획득! (공격력 +2, 방어력 +1)');
    } else if (chance < 95) {
      attack += 5;
      defense += 3;
      print('[희귀] 전설의 검 획득! (공격력 +5, 방어력 +3)');
    } else {
      attack += 10;
      defense += 5;
      print('[전설] 신의 무기 획득! (공격력 +10, 방어력 +5)');
    }

    print('현재 능력치 - 공격력: $attack, 방어력: $defense');
  }

  // ------------------------------ //
  //        경험치 & 레벨업 기능     //
  // ------------------------------ //
  void gainExperience(int exp) {
    experience += exp;
    print('경험치를 $exp 만큼 획득했습니다! (현재 경험치: $experience)');

    if (experience >= level * 10) {
      levelUp();
    }
  }

  void levelUp() {
    level++;
    experience = 0;
    health += 10;
    attack += 2;
    defense += 1;

    print('\n레벨업!! (현재 레벨: $level)');
    print('레벨업 혜택을 선택해주세요! (1: 공격력 증가, 2: 방어력 증가)');

    String? choice = stdin.readLineSync();
    if (choice == '1') {
      attack += 2;
      print('공격력이 증가했습니다! (현재 공격력: $attack)');
    } else {
      defense += 2;
      print('방어력이 증가했습니다! (현재 방어력: $defense)');
    }
  }

  // ------------------------------ //
  //          전투 관련 기능        //
  // ------------------------------ //
  void attackMonster(Monster monster) {
    int damage = max(0, attack - monster.defense);
    monster.health -= damage;
    print('$name이(가) ${monster.name}에게 $damage만큼의 데미지를 입혔습니다.');
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
    attack = originalAttack;
  }

  // ------------------------------ //
  //         캐릭터 상태 출력       //
  // ------------------------------ //
  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}
