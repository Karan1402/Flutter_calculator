import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;


  Widget calbutton(String btnText, Color btnColor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
          onPressed: () {

            calculation(btnText);
          },
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 35,
              color: txtcolor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: btnColor,
            padding: EdgeInsets.all(20),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:<Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '$text',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,

                      ),

                      textAlign: TextAlign.left,

                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                // here is the button function where we will pass some arguments
                calbutton('AC', Colors.grey, Colors.black),
                calbutton('+/-', Colors.grey, Colors.black),
                calbutton('%', Colors.grey, Colors.black),
                calbutton('/', Colors.amber.shade700, Colors.white),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                // here is the button function where we will pass some arguments
                calbutton('7', Colors.grey.shade800, Colors.white),
                calbutton('8', Colors.grey.shade800, Colors.white),
                calbutton('9', Colors.grey.shade800, Colors.white),
                calbutton('x', Colors.amber.shade700, Colors.white),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                // here is the button function where we will pass some arguments
                calbutton('4', Colors.grey.shade800, Colors.white),
                calbutton('5', Colors.grey.shade800, Colors.white),
                calbutton('6', Colors.grey.shade800, Colors.white),
                calbutton('-', Colors.amber.shade700, Colors.white),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                // here is the button function where we will pass some arguments
                calbutton('1', Colors.grey.shade800, Colors.white),
                calbutton('2', Colors.grey.shade800, Colors.white),
                calbutton('3', Colors.grey.shade800, Colors.white),
                calbutton('+', Colors.amber.shade700, Colors.white),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ElevatedButton(

                  onPressed: () {
                    //button function
                    calculation('0');
                  },
                  child: Text('0',
                    style: TextStyle(
                      fontSize:35,
                      color:Colors.white,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    shape: StadiumBorder(),
                    backgroundColor:Colors.grey.shade800,
                  ),

                ),
                calbutton('.', Colors.grey.shade800, Colors.white),
                calbutton('=', Colors.amber.shade700, Colors.white),
              ]),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
  // here will be calculator logic for the app
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
