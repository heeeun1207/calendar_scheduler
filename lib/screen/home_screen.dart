import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // 시스템 UI 피해서 UI 구현하기 위해서
        child: Column( // 달력과 리스트를 새로로 배치
          children: [
            // 미리 작업해둔 달력 위젯 불러오기
            MainCalendar(),
          ],
        ),
      )
    );
  }
}





