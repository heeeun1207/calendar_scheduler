import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_scheduler/provider/shedule_provider.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';
import 'package:provider/provider.dart';

void main() async{
  // 플러터 프레임워크가 준비될 때까지 대기
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting(); // intl 패키지 초기화 (다국어화)

  final repository = ScheduleRepository();
  final scheduleProvider = ScheduleProvider(repository: repository);

  runApp(
    ChangeNotifierProvider( // 1. Provider 하위 위젯에 제공하기
      create: (_) => scheduleProvider,
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}

// 1. ChangeNotifierProvider는 create와 child 매개변수를 제공해야 한다.
// child 쓰던 것처럼 자식 위젯을 제공하면 되고,
// create 매개변수는 서브 위젯들에 제공하고 싶은 프로바이더
// 즉 = scheduleProvider를 반환하는 함수를 입력하면 된다.

