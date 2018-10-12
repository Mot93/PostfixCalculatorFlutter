import 'package:postfix_calculator/InfixToPostifix/helper_function.dart';

/// Checks whether the new input should be 
String equationCheck(String equation, String newInput){
  StringBuffer newEquation = new StringBuffer();
  newEquation.write("");
  // If we enter dot 
  if (newInput=='.'){
    // To place a dot, the previous character MUST BE a number 
    // can't place a dot after an operator or a parenthesys or another dot
    if (isNumber(lastChr(equation))){
      // If the string is 1 char long, add the dot
      if(equation.length == 1){
        newEquation.write(equation + newInput);
      }else{// I must check if the number has already a dot
        bool dotFlag = true; // true = there isn't another dot
        int i = 1;
        // Stop when finding an operator or a comma 
        // Also stop when the string is finished
        while ((i <= equation.length) && (! isOperator(equation[equation.length-i]))){
          if(isDot(equation[equation.length-i])) dotFlag = false;
          i++;
        }
        if (dotFlag){
          newEquation.write(equation + newInput);
        } else {
          newEquation.write(equation);
        } 
      }
    } else {
      newEquation.write(equation);
    }
  // If we enter a number
  } else if (isNumber(newInput[0])){
    // If the last element of equation is a zero and the beforelast is an operator or the string beginning, sobstitute the zero with the new number
    if ((lastChr(equation) == '0') && ((equation.length == 1) || (isOperator(equation[equation.length-2])))){
      newEquation.write(equation.substring(0, equation.length-1) + newInput);
    } else { // Otherwise, always add a number
      newEquation.write(equation + newInput);
    }
  // If we enter an operator
  } else if (isOperator(newInput)){
    if (isParentheses(newInput)){
      if ((newInput==')')) // ')' there has to be open bracket, it has to come after a number (and not a .)
        if ((openParentheses(equation)>0) && (isNumber(lastChr(equation))) && (lastChr(equation)!='.'))
          newEquation.write(equation + ')');
        else 
          newEquation.write(equation);
      else // '(' can only appear after operator
        if (isOperator(lastChr(equation)))
          newEquation.write(equation + '(');
        else 
          newEquation.write(equation);
    }else{ // if it's an operator
      // TODO: allow - for neg number
      if (lastChr(equation) == '(') { // can't add operator after open parenthesys
        newEquation.write(equation);
      }else if (isNumber(lastChr(equation))){
        newEquation.write(equation + newInput);
      } else { // change the previous operator with a new one
        newEquation.write(equation.substring(0,equation.length-1) + newInput);
      }
    }
  }
  return newEquation.toString();
}