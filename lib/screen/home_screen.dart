import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  // StatefulWidget 변경
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc( // 선택된 날짜를 관리할 변수
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
            Expanded( // 남는 공간을 모두 차지하기
              // 일정 정보가 Stream으로 제공되기 때문에 StreamBuilder 사용한다
                child: StreamBuilder<List<Schedule>>(
                  stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) { // 데이터가 없을 때
                      return Container();
                    }
                    // 화면에 보이는 값들만 렌더링하는 리스트
                    return ListView.builder(
                      // 리스트에 입력할 값들의 총 개수
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // 현재 index에 해당되는 일정
                        final schedule = snapshot.data![index];
                        return Padding( // 좌우로 패딩을 추가해서 UI 개선
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
                        );
                      },
                    );
                  }
                ),
              // Stream 을 사용하면 데이터를 일회성으로 조회하는게 아니라
              // 지속적으로 변화가 있을 때 새로운 값들을 받아올 수 있다.
            ),
            ],
            ),
        ),
    );
  }

  // 날짜가 선택됐을 때 실행되는 함수
  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 선택된 날짜 업데이트
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
