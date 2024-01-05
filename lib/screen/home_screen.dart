import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';

import 'package:provider/provider.dart'; // 1. Provider 불러오기
import 'package:calendar_scheduler/provider/shedule_provider.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    // 2. 프로바이더 변경이 있을 때마다 build() 함수 재실행
    final provider = context.watch<ScheduleProvider>();

    // 3. 선택된 날짜 가져오기
    final selectedDate = provider.selectedDate;

    // 4. 선택된 날짜에 해당하는 일정들 가져오기
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleBottomSheet(),
            isScrollControlled: true,
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected, // 선택된 날짜 변경시 콜백
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectedDate: selectedDate,
              count: schedules.length, // 해당 날짜의 일정 개수 표시
            ),
            SizedBox(height: 8.0),
            Expanded( // 수정된 Expanded
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index){
                  final schedule = schedules[index];
                  return Dismissible(
                    key: ObjectKey(schedule.id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (DismissDirection direction){
                      provider.deleteSchedule(date: selectedDate, id: schedule.id);
                      // 1
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
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

  // 날짜 선택시 실행할 콜백 함수
  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 실행할 코드 작성
  }
}


