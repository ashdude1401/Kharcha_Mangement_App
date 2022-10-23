import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import '../widget/chart.dart';
import './widget/trasection_list.dart';
import './widget/newtransection.dart';
import './model/transection.dart';

void main() {
  // //stricting the app orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*
  As we have to make a form of transection ,we will require list of  id,title,amount,and date ,as we have to use this many time we can have a class transection with these elements as its properties ,and as there can be many transections we have defined list of trasection objects which can be created using transection constructor  
   */
  // String inputTitle = "";
  // String inputAmount = " "
  /* 
    Creates a controller for an editable text field.

This constructor treats a null [text] argument as if it were the empty string.
   */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /* 
       to set default colors and fonts of the app
       */
      theme: ThemeData(
          primarySwatch: Colors.purple,
          errorColor: const Color.fromARGB(255, 102, 7, 255),
          fontFamily: "Quicksand",
          textTheme: const TextTheme(
            titleMedium: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
                fontSize: 18),
            // displayMedium:
            //     TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.bold,fontSize:18),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
          /*
        to use this where is color argument use theme.of(context).*shadesAsRequired,
        it is very useful as if you during the process thought of changing the theme of the app you don't have to change everywhere but only at one place 
*/
          //
          //it will set theme as purple and every will take default colur from the purple shade ,you can also use this colors any where as all its shades are provided here
          ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transection> _userTransection = [
    // Transection(
    //   id: "t1",
    //   title: "Lassi",
    //   amount: 11,
    //   date: DateTime.now(),
    // ),
    // Transection(
    //   id: "t2",
    //   title: "Doodh",
    //   amount: 26,
    //   date: DateTime.now(),
    // ),
  ];
  bool showChart = false;
  void _addTransection(String txTitle, double txAmount, DateTime txDate) {
    final nwtrs = Transection(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );
    setState(() {
      _userTransection.add(nwtrs);
    });
  }

  void _startAddNewTransection(BuildContext ctx) {
    /* 
    it shows a form on the bottom of a screen,and its buid context searches for the acestor of the contex ,so as there is no acestor of our myapp class so where ever we have to use this ,we have to call builder() method  */

    showModalBottomSheet(
      context: ctx,
      /* had again shift everything in main dart file again
          as we can not get the trasection list directly
          so change the MyApp into stateful widget
         */
      builder: (_) {
        return NewTransection(txAddTransection: _addTransection);
      },
    );
  }

  List<Transection> get _recentTransections {
    return _userTransection.isEmpty
        ? []
        : _userTransection.where((tx) {
            return tx.date.isAfter(
              DateTime.now().subtract(
                const Duration(days: 7),
              ),
            );
          }).toList();
  }

  void deleteTransecton(String id) {
    setState(() {
      _userTransection.removeWhere((tx) => tx.id == id);
    });
  }
  // bool show(){

  // }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
   
    final appBar = AppBar(
      title: const Text(
        "Kharcha",
        textAlign: TextAlign.center,
      ),
      actions: [
        Builder(
          builder: ((context) {
            return IconButton(
              onPressed: () => _startAddNewTransection(context),
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 254, 254, 254),
              ),
            );
          }),
        )
      ],
      backgroundColor: const Color.fromARGB(255, 114, 19, 222),
    );
     Widget showTxWidget= Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.589,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        // height: constraints.maxHeight * 0.693,
                        //  margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: TransectionList(
                          transectionlist: _userTransection,
                          deleteTransection: deleteTransecton,
                        ),
                      );
      Widget showBarWidget=SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.6,
                        // height: constraints.maxHeight * 0.30,
                        child: Chart(recentTransection: _recentTransections),
                      );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 23, 56),
      appBar: appBar,
      floatingActionButton: Builder(
        builder: ((context) {
          return FloatingActionButton(
              onPressed: () => _startAddNewTransection(context),
              backgroundColor: const Color.fromARGB(255, 114, 19, 222),
              child: const Icon(Icons.add));
        }),
      ),
      floatingActionButtonLocation: Platform.isIOS? null: FloatingActionButtonLocation.centerFloat,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              /*
            Mainaxis refers to main axis where the the widgets will be placed for column it is in vertical direaction
            crossaxis refers to vertical axis to main axis in this case(column) it is horizontal 
             */
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  if(isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Show Chart",
                          style: TextStyle(
                            color: Color.fromARGB(218, 255, 255, 255),
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                          Switch.adaptive(
                              value: showChart,
                              onChanged: (val) {
                                setState(() {
                                  showChart = val;
                                });
                              })

                    ],
                  ),
                  if(!isLandscape)
                    SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.25,
                        // height: constraints.maxHeight * 0.30,
                        child: Chart(recentTransection: _recentTransections),
                      ),
                  if(!isLandscape)
                  showTxWidget,      
               if(isLandscape) showChart
                    ? showBarWidget
                    : showTxWidget
                //NewTransection(),
                /*
                problem is that we have trasection all managed in transection list widget but as we know transection list is variable ,it will change when ever we add new transection in our main.dart file(i.e the changes are triggered in main dart file but we have transection in transection list ) so ,to resolve this we do statelifting,we will create a new widget which will common denominator to both the widgets  
               */
                // const TransectionList(),
                /*
                Now ,to want to display the transection
                1.One and noob approach can be making as many card widget as mant there are objects ,but this not good because as user will input the data we don't know how many objects there are,so to add all trasection list elements as card's text ,first as there will be more than one card up and down to each other so we Should use column,in column we have to show as many cards many there objects with all its details,i.e a list of card widgets,and we have to map trasection list to card list 
                 */
              ],
            ),
          );
        },
      ),
    );
  }
}
// class MyHomePage extends StatefulWidget{
//   const MyHomePage({key? key}) : super(key:key);
//   @override
//   state<MyHomePage> createState()=> _MyHomePageState();
// }
// class _MyHomePageState extends state<MyHomePage>
// {
//   @override
//   Widget build(BuildContext context){

//   }
// }
