import 'package:drift/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';

// private값까지 불러올 수 있음
part 'drift_database.g.dart'; // part 파일 지정

@DriftDatabase( // 사용할 데이터 등록
  tables: [
    Schedules,
  ],
)

class LocalDatabase extends _$LocalDatabase {
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      // 데이터 조회하고 변화 감지
  (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  // 모든 일정을 다 불러오는 게 아닌 특정 날짜에 해당되는 일정만 불러오므로
  // where 함수를 통해서 관련 일정을 먼저 필터링한다.
  // select() 함수에 watch() 함수가 직접 실행되어야 하므로 괄호가 한 번 더 감싸진 형태이다.
}


