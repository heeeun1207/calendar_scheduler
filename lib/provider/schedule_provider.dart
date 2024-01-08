import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleProvider extends ChangeNotifier { //ChangeNotifier: material 패키지에서 제공
  final ScheduleRepository repository; // API 요청 로직을 담은 클래스

DateTime selectedDate = DateTime.utc( // 선택한 날짜
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);
Map<DateTime, List<ScheduleModel>> cache = {}; // 일정 정보를 저장해둘 변수

ScheduleProvider({
    required this.repository,
}) : super() {
  getSchedules(date: selectedDate);
}

void getSchedules({
    required DateTime date,
}) async {
  final resp = await repository.getSchedules(date: date); // GET 메서드 보내기

  // 선택한 날짜의 일정들 업데이트하기
  cache.update(date, (value) => resp, ifAbsent: () => resp);

  notifyListeners(); // 리슨하는 위젯들 업데이트하기
  }
  
  void createSchedule({
    required ScheduleModel schedule,
})async {
  final targetDate = schedule.date;
  
  final savedSchedule = await repository.createSchedule(schedule: schedule);
  
  cache.update(
      targetDate,
          (value) => [ // 현존하는 캐시 리스트 끝에 새로운 일정 추가
            ...value,
            schedule.copyWith(
              id: savedSchedule,
            ),
          ]..sort(
              (a,b) => a.startTime.compareTo(
                b.startTime,  // 시작 시간을 비교해서 오름차순 정렬
              ),
          ),
    // 날짜에 해당하는 값이 없다면 새로운 리스트에 새로운 일정 하나만 추가
    ifAbsent: () => [schedule],
  );

  notifyListeners();
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
}) async {
  final resp = await repository.deleteSchedule(id: id);

  cache.update( // 캐시에서 데이터 삭제
      date,
          (value) => value.where((e) => e.id != id).toList(),
  ifAbsent: () => [],
  );

  notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date,
}) {
  //단순히 매개변수로 입력받은 날짜 변수로 selectedDate 변수를 대체하는 코드를 작성하면 끝
  selectedDate = date; // 현재 선택된 날짜를 매개변수로 입력받은 날짜로 변경
    notifyListeners();
  }
}


