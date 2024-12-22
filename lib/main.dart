import 'package:flutter/material.dart';
import 'package:prova/firebase_options.dart';
import 'package:prova/src/Model/FirebaseDB.dart';
import 'package:prova/src/widgets/ListaItem.dart';
import 'package:prova/src/widgets/ListaSpesa.dart';
import 'package:prova/src/Model/ListaSpesaClass.dart';
import 'package:prova/src/widgets/SearchListPanel.dart';
import 'package:prova/src/widgets/Searchbar.dart';
import 'package:prova/src/widgets/SearchbarNew.dart';
import 'package:prova/src/widgets/Searchlist.dart';

import 'package:prova/src/newWidgets/slideUpPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseDB>(create: (_) => FirebaseDB()),
      ],
      child: MyApp(),
    ),);
    
}

class MyApp extends StatelessWidget {

  
  MyApp({Key? key}) : super(key: key);
  final fbApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform

  );
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      /**initialRoute: '',
      routes: {
        '' : ((context) => MainPage()),
        '/second' : ((context) => SecondPage())
      }, */
      
      home: FutureBuilder(
        future: fbApp,
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return const MyHomePage(title: 'Flutter Demo Home Page');
          else
            return Container();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //final array = List<ListaSpesaClass>.generate(10, (index) => new ListaSpesaClass(index.toString(),false,index.toString()));
  //final array = List<String>.generate(10, (index) => index.toString());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FirebaseDB>().getUncheckedItems().then((value) => debugPrint(value.length.toString() +  "\t1"));
      context.read<FirebaseDB>().getCheckedItems().then((value) => debugPrint(value.length.toString() + "\t2"));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ListaSpesaClass> lista;
    debugPrint("Length:" + context.read<FirebaseDB>().uncheckedItems.length.toString());
    final PanelController _panelController = PanelController();
    final double radius = 10;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //r
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.cyanAccent,
      ),


      body: Stack(
        children: [
         
          slideUpProdotti(),
        ]
      )
       
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
