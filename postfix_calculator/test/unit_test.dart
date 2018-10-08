// With unit test I am testing the logical part of the app (conversion from infix to postfix)

import 'package:test/test.dart';

import 'package:postfix_calculator/InfixToPostifix/InfixToPostfix.dart';

void main() {

  test(
    "Testing the InfixToPostfix library",
    (){
      // Non mapped char should return -1
      expect(operatorPriority('?'), -1);
      // Checking operatorPriority
      assert(operatorPriority('*') > operatorPriority('+'));
      expect(operatorPriority('+'), operatorPriority('-'));
      // Checking isDot
      String s='h.i';
      expect(isDot(s[1]), true);
      expect(isDot(s[0]), false);
      // Checking isNumber
      // The first 11 elements must return true
      String str = "0123456789.pgftxzbaqw";
      for (int i=0; i<11; i++){
        assert(isNumber(str[i]));
      }
      // From the 12th element to the end of the string, isNumber must return false
      for (int i=11; i<str.length; i++){
        assert(!isNumber(str[i]));
      }
      // Checking infixToPostfix
      expect(infixToPostfix("1*2+3"), "1 2 * 3 + ");
      expect(infixToPostfix("1+2*3"), "1 2 3 * + ");
      expect(infixToPostfix("1*(2+3)"), "1 2 3 + * ");
      expect(infixToPostfix("1-2+3"), "1 2 - 3 + ");
      expect(infixToPostfix("1*2^3+4"), "1 2 3 ^ * 4 + ");
      expect(infixToPostfix("1*(2+3*4)+5"), "1 2 3 4 * + * 5 + ");
    }
  );

}// Main
