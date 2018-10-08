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