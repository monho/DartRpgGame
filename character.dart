import 'dart:math';
import 'monster.dart';
import 'dart:io';

class Character{
  String name;
  int health;
  int attack;
  int defense;
  bool hasUsedItem = false;
  int originalAttack;
  int level = 1;
  int experience  = 0;
  int gold = 0;


  Character(this.name, this.health, this.attack, this.defense) : originalAttack = attack;


  void earnGold(int amount)
  {
    gold += amount;
    print('골드를 $amount 획득하였습니다! (현재골드 : $gold)');
  }

  //추가 기능 뽑기 가챠시스템
  void gachaDraw()
  {
    if(gold < 10){
      print('(현재 소유하신 골드가 부족합니다. (필요골드 : 10골드) , 보유골드 : $gold)');
      return;
    }
     gold -= 10; // ✅ 뽑기 비용 차감
    print('\n가챠를 돌립니다...');

    int chance = Random().nextInt(100); // 0~99 랜덤값

    if (chance < 70) {
      // 일반 장비 (70%)
      attack += 2;
      defense += 1;
      print('[일반] 무기 획득! (공격력 +2, 방어력 +1)');
    } else if (chance < 95) {
      // 희귀 장비 (25%)
      attack += 5;
      defense += 3;
      print('[희귀] 전설의 검 획득! (공격력 +5, 방어력 +3)');
    } else {
      // 전설 장비 (5%)
      attack += 10;
      defense += 5;
      print('[전설] 신의 무기 획득! (공격력 +10, 방어력 +5)');
    }

    print('현재 능력치 - 공격력: $attack, 방어력: $defense');
    
  }


  void gainExperience(int exp)
  {
    experience += exp;
    print('경험치를 $exp 만큼 획득했습니다! (현재 경험치 : $experience)');

    if(experience >= level * 10)
    {
      levelUp();
    }

  }

  void levelUp()
  {
    level++;
    experience = 0;
    health += 10;
    attack += 2;
    defense += 1;

    print('\n 레벨업!! (현재레벨 : $level)');

    //레벨업 보상 기능 추가
    print('레벨업 혜택을 선택해주세요! (1: 공격력 증가, 2: 방어력 증가)' );
    String? choice = stdin.readLineSync();

    if(choice == '1')
    {
      attack += 2;
      print('공격력이 증가했습니다! (현재 공격력 : $attack)');
    }
    else
    {
      defense += 2;
      print('방어력이 증가했습니다! (현재 공격력 : $defense)');      
    }

  }



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