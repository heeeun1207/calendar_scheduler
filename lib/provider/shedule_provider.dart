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
  }


// 1. API 요청 로직을 담은 ScheduleRepository
// 2. 서버에서 불러온 일정을 저장할 변수
// 일정을 날짜별로 정리하기 위해 DateTime 을 키로 입력받고 List<ScheduleModel>를 값으로 입력받음
// 나중에 해당하는 일정을 가져올 때 cache 변수에 해당되는 날짜를 key 값으로 제공해줘서 받아온디.
// 3. 일정 정보를 저장해둘 캐시 변수, 키값에 날짜를 입력하고 날짜에 해당되는 일정을 리스트 값에 저장

// 4. 매개변수에 입력한 날짜의 일정들을 GET 메서드에서 받은 응답값으로 대체한다.
// ifAbsent 매개변수는 date에 해당되는 key 값이 존재하지 않을 때 실행되는 함수이므로,
// 똑같이 GET메서드에서 받아온 응답값을 입력해주면 된다.

// 5. ChangeNotifier를 상속하는 이유이다.
// notifyListeners() 함수를 실행하면 현재 클래스를 watch()하는 모든 위젯들의 build 함수를 다시 실행한다.
// 위젯들은 cache 변수를 바라보도록 할 것이므로 cache 변수가 업데이트될 때마다
// notifyListeners() 함수를 실행해서 위젯을 다시 빌드해준다.
