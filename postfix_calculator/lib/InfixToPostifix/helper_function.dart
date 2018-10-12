import 'package:postfix_calculator/InfixToPostifix/SolvePostfix.dart';

/// Return the operator priority
int operatorPriority(String c){
  switch(c){

    // case ^
    case '^': return 3;

    // case * /
    case '*': return 2;
    case '/': return 2;

    // case + -
    case '+': return 1;
    case '-': return 1;

    // case ( )
    case '(': return 0;
    case ')': return 0;

    // default
    default: return -1;

  }// switch
} // operatorPriority



/// Return the operator priority
String neutralElement(String c){
  switch(c){

    // case * / ^
    case '^': return '1';
    case '*': return '1';
    case '/': return '1';

    // case + -
    case '+': return '0';
    case '-': return '0';

    // default
    default: return '-1';

  }// switch
}



/// True if the char is an operator
/// I consider parentheses to be operators
bool isOperator(String op){
  if ( operatorPriority(op) > -1 ) return true;
  return false;
}



/// Take a rune (integer rappresenting Unicode code point)
/// Return true if the rune is a number or a dot
bool isNumber (String num){
  int i = num.codeUnitAt(0);
  // Numbers are between 48 (0) and 57 (9), the dot is 46
  if ( (i >= 48 && i <= 57) || (i == 46) ) return true;
  return false;
}



/// True if the char is a dot
bool isDot(String chr){
  if (chr == '.') return true;
  return false;
}



/// True if the char is a parentheses
bool isParentheses(String chr){
  if ((chr == '(') || (chr==')')) return true;
  return false;
}



/// Return last char in String
String lastChr(String s){
  return s[s.length-1];
}



/// Count how many open parentheses are left
int openParentheses(String eq){
  int count = 0;
  for(int i=0; i<eq.length; i++){
    if(eq[i] == '(') count++;
    if(eq[i] == ')') count--;
  }
  return count;
}



/// Return a string containing the missing parentheses
String missingParentheses(String eq){
  StringBuffer missingP = new StringBuffer();
  for (int i=0; i<openParentheses(eq); i++) missingP.write(')');
  return missingP.toString();
}



/// Return an euation with the needed neutral element
String eqWithNeutralElement(String equation){
  StringBuffer eq = new StringBuffer();
  // After an operator add its neutral element
  if(isOperator(lastChr(equation)) && lastChr(equation) != '(') 
    eq.write(equation+neutralElement(lastChr(equation)));
  else{ // after an open bracket search for the last operator and add its neutral element
    int i=equation.length-1;
    while((i>-1) && (equation[i]=='(')){
      i--; // Repeat until something different than ( is found
    }
    if(isOperator(equation[i])) 
      eq.write(equation+neutralElement(equation[i]));
  }
  return eq.toString();
}