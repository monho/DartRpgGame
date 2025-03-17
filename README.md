# Dart Console RPG Game 
Dart로 만든 **텍스트 기반 콘솔 RPG 게임!**  
강력한 몬스터와 싸우고, **골드를 모아 장비를 뽑아 강해지세요!**  


---

## ** 게임 개요**
플레이어는 다양한 **몬스터들과 전투**를 진행하며,  
획득한 **골드로 가챠(뽑기) 시스템을 이용하여 무기와 방어구를 강화**할 수 있습니다.  

✔ ** 전투 시스템** - 몬스터와 랜덤 전투 진행  
✔ ** 가챠 시스템** - 골드로 랜덤 무기 & 방어구 획득  
✔ ** 몬스터 도전** - 다양한 몬스터와 전투  
✔ ** 결과 저장** - 전투 결과를 자동으로 파일에 저장  

---

## ** 게임 실행 방법**
### *1 프로젝트 클론 또는 다운로드**
```sh
git clone https://github.com/yourusername/DartRPGGame.git
cd DartRPGGame

```

 게임 규칙
1 전투 시스템
플레이어는 몬스터와 랜덤 전투를 진행합니다.
행동 선택:
1 - 공격하기
2 - 방어하기
3 - 아이템 사용하기 (한 번만 사용 가능)
몬스터를 처치하면 골드 10 획득 🏆



2 골드를 이용한 가챠 시스템 🎰
몬스터를 처치하면 골드를 획득하고, 이를 사용해 랜덤 무기 & 방어구를 뽑을 수 있습니다.

 가챠 확률 및 보상

등급	확률	보상
 일반	70%	공격력 +2, 방어력 +1
 희귀	25%	공격력 +5, 방어력 +3
 전설	5%	공격력 +10, 방어력 +5
 뽑기 방법

전투 후 골드를 얻음 (기본 10 골드 필요)
"뽑기를 하시겠습니까? (y/n)" 질문이 출력됨
y 입력 시 뽑기 진행 → 랜덤 장비 획득!



파일 구조
```sh
/DartRPGGame
│── main.dart          # 메인 실행 파일
│── game.dart          # 게임 진행 클래스
│── character.dart     # 캐릭터 클래스 (플레이어)
│── monster.dart       # 몬스터 클래스
│── utils.dart         # 파일 읽기, 데이터 저장
│── characters.txt     # 캐릭터 정보 저장 파일
│── monsters.txt       # 몬스터 정보 저장 파일
│── result.txt         # 게임 결과 저장 파일

```
 캐릭터 및 몬스터 데이터 (TXT 파일)

 characters.txt (플레이어 정보)
 Hero,50,10,5

50 → 체력
10 → 공격력
5 → 방어력

monsters.txt (몬스터 정보)

Batman,30,20
Spiderman,20,30
Superman,30,10

Batman → 몬스터 이름
30 → 체력
20 → 공격력

result.txt (게임 결과 자동 저장)
캐릭터: Hero, 남은 체력: 30, 결과: 승리

추가 기능

몬스터 체력이 0이 되면 자동 삭제
체력이 0인 몬스터가 등장하지 않도록 수정