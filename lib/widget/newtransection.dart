import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
 WE had to make new transection widget a statefull widget even though we are not calling setstate methode because,every time we enter the data in showbottom field it rerenders the app and because of which all the data stored in stateless widgets get set to defaut values */
class NewTransection extends StatefulWidget {
  final Function txAddTransection;
  const NewTransection({Key? key, required this.txAddTransection})
      : super(key: key);

  @override
  State<NewTransection> createState() => _NewTransectionState();
}

class _NewTransectionState extends State<NewTransection> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  void _presentDayPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then(
      (date) {
        if (selectedDate == DateTime.now()) {
          return;
        } else {
          setState(() {
            selectedDate = date as DateTime;
          });
        }
      },
    );
  }

  void submitData() {
    final enterText = titleController.text;
    final enterAmount = double.parse(amountController.text);
    if (enterText.isEmpty || enterAmount < 0) {
      return;
    }
    widget.txAddTransection(titleController.text,
        double.parse(amountController.text), selectedDate);
    Navigator.of(context).pop();
    //removes the showbottomsheet when one transection gets complited
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return SingleChildScrollView(
          child: SizedBox(
            height: constraints.maxHeight,
            child: Card(
              child: Container(
                color: const Color.fromARGB(255, 223, 218, 226),
                child: Column(children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 94, 15, 163),
                      decoration: const InputDecoration(
                        labelText: "Samman",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 57, 3, 105),
                        ),
                      ),
                      controller: titleController,
                      keyboardType: TextInputType.name,
                      onSubmitted: (_) => submitData(),
                      /*
                            [onChanged] is called before [onSubmitted] when user indicates completion of editing, such as when pressing the "done" button on the keyboard. That default behavior can be overridden. See [onEditingComplete] for details. 
                             */
                      // onChanged: (val) {
                      //   inputTitle = val;
                      // },
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 94, 15, 163),
                      // onChanged: (val) {
                      //   inputAmount = val;
                      // },
                      decoration: const InputDecoration(
                        labelText: "Kharcha",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 57, 3, 105),
                        ),
                      ),
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) =>
                          submitData(), //dumping returned string value
                    ),
                  ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: submitData,
                              // print(inputTitle);
                              // print(inputAmount);
                              child: Text(
                                " Date: ${DateFormat.yMd().format(selectedDate)}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 94, 15, 163),
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: _presentDayPicker,
                              // print(inputTitle);
                              // print(inputAmount);
                              child: const Text(
                                "Chosse a date",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 94, 15, 163),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(1),
                            padding: const EdgeInsets.all(1),
                            height: constraints.maxHeight * 0.12,
                            child: ElevatedButton(
                              onPressed: submitData,
                              // print(inputTitle);
                              // print(inputAmount);
                              child: const Text(
                                "Add Kharcha",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 199, 174, 210),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
              )
            ),
          ),
        );
      }),
    );
  }
}
