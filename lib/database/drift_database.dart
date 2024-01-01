import 'package:drift/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

// private값까지 불러올 수 있음
part 'drift_database.g.dart'; // part 파일 지정

@DriftDatabase( // 사용할 데이터 등록
  tables: [
    Schedules,
  ],
)

class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      // 데이터 조회하고 변화 감지
  (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  // 모든 일정을 다 불러오는 게 아닌 특정 날짜에 해당되는 일정만 불러오므로
  // where 함수를 통해서 관련 일정을 먼저 필터링한다.
  // select() 함수에 watch() 함수가 직접 실행되어야 하므로 괄호가 한 번 더 감싸진 형태이다.

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
  // 드리프트 데베 클래스는 필수로 schemaVersion 값을 지정해줘야한다.
  // 기본적으로 1부터 시작하고 테이블 변화가 있을 때마다 테이블 구조가 변경된다는걸 드리프트에 인지시켜주는 기능
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {

    // 데이터베이스에 파일 저장할 폴더
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path,'db.sqlite'));
    return NativeDatabase(file);
  });
}


