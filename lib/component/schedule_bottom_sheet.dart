import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheet();
}

class _ScheduleBottomSheet extends State<ScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.white,
          child: CustomTextField(
            // 시작 시간 텍스트 필드 렌더링
            label: '시작 시간',
          ),
        ),
    );
  }
}


