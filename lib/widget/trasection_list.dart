// ignore_for_file: must_be_immutable

/*
It will manage all the things related to rendering of Transection List 
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transection.dart';

/*
  as our state of transection is manage in user trasection file ,trasection list need not be a stateless widget
 */
class TransectionList extends StatelessWidget {
  List<Transection> transectionlist = [];
  final Function deleteTransection;
  TransectionList(
      {Key? key,
      required this.transectionlist,
      required this.deleteTransection})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return transectionlist.isEmpty
            ? SizedBox(
                height: constraints.maxHeight * 0.8,
                child: Card(
                  elevation: 30,
                  shadowColor: const Color.fromARGB(255, 152, 24, 154),
                  color: const Color.fromARGB(
                    210,
                    87,
                    28,
                    138,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.10,
                            child: const FittedBox(
                              child: Text(
                                "Koi kharcha nahi!",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.05,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.40,
                            child: Image.asset(
                              "assets/images/new.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: transectionlist.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Card(
                    elevation: 50,
                    color: const Color.fromARGB(
                      210,
                      87,
                      28,
                      138,
                    ),
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      horizontalTitleGap: 2,
                      leading: CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              const Color.fromARGB(255, 222, 7, 255),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: FittedBox(
                              child: Text(
                                "₹ ${transectionlist[index].amount.toStringAsFixed(2)}", //will dispaly till two decimal places only
                                style: const TextStyle(
                                  color: Color.fromARGB(
                                    255,
                                    228,
                                    243,
                                    255,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          )),
                      title: Text(
                        transectionlist[index].title,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 235, 188, 254),
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(
                          transectionlist[index].date,
                        ),
                        style: const TextStyle(
                          color: Color.fromARGB(
                            255,
                            189,
                            172,
                            198,
                          ),
                        ),
                      ),
                      trailing: MediaQuery.of(context).size.width > 420
                          ? ElevatedButton.icon(
                              onPressed: () {
                                deleteTransection(transectionlist[index].id);
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text("delete"),
                            )
                          : IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteTransection(transectionlist[index].id);
                              },
                              color:const Color.fromARGB(255, 185, 42, 207) ,
                            ),
                    ),
                  );
                  // return Card(
                  //   elevation: 50,
                  //   color: const Color.fromARGB(
                  //     210,
                  //     87,
                  //     28,
                  //     138,
                  //   ),
                  //   /* Styling
                  //         Container is very flexible as it comes to styling,
                  //         Here you can have
                  //         margin
                  //         border
                  //         padding
                  //         bg colur and also can be decorated using boxDecoration
                  //          */
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       /*We want to decorate the price only this we can done with wrapping the text widget within container
                  //          */
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             color: const Color.fromARGB(255, 124, 40, 180),
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //                 color: const Color.fromARGB(255, 44, 23, 56),
                  //                 width: 3,
                  //                 style: BorderStyle.solid)),
                  //         margin: const EdgeInsets.symmetric(
                  //           horizontal: 10,
                  //           vertical: 15,
                  //         ),
                  //         padding: const EdgeInsets.all(
                  //           25,
                  //         ),
                  //         child: FittedBox(child:Text(
                  //           "₹ ${transectionlist[index].amount.toStringAsFixed(2)}", //will dispaly till two decimal places only
                  //           style: const TextStyle(
                  //             color: Color.fromARGB(
                  //               255,
                  //               228,
                  //               243,
                  //               255,
                  //             ),
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 17,
                  //           ),
                  //         ), ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             transectionlist[index].title,
                  //             style: const TextStyle(
                  //                 color: Color.fromARGB(255, 235, 188, 254),
                  //                 fontFamily: "OpenSans",
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 18),
                  //           ),
                  //           Text(
                  //             DateFormat.jm().add_yMEd().format(
                  //                   transectionlist[index].date,
                  //                 ),
                  //             style: const TextStyle(
                  //               color: Color.fromARGB(
                  //                 255,
                  //                 189,
                  //                 172,
                  //                 198,
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
              );
      }),
    );
    //  Container(
    //   margin:const EdgeInsets.all(14),
    //to make it responsive to the different screen sizes
    /*
        singlechildscrooller
        Creates a box in which a single widget can be scrolled.
        listview 
        is a like a column with scrollabelsignel child widget which usful if have a small amount list items beacause it builts all list item of the list which visible and which are not visible for performance it is not good at all 
        so ,we should use /listview.builder method instead of list view because it only buid those elemnets which are visible on the screen
        unlike column listview take infinte space of the screen so ,it should be provide the boundary container
        /itemcount tells the total number of items in the given list  
       */
    //child:
  }
}
