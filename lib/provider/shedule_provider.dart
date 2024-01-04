import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository; // 1.API 요청 로직을 담은 클래스

  DateTime selectedDate = DateTime.utc( // 2.선택한 날짜
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  Map<DateTime, List<ScheduleModel>> cache = {}; // 3.일정 정보를 저장해둘 변수

  ScheduleProvider({
    required this.repository,
}) : super() {
    getSchedules(date: selectedDate);
  }
    void getSchedules({
      required DateTime date,
    }) async {
      final resp = await repository.getSchedules(date: date); // GET 메서드 보내기

      // 4.선택한 날짜의 일정들 업데이트하기
      cache.update(date, (value) => resp, ifAbsent: () => resp);

      notifyListeners(); // 5.리슨하는 위젯들을 업데이트하기
    }

    void createSchedule({
    required ScheduleModel schedule,
    }) async {
    final targetDate = schedule.date;

    final savedSchedule = await repository.createSchedule(schedule: schedule);

    cache.update(
        targetDate,
            (value) => [ // 6. 현존하는 캐시 리스트 끝에 새로운 일정 추가
              ...value,
              schedule.copyWith(
                id: savedSchedule,
              ),
            ]..sort(
                (a,b) => a.startTime.compareTo(
                  b.startTime,
                ),
            ),
      // 7. 날짜에 해당되는 값이 없다면 새로운 리스트에 새로운 일정 하나만 추가
      ifAbsent: () => [schedule],
    );

    notifyListeners();
    }
  }

  // 6.새로운 일정을 생성하는 날짜에 해당되는 value에 새로운 일정을 추가
  // 그리고 모든 일정을 시작시간 기준으로 오름차순 정렬한다.
