import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingAmount;
  final double spendingPctOfTotal;
  const ChartBar(
      {Key? key,
      required this.lable,
      required this.spendingAmount,
      required this.spendingPctOfTotal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight*0.15,
              child: FittedBox(
                child: Text("₹ ${spendingAmount.toStringAsFixed(0)}"),
              ),
            ),
             SizedBox(
              height: constraints.maxHeight*0.05,
            ),
            SizedBox(
              height: constraints.maxHeight*0.6,
              width: constraints.maxWidth*0.20,
              child: Stack(
                children: [
                  Container(
                    height: constraints.maxHeight*0.6,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromARGB(220, 243, 235, 246),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 86, 1, 222),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
             SizedBox(
              height: constraints.maxHeight*0.05,
            ),
            SizedBox(
              height :constraints.maxHeight*0.15,
              child:FittedBox(fit:BoxFit.fill ,child: Text(lable),),)
          ],
        );
      }),
    );
  }
}
