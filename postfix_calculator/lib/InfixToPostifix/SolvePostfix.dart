import 'dart:math';

import 'package:postfix_calculator/InfixToPostifix/HelperFunction.dart';

double postfixResolution(String postfixEquation){
  List<String> postfixList = postfixEquation.split(" ");
  postfixList.removeLast(); // The last element is an empty one
  List<double> numberStack = [];
  for (var x in postfixList){
    if (isNumber(x[0])) {
      numberStack.add(double.parse(x));
    }else {
      numberStack.add(performOperation(x, numberStack.removeLast(), numberStack.removeLast()));
    } 
  } // For
  return numberStack.removeLast();
}



double performOperation(String op, double y, double x){
  switch(op){

    // case ^
    case '^': return pow(x,y);

    // case * /
    case '*': return x*y;
    case '/': return x/y;

    // case + -
    case '+': return x+y;
    case '-': return x-y;

    // default
    default: return -1.0;

  } // switch
}