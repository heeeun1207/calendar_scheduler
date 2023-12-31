import 'package:drift/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';

// private값까지 불러올 수 있음
part 'drft_database.g.dart'; // part 파일 지정

@DriftDatabase( // 사용할 데이터 등록
  tables: [
    Schedules,
  ],
)

class LocalDatabase extends _$LocalDatabase {}
// Code Generation으로 생성할 클래스 상속
// 드리프트 관련 쿼리를 작성할 클래스를 하나 작성하고
// 클래스 이름앞에 '_$'를 추가한 부모 클래스를 상송한다.
// 이 클래스는 현재는 존재하지 않지만 코드 생성을 실행하면 생성된다.



// 어떤 플러터 패키지에서든 코드 생성을 사용하려면 part 파일을 지정해줘야 한다.
// part 파일은 part 키워드를 사용해서 지정한다.
// 대부분 현재 파일 이름에 .g.dart 를 추가하는 형식이다.
// 드리프트 또한 현재 파일명에 .g.dart 를 추가하면 된다.