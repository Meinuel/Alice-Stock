import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pelu_stock/src/screens/daily.dart';
import 'package:pelu_stock/src/screens/master.dart';
import 'package:pelu_stock/src/screens/reporte.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es' , 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Alice Stock',
      theme: ThemeData(
        dialogTheme: const DialogTheme(titleTextStyle: TextStyle(color: Colors.black),contentTextStyle: TextStyle(color: Colors.black)),
        scaffoldBackgroundColor:Colors.black,
        hintColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white,displayColor: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigationPage(),
    );
  }
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final List<Widget> bottomBarItems = [
    const DailyPage(),
    const MasterPage(title: 'Maestro Insumos'),
    const ReportPage()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomBarItems.elementAt(selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        primaryColor: Colors.greenAccent,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: const TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
         // backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.brightness_6),
              label: 'Diario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined),
              label: 'Maestro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history,shadows: [Shadow(color: Colors.black)]),
              label: 'Reporte',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.green,
          onTap: (index){setState(() {
              selectedIndex = index;
          });},
        ),
      ),
    );
  }
}
