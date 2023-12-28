import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';

class HomeScreen extends StatefulWidget {
  //1. StatefulWidget 변경
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc( // 2.선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              // 선택된 날짜를 MainCalendar에 전달
              selectedDate: selectedDate,

              // 날짜가 선택됐을 때 실행할 함수
              onDaySelected: onDaySelected,
            ),
            ScheduleCard(
                startTime: 12,
                endTime: 14,
                content: '프로그래밍 공부',
            ),
          ],
        ),
      ),
    );
  }

  // 3.날짜가 선택됐을 때 실행되는 함수
  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 선택된 날짜 업데이트
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
