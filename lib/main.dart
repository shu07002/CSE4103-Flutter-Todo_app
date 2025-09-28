import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomad_flutter/screens/home.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)),
      ),
      home: Home(),
    );
  }
}



/*
  StatelessWidget를 상속받으면 반드시 build 메소드를 구현해야함
  build 메소드는 위젯의 UI를 리턴하는 것
  statelessWidget은 가장 기초적인 위젯
  statelessWidget은 걍 build 메소드를 통해서 UI를 출력할 뿐이다.
*/


/*
  statefulWidget은 상태에 따라서 변하는 데이터가 존재할때
  상태에 따른 변화를 UI에 반영하여 실시간으로 보여준다.
  그리고 상태가 변경되었을 때 걍 count + 1과 같이 바꾼다고 UI 가 업데이트 되지 않는다
  상태 변경시 UI가 업데이터 되어야한다면 setState 함수 안에서 상태를 변경하자.
  그래야 플러터가 이를 알아차리고 UI를 업데이트 한다. = build 메소드 재호출
  setState 함수는 method를 재호출해준다.
*/

/*
  context를 통해서 자식은 부모 요소의 정보에 접근할 수 있다.
  context는 자신 이전에 있는 모든 상위 요소들에 대한 정보다.
  즉, 위젯 트리에 대한 정보를 가지고 있다고 할 수 있다.
  context가 해당 위젯의 위치에 대한 정보를 알려주기 때문이다.
*/

/*
  Widget의 라이프 사이클
  statefulWidget은 context말고도 initState 메소드도 가짐
  initState Method: 상태를 초기화하기 위한 메소드
  근데 이게 별로 쓸 일이 없음. 왜냐하면 int counter = 0; 이걸로 충분하기 때문임.
  하지만 종종 부모 요소에 의존하는 데이터를 초기화할 때가 있음.
  그리고 initState는 항상 build보다 먼저 호출되고 딱 한번만 호출됨.
  추가로 initState를 실행하기 전에는 항상 super.initState()를 먼저 호출해야함.

  dispose라는 메소드도 가짐
  이건 위젯이 언마운트될 때 실행되는 메소드
  API 업데이트나 이벤트리스너로부터 구독을 취소할 때 호출함. = 클린업
  위젯이 위젯트리에서 제거되지 전에 하고 싶은 동작을 작성
*/

/*
  build method는 Widget를 리턴함
  root Widget은 material이나 cupertino 둘 중에 하나를 리턴해야함
  각각 구글과 애플의 디자인 시스템
*/

/*
  모바일 어플리케이션의 모든 화면은 scaffold가 필요함
  scaffold는 nav나 botton tab 등등이나 정렬같은 것들을 가능하게 해줌
*/

// 기본 Widget들 인지하고 그 안에 파라미터로 어떤 값들이 들어가지는 확인하자