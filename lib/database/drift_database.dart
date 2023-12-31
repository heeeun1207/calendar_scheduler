import 'package:drift/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';

// private값까지 불러올 수 있음
part 'drift_database.g.dart'; // part 파일 지정

@DriftDatabase( // 사용할 데이터 등록
  tables: [
    Schedules,
  ],
)

class LocalDatabase extends _$LocalDatabase {}
