// Unicode UTF-16 table: https://www.fileformat.info/info/charset/UTF-16/list.htm

/// Take a string containing an inifix equation and convert it to a postfix equation
/// All number in the infix equation must be integers
String infixToPostfix(String infixEquation){
    // Strings are mede of runes (Unicode UTF-16 code units (int containing the decimal value of UTF-16))
    // String are immutable, use a string buffer to crate a string
    StringBuffer strBuff = new StringBuffer();
    // Stack containing the operators
    List operatorStack = [];
    // Check every rune of the infix equation
    for (int i=0; i<infixEquation.length; i++){
      // push = add to the stack
      // pop = remove the last added element of the stack
      // If a digit is found, keep printing digit until there are no more digit to print
      if (isNumber(infixEquation[i])) {
        do{
          strBuff.write(infixEquation[i]);
          i++;
        // If the string ends with a number (and it's very likely) rember to not access the string beyond it's lenght
        }while((i<infixEquation.length) && (isNumber(infixEquation[i])));
        strBuff.write(' ');
        // Must rewind i to the element of the string
        if (i >= infixEquation.length) i = infixEquation.length-1;
      } // Once the digit are all printed, I must check what is the next character, and what to do with it
      // If an open parentheses is found, push it to the stack
      if (infixEquation[i] == '('){
        operatorStack.add(infixEquation[i]);
      }
      // If a closed parentheses is found, pop all operators, from the stack, until an open parenthesis is found
      else if(infixEquation[i] == ')'){
        do{
          strBuff.write(operatorStack.removeLast()+' ');
        }while(operatorStack.last != '(');
        // Discarding the opern parenthesis
        operatorStack.removeLast();
      }
      // If an operator is found
      else if ( isOperator(infixEquation[i]) ){
        // If the stack is empy, or the precedence of the actual operator is greater than the last operator in the stack
        // push the operator in the stack
        if ((operatorStack.isEmpty) || (operatorPriority(infixEquation[i]) > operatorPriority(operatorStack.last))){
          operatorStack.add(infixEquation[i]);
        } else { // Empty the stack, until it's empty or the last operator (of the stack) has less precedence of the current operator
          do{
            strBuff.write(operatorStack.removeLast() + ' ');
          } while((operatorStack.isNotEmpty) && (operatorPriority(infixEquation[i]) < operatorPriority(operatorStack.last)));
          // When done push the operator at hand
          operatorStack.add(infixEquation[i]);
        }
      }
    }
    // Pop the remaining content of the stack
    while(operatorStack.isNotEmpty){
      strBuff.write(operatorStack.removeLast() + ' ');
    }
    return strBuff.toString();
}



/// Take a rune (integer rappresenting Unicode code point)
/// Return true if the rune is a number or a dot
bool isNumber (String num){
  int i = num.codeUnitAt(0);
  // Numbers are between 48 (0) and 57 (9), the dot is 46
  if ( (i >= 48 && i <= 57) || (i == 46) ) return true;
  return false;
}



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