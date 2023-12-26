# calendar_scheduler

### 기능 :

- 일정 추가 버튼을 눌러서 새로운 일정 폼을 열기
- 새로운 일정 폼에 일정 정보를 입력해서 새로운 일정을 생성하기
- 달력의 날짜를 눌러서 특정 날짜의 일정 조회하기
- 선택한 날짜에 몇 개 일정이 있는지 확인하기
- 일정을  SQLite 데이터베이스에 저장하거나 서버에 저장하기

### 핵심 구성요소

- REST API
- Dio
- SQLite
- Drift
- Code Generation
- Table Calendar
- TextFormField

### 플러그인

dependencies

- table_calendar
- intl: 0.17.0
- drift: 2.1.0
- splite3_flutter_libs:0.510
- path_provider:2.0.11
- path: 1.8.2
- get_it : 7.2.0
- dio : 4.0.6
- provider : 6.0.3
- uuid: 3.0.6

dev_dependencies

- drift_dev : 2.1.0
- build_runner: 2.0.0

# 목표

달력 형태 위젯인 TableCalendar을 사용해서 일정 관리 앱 UI 작업을 진행한다.

## 사전 지식

- table_calendar 플러그인

## 사전 준비

- pubspec.yaml 설정
- 프로젝트 초기화

## 레이아웃 구성하기

## 구현하기

- 주색상 설정
- 달력 구현
- 일정 보여주기
- 오늘 날짜 보여주기
- 일정 내용 필드 구현
- 달력 언어 설정

## 테스트하기

---

## 구현 목표

- 한국어 달력
- 선택한 날짜에 일정 목록
- 일정 추가 버튼

---

## 프로젝트 구상

크게 위젯 두 개로 구분한다.

1. 일정 데이터를 조회하고 조회한 날짜를 선택하는 홈 스크린과 /일정을 추가하는 일정 추가화면이다.
2. 먼저 홈 스트린에서 달력 형태의 위젯을 구현하고 바로 아래에 일정을 리스트로 보여준다.
3. 다음으로 일정 추가 버튼 플로팅 액션 버튼 Floating Action Button 으로 구현한 다음 눌렀을 때 일정 추가 화면이 보이게 한다.
4. 마지막으로 일정 정보를 입력하는 텍스트 필드와 저장 버튼을 구현하자.