import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';

// Provider 불러오기
import 'package:provider/provider.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    // 프로바이더 변경이 있을 때마다 build() 함수 재실행
    final provider = context.watch<ScheduleProvider>();

    // 선택된 날짜 가져오기
    final selectedDate = provider.selectedDate;

    // 선택된 날짜에 해당되는 일정 가져오기
    final schedules = provider.cache[selectedDate] ?? [];

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
            TodayBanner(
                selectedDate: selectedDate,
                count: schedules.length,
            ),
            SizedBox(height: 8.0),

            Expanded(
                child: ListView.builder(
                  itemCount: schedules.length,
                  itemBuilder: (count, index) {
                    final schedule = schedules[index];

                    return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (DismissDirection direction) {
                          provider.deleteSchedule(date: selectedDate, id: schedule.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, right: 8.0),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
                        ),
                    );
                  },
                ),
            ),
            ],
            ),
        ),
    );
  }

  // 날짜가 선택됐을 때 실행되는 함수
  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
  // StatelessWidget 바꾼 후 setState 로직 모두 삭제
  }
}
