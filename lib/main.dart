import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgeCalculator(),
    ),
  );
}

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({Key? key}) : super(key: key);

  @override
  State<AgeCalculator> createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  DateTime d = DateTime.now();
  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  String? birthDate;
  String? birthMonth;
  String? birthYear;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  String presetYear = "00";
  String presetMonth = "00";
  String presetDay = "00";

  String nextMonth = "00";
  String nextDay = "00";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textSize = size.height * 0.025;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Age Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today's date"),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: "${d.day} ${months[d.month - 1]}, ${d.year}",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                      disabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Birth date"),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextField(
                          controller: dateController,
                          onChanged: (val) {
                            birthDate = val;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: size.height * 0.0015,
                            fontSize: size.height * 0.025,
                          ),
                          showCursor: false,
                          decoration: InputDecoration(
                            hintText: "DD",
                            hintStyle: TextStyle(
                              fontSize: size.height * 0.025,
                            ),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 10,
                        child: TextField(
                          controller: monthController,
                          onChanged: (val) {
                            birthMonth = val;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: size.height * 0.0015,
                            fontSize: size.height * 0.025,
                          ),
                          showCursor: false,
                          decoration: InputDecoration(
                            hintText: "MM",
                            hintStyle: TextStyle(
                              fontSize: size.height * 0.025,
                            ),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 10,
                        child: TextField(
                          controller: yearController,
                          onChanged: (val) {
                            birthYear = val;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: size.height * 0.0015,
                            fontSize: size.height * 0.025,
                          ),
                          showCursor: false,
                          decoration: InputDecoration(
                            hintText: "YYYY",
                            hintStyle: TextStyle(
                              fontSize: size.height * 0.025,
                            ),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            dateController.clear();
                            monthController.clear();
                            yearController.clear();

                            birthDate = null;
                            birthMonth = null;
                            birthYear = null;
                          });
                        },
                        splashColor: Colors.blueAccent,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              fontSize: textSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (birthYear == null) {
                              birthYear = "00";
                            }
                            if (birthMonth == null) {
                              birthMonth = "00";
                            }
                            if (birthDate == null) {
                              birthDate = "00";
                            }

                            presetYear = (d.month < int.parse(birthMonth!))
                                ? (d.year - int.parse(birthYear!) - 1)
                                    .toString()
                                : (d.year - int.parse(birthYear!)).toString();

                            presetMonth = (int.parse(birthMonth!) > d.month)
                                ? ((12 - int.parse(birthMonth!)) + d.month)
                                    .toString()
                                : (d.month - int.parse(birthMonth!)).toString();

                            presetDay = (int.parse(birthDate!) <= d.day)
                                ? (d.day - int.parse(birthDate!)).toString()
                                : (30 - (int.parse(birthDate!) - d.day))
                                    .toString();

                            nextMonth = (int.parse(birthMonth!) > d.month)
                                ? (int.parse(birthMonth!) - d.month).toString()
                                : ((12 - d.month) + int.parse(birthMonth!))
                                    .toString();
                            nextDay = (int.parse(birthDate!) >= d.day)
                                ? (int.parse(birthDate!) - d.day).toString()
                                : (30 - d.day + int.parse(birthDate!))
                                    .toString();

                            if (int.parse(birthDate!) >= d.day &&
                                int.parse(birthMonth!) >= d.month &&
                                int.parse(birthYear!) >= d.year) {
                              presetDay = "00";
                              presetMonth = "00";
                              presetYear = "00";

                              nextDay = "00";
                              nextMonth = "00";
                            }

                            if (presetMonth.length == 1) {
                              presetMonth = "0$presetMonth";
                            }
                          });
                        },
                        splashColor: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                              fontSize: textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Present Age"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 0.18,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blueAccent,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              presetYear,
                              style: TextStyle(
                                fontSize: textSize,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Year",
                              style: TextStyle(
                                fontSize: textSize,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              presetMonth,
                              style: TextStyle(
                                fontSize: textSize,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Month",
                              style: TextStyle(
                                fontSize: textSize,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              presetDay,
                              style: TextStyle(
                                fontSize: textSize,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Day",
                              style: TextStyle(
                                fontSize: textSize,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            //TODO: Next birthday
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Next birthday"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: size.height * 0.18,
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nextMonth,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize,
                                ),
                              ),
                              Text(
                                "Month",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize,
                                ),
                              )
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nextDay,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize,
                                ),
                              ),
                              Text(
                                "Day",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize,
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
