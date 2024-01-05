import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:provider/provider.dart';
import 'package:calendar_scheduler/provider/shedule_provider.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const ScheduleBottomSheet({
    required this.selectedDate,
    Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheet();
}

class _ScheduleBottomSheet extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey(); // 폼 key 생성

  String? content;
  int? startTime;
  int? endTime;

  @override
  Widget build(BuildContext context) {
    // 키보드 높이 가져오기
    final bottomInset = MediaQuery
        .of(context)
        .viewInsets
        .bottom;

    return Form(
      key: formKey,
      child: SafeArea(
        child: Container(
          // 화면 반 높이에 키보드 높이 추가하기
          height: MediaQuery
              .of(context)
              .size
              .height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                left: 8, right: 8, top: 8, bottom: bottomInset),
            // 패팅에 키보드 높이 추가해서 위젯을 전반적으로 위로 옮겨주기
            child: Column(
              // 시간 관련 텍스트 필드와 내용 관련 텍스트 필드 세로로 배치
              children: [
                Row(
                  // 시작 시간 종료 시간 가로로 배치
                  children: [
                    Expanded(
                      child: CustomTextField( // 시작 시간 입력 필드
                        label: '시작 시간',
                        isTime: true,

                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextField( // 종료 시간 입력 필드
                        label: '종료  시간',
                        isTime: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: CustomTextField( // 내용 입력 필드
                    label: '내용',
                    isTime: false,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton( // [저장] 버튼
                    onPressed: () => onSavePressed(context), // 함수에 context 전달
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    child: Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed(BuildContext context) async {
    // formKey 사용하여 유효성 검사를 위한 validate()와 save() 호출
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      context.read<ScheduleProvider>().createSchedule(
        schedule: ScheduleModel(
          id: 'new_model', // 임시 ID
          content: content!,
          date: widget.selectedDate,
          startTime: startTime!,
          endTime: endTime!,
        ),
      );

      Navigator.of(context).pop();
    }
  }
}





