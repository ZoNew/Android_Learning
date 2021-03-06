import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime(1998, DateTime.september, 1);
  DateTime _lastDay = DateTime(2022, DateTime.december, 31);

  DateTime _selectedDay = DateTime.now();

  final _suggestions = <DateTime>[];


  //TODO : Bind calendar with list view

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildCalendar(),
          // ListView inside Column MUST Wrap
          Expanded(
            child: _buildSuggestions(),
          ),
        ],
      ),
    );
  }

  Container _buildCalendar() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TableCalendar(
        // calendarBuilders: ,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.cyan,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.cyan,
          ),
        ),
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,

        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _suggestions.clear();
            _buildSuggestions();
            print("onDaySelected $_suggestions");

          });
        },
      ),
    );
  }

  ListView _buildSuggestions() {
    return ListView.builder(
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) {
          print("$i Divider()");
          return const Divider();
        }
        /*2*/
        final index = i ~/ 2; /*3*/
        var addList = _selectedDay;
        if (index >= _suggestions.length) {
          addList = addList.add(Duration(days: index));
          _suggestions.add(addList); /*4*/
          print("$i addList $addList");
        }
        if(addList.day == 9 && addList.month > _focusedDay.month){
          Future.delayed(Duration.zero, () async { // setState() during build
            changeMonth(addList);
          });
        }
        DateTime dateIndex = _suggestions[index];
        return _buildRow(dateIndex);
      },
    );
  }

  Widget _buildRow(DateTime date) {
    return Container(
      child: ListTile(
        title: Text(
          DateFormat('yyyy-MM-dd').format(date),
          style: TextStyle(
            fontSize: 18,
            color: Colors.cyan.shade400,
          ),
        ),
        onTap: () {
          print("onTap $date");
          setState(() {
            _focusedDay = date;
            // _selectedDay = date;
          });
        },
      ),
    );
  }

  void changeMonth(DateTime date){
    print("---------ChangMonthStart---------");
    print(date.day);
    try{
      setState(() {
        _focusedDay = date;
      });
    }catch(e){
      print(e);
    }
    print("---------ChangMonthEnd---------");
  }

}
