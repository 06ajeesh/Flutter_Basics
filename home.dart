import 'package:flutter/material.dart';
import 'package:first_app/pages/button_values.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String num1 = ""; // 0-9 and .
  String num2 = ""; // 0-9 and .
  String operand = ""; // + - * /

  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 300),
                  alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        "$num1$operand$num2".isEmpty?"0":"$num1$operand$num2",
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.end,
                    ),
                ),
              ),
            ),

            Wrap(
              children: Btn.buttonValues
                  .map(
                      (value) => SizedBox(
                          height: screenSize.height/9,
                          width:
                            value==Btn.calculate?screenSize.width/2:
                            screenSize.width/4,
                          child: buildButton(value),
                      ),
                      )
                  .toList()),
          ],
        ),
      ),
    );
  }

  //________________________________________

  Widget buildButton(value){
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        color:getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
            onTap: (){
              onBtnTap(value);
            },
            child: Center(child: Text(value,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))
        ),
      ),
    );
  }

  //___________________________________________

  void onBtnTap( value){
    if (value == Btn.del){
      delete();
      return;
    }
    if (value == Btn.clr){
      clearAll();
      return;
    }
    if (value == Btn.per){
      convertPercentage();
      return;
    }
    if (value == Btn.calculate){
      calculate();
      return;
    }

    appendValue(value);
  }
  //___________________________________________

  void delete(){
    if (num2.isNotEmpty){
      num2=num2.substring(0,num2.length-1);
    }
    else if (operand.isNotEmpty){
      operand="";
    }
    else if (num1.isNotEmpty){
      num1=num1.substring(0,num1.length-1);
    }
    setState(() {});
  }

  //____________________________________________

  void clearAll(){
    setState(() {
      num1="";
      num2="";
      operand="";
    });
  }

  //____________________________________________

  void convertPercentage(){
    if (num1.isNotEmpty&&operand.isNotEmpty&&num2.isNotEmpty){
      calculate();
    }
    if (operand.isNotEmpty){
      //can't
    }
    final num = double.parse(num1);
    setState(() {
      num1="${(num/100)}";
      operand = "";
      num2 = "";
    });
  }

  //___________________________________________

  void calculate(){
    if (num1.isEmpty) return ;
    if (operand.isEmpty) return;
    if (num2.isEmpty) return;

    double n1 = double.parse(num1);
    double n2 = double.parse(num2);

    var result = 0.0;
    switch(operand){
      case Btn.add:
        result= n1 + n2;
        break;
      case Btn.substract:
        result = n1 - n2;
        break;
      case Btn.multiply:
        result = n1 * n2;
        break;
      case Btn.divide:
        result = n1 / n2;
        break;
      default:
    }
    setState(() {
      num1 = "$result";

      if (num1.endsWith(".0")){
        num1 = num1.substring(0,num1.length-2);
      }
      if  (num1.endsWith(".00")){
        num1 = num1.substring(0,num1.length-3);
      }
      operand = "";
      num2 = "";
    });
  }

  //____________________________________________

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && num2.isNotEmpty) {
        calculate();
      }
      operand = value;
    } else if (num1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && num1.contains(Btn.dot)) return;
      if (value == Btn.dot && (num1.isEmpty || num1 == Btn.dot)) {
        value = "0.";
      }
      num1 += value;
    } else if (operand.isNotEmpty) {
      if (value == Btn.dot && num2.contains(Btn.dot)) return;
      if (value == Btn.dot && (num2.isEmpty || num2 == Btn.dot)) {
        value = "0.";
      }
      num2 += value;
    }
    setState(() {});
  }

  //_______________________________________

  Color getBtnColor(value){
    return
      [Btn.del,Btn.clr].contains(value)?Colors.blueGrey:
      [Btn.per,Btn.multiply,Btn.add,Btn.substract,Btn.divide].contains(value)?Colors.orangeAccent:
      [Btn.calculate].contains(value)?Colors.greenAccent:
      Colors.black45;
  }

  //______________________________________
}


