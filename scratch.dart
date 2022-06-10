import 'dart:io';

void main() {
  performTask();
}

void performTask() async {
  task1();
  String task2Result = await task2();
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('task1 is completed');
}

Future<String> task2() async {
  Duration threeSeconds = const Duration(seconds: 3);
  String result = '';
  await Future.delayed(threeSeconds, () {
    result = 'task 2 data';
    print('task2 is completed');
  });
  return result;
}

void task3(String task2data) {
  //String result = 'task 3 data';
  print('task3 is completed with $task2data');
}
