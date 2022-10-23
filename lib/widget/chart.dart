import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widget/chart_bar.dart';
import '../model/transection.dart';

class Chart extends StatelessWidget {
  final List<Transection> recentTransection;
  const Chart({
    Key? key,
    required this.recentTransection,
  }) : super(key: key);
  /*
    getter methods are executed  dynamically  
   */

  List<Map<String, Object>> get groupTransectionValues {
    /*
      
Generates a list of values.

Creates a list with [length] positions and fills it with values created by calling [generator] for each index in the range 0 .. length - 1 in increasing order.

final growableList =
    List<int>.generate(3, (int index) => index * index, growable: true);
print(growableList); // [0, 1, 4]

final fixedLengthList =
    List<int>.generate(3, (int index) => index * index, growable: false);
print(fixedLengthList); // [0, 1, 4]
The created list is fixed-length if [growable] is set to false.

The [length] must be non-negative.
     */
    return List.generate(7, (index) {
      /*
      Now ,finding out the different days of the week by week day one by one ,after geting a weekday ,we are now calculating the total amount spent on that day By traversing through the list of transection and Checking if that happened on that week day or not if yes then add that transection amount to totalSum of that week 
       */
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (int i = 0; i < recentTransection.length; i++) {
        if (recentTransection[i].date.day == weekDay.day &&
            recentTransection[i].date.month == weekDay.month &&
            recentTransection[i].date.year == weekDay.year) {
          totalSum += recentTransection[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    });
  }

  double get totalSpending {
    return groupTransectionValues.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   height: MediaQuery.of(context).size.height*0.24,
        //   child:
        LayoutBuilder(
      builder: ((context, constraints) {
        return Card(
          elevation: 6,
          margin: const EdgeInsets.all(15),
          color: const Color.fromARGB(255, 249, 249, 249),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...groupTransectionValues.map(
                  (data) {
                    return Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                          lable: data["day"] as String,
                          spendingAmount: data["amount"] as double,
                          spendingPctOfTotal: (totalSpending != 0.0)
                              ? (data["amount"] as double) / totalSpending
                              : 0.0),
                    );
                  },
                ).toList(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
