import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier {
  //ChangeNotifier: material 패키지에서 제공
  final ScheduleRepository repository; // API 요청 로직을 담은 클래스

  DateTime selectedDate = DateTime.utc( // 선택한 날짜
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
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
  }) async {
    final targetDate = schedule.date;

    final uuid = Uuid();

    final tempId = uuid.v4(); // 유일한 ID 값을 생성한다.
    final newSchedule = schedule.copyWith(
      id: tempId, // 임시 ID를 저장한다
    );

    // 긍정적 응답구간이다. 서버에서 응답을 받기 전에 캐시를 먼저 업데이트 해준다
    cache.update(
      targetDate,
          (value) =>
      [
        ...value,
        newSchedule,
      ]
        ..sort(
              (a, b) =>
              a.startTime.compareTo(
                b.startTime,
              ),
        ),
      ifAbsent: () => [newSchedule],
    );

    notifyListeners(); // 캐시 업데이트 반영하기

    try {
      // API 요청하기
      final savedSchedule = await repository.createSchedule(schedule: schedule);

      cache.update( // 서버 응답 기반으로 캐시 업데이트
        targetDate,
            (value) =>
            value
                .map((e) =>
            e.id == tempId
                ? e.copyWith(
              id: savedSchedule,
            )
                : e)
                .toList(),
      );
    } catch (e) {
      cache.update( // 삭제 실패 시 캐시 롤백하기
        targetDate,
            (value) => value.where((e) => e.id != tempId).toList(),
      );
    }

    notifyListeners();
  }
}

  
