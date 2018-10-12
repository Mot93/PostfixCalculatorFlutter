import 'dart:math';

import 'package:postfix_calculator/InfixToPostifix/helper_function.dart';
import 'package:postfix_calculator/InfixToPostifix/InfixToPostfix.dart';

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
  // TODO, if the stack contains more than an element, throw an exception
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



/// Take an infix equation and return the solution (double)
double solveEquation(String equation){
  return postfixResolution(infixToPostfix(equation)+missingParentheses(equation));
}