import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Bill Splitter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentSlider = 1;
  var dropVal = '3';
  double result = 0.0;

  var items = ['3', '5', '10'];
  bool showErr = false;

  String? get error {
    final amount = textController.value.text;
    if (amount.isEmpty) {
      return "Can't be empty";
    }
  }

  void calculate() {
    final text = textController.value.text;
    if (error == null) {
      setState(() {
        var totalVal = (double.parse(text) * double.parse(dropVal)) / 100;
        var taxVal = (double.parse(text) + totalVal) / _currentSlider;
        result = taxVal;
      });
    }
  }

  TextEditingController sliderController = TextEditingController();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bill",
                        style: GoogleFonts.abel(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: textController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          errorText: showErr ? error : null,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(
                            Icons.euro,
                            size: 20,
                            color: Colors.black,
                          ),
                          hintText: "Total Amount",
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (text) => setState(() {}),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tax",
                      style: GoogleFonts.abel(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton2(
                      underline: const SizedBox(),
                      value: dropVal,
                      items: items
                          .map((String items) => DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          dropVal = newVal as String;
                        });
                      },
                      iconEnabledColor: Colors.black,
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      buttonHeight: 50,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      itemHeight: 40,
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount of People",
                          style: GoogleFonts.abel(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 30,
                          child: TextFormField(
                            showCursor: true,
                            readOnly: true,
                            controller: sliderController,
                            style: const TextStyle(fontSize: 20),
                            decoration: const InputDecoration(
                              hintText: "1",
                              hintStyle: TextStyle(fontSize: 20),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Slider(
                value: _currentSlider.toDouble(),
                min: 1,
                max: 30,
                label: _currentSlider.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSlider = value.toInt();
                    sliderController.text = _currentSlider.toString();
                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (textController.value.text.isNotEmpty) {
                            calculate();
                          } else {
                            setState(() {
                              showErr = true;
                            });
                          }
                        },
                        child: Text(
                          'Calculate',
                          style: GoogleFonts.abel(fontSize: 18),
                        ))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Split Total",
                      style: GoogleFonts.abel(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      result.toStringAsFixed(2),
                      style: GoogleFonts.abel(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
