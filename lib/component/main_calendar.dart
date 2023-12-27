import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// table_calendar 플러그인 불러오기 TableCalendar 위젯을 사용할것임


class MainCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        firstDay: DateTime(1800,1,1), // 첫째 날
        lastDay: DateTime(3000,1,1), // 마지막 날
        focusedDay: DateTime.now(), // 화면에 보여지는 날
    );
  }
}

// firstDay,lastDay,focusedDay 매개변수를 필수로 입력해줘야한다.

