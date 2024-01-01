import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label; // 택스트 필드 제목
  final bool isTime; // 시간 선택하는 텍스트 필드인지 여부
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,
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
        Expanded(
            flex: isTime ? 0 : 1, // 1
            child:TextFormField( //폼 안에서 텍스트 필드를 쓸 때 사용
              onSaved: onSaved, // 폼 저장했을 때 실행할 함수
              validator: validator, // 폼 검증했을 때 실행할 함수
              cursorColor: Colors.grey, // 커서 색상 변경
              maxLines: isTime? 1 : null,
              // 시간 관련 텍스트 필드가 아니면 한 줄 이상 작성 가능하게
              expands: !isTime, // 시간 관련 텍스트 필드는 공간 최대 차지하도록
              keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
              // 시간 관련 텍스트 필드는 기본 숫자 키보드로 아닐 경우에 일반 글자 키보드 보여주기
              inputFormatters: isTime
                ? [
               FilteringTextInputFormatter.digitsOnly,
              ]
                  : [], // 시간 관련 텍스트 필드는 숫자만 입력하도록 제한
              decoration: InputDecoration(
                border: InputBorder.none, // 테두리 삭제
                filled: true, // 배경색 지정하겠다는 선언
                fillColor: Colors.grey[300], // 배경색
                suffixText: isTime ? '시' : null,
                // 시간 관련 텍스트 필드는 '시' 접미사 추가
              ),
            ),
        ),
      ],
    );
  }
}

// maxLines 매개변수 : 텍스트 필드에 값을 입력할 때 허락되는 최대 줄 개수임. int 값을 입력할 수있으며,
// null 을 넣으면 개수를 제한하지 않는다.

// expands 매개변수 : 기본값 false 이며 true 로 입력하면 부모의 위젯 크기만큼 텍스트 필드를 늘릴 수 있음.

// TextInputType .multiline  : 줄바꿈 키가 존재하는 일반 키보드

// inputFormatters 키보드 종류를 정의하는 keyboardType 비슷하지만 큰 차이가 있다.
// keyboardType 는  오직 핸드폰 키보드만 제한할 수 있다.
// inputFormatters 는 특정 입력 자체를 제한할 수 있다
// 예시 : 블루투스, 보안키보드와 같은 커스텀 구현된 키보드

// suffixText : 접미사를 직접 지정한다. (오른쪽 끝에 원하는 글자가 상시 표시됨)
