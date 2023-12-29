import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({
    required this.label,
    Key? key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( // 세로로 텍스트와 텍스트 필드를 배치하기
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(), // 폼 안에서 텍스트 필드를 쓸 때 사용
      ],
    );
  }
}

// 플러터에서 TextField 위젯과 TextFormField 로 나눌 수 있다.
// TextField 위젯은 각 텍스트 필드가 독립된 형태일 때 주로 사용한다.
// TextFormField 는 여러개의 텍스트 필드를 하나의 폼으로 제어할 때 사용한다.
// 저장 버튼 눌렀을 때 필드 2개와 텍스트 필드 하나를 제어할 계획이므로, TextFormField 를 사용한다.
