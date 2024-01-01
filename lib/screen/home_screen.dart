import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';


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
      floatingActionButton: FloatingActionButton( // 새 일정 버튼
        backgroundColor: PRIMARY_COLOR,
        onPressed: (){
          showModalBottomSheet( // BottomSheet 열기
              context: context,
              isDismissible: true, // 배경을 탭했을 때  BottomSheet 닫기
              builder: (_) => ScheduleBottomSheet(
                selectedDate: selectedDate, // 선택된  날짜 (selectedDate) 넘겨주기
              ),
            // BottomSheet 높이를 화면 최대 높이로
            // 정의하고 스크롤 가능하게 변경해준다.
            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              // 선택된 날짜를 MainCalendar에 전달
              selectedDate: selectedDate,

              // 날짜가 선택됐을 때 실행할 함수
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner( // 배너 추가하기
                selectedDate: selectedDate,
                count: 0 // 임시
            ),
            SizedBox(height: 8.0),
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
