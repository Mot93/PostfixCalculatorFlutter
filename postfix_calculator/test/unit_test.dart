// With unit test I am testing the logical part of the app (conversion from infix to postfix)

import 'package:test/test.dart';

import 'package:postfix_calculator/InfixToPostifix/helper_function.dart';
import 'package:postfix_calculator/InfixToPostifix/infix_to_postfix.dart';
import 'package:postfix_calculator/InfixToPostifix/equation_check.dart';
import 'package:postfix_calculator/InfixToPostifix/solve_postfix.dart';

void main() {

  test(
    "Testing helper function",
    (){
      // Non mapped char should return -1
      expect(operatorPriority('?'), -1);
      // Checking operatorPriority
      assert(operatorPriority('*') > operatorPriority('+'));
      expect(operatorPriority('+'), operatorPriority('-'));
      // Checking isDot
      expect(isDot('.'), true);
      expect(isDot('è'), false);
      // Checking isParentheses
      expect(isParentheses('('), true);
      expect(isParentheses(')'), true);
      expect(isParentheses('o'), false);
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
      // Testing lastChr
      expect(lastChr("hello"), 'o');
      expect(lastChr("bye"), 'e');
      expect(lastChr("strawbery"), 'y');
      expect(lastChr("1"), '1');
      // Testing openParentheses and missingParentheses
      expect(missingParentheses("1+("), ')');
      expect(missingParentheses("1+((6"), "))");
      expect(missingParentheses("1+((6)"), ')');
      expect(missingParentheses("1+(3)"), "");
      // Testing eqWithNeutralElement
      expect(eqWithNeutralElement("1+"), "1+0");
      expect(eqWithNeutralElement("1*"), "1*1");
      expect(eqWithNeutralElement("1+("), "1+(0");
      expect(eqWithNeutralElement("1+((("), "1+(((0");
    } 
  );

  test(
    "Testing the InfixToPostfix library",
    (){
      // Checking infixToPostfix
      expect(infixToPostfix("1*2+3"), "1 2 * 3 + ");
      expect(infixToPostfix("1+2*3"), "1 2 3 * + ");
      expect(infixToPostfix("1*(2+3)"), "1 2 3 + * ");
      expect(infixToPostfix("1-2+3"), "1 2 - 3 + ");
      expect(infixToPostfix("5*2^3+4"), "5 2 3 ^ * 4 + ");
      expect(infixToPostfix("1*(2+3*4)+5"), "1 2 3 4 * + * 5 + ");
      expect(infixToPostfix("1.1+2.2"), "1.1 2.2 + ");
    }
  );

  test(
    "Testing EquationChecker",
    (){
      // Checking dot
      expect(equationCheck('0', '.'), "0.");
      expect(equationCheck('0.', '.'), "0.");
      expect(equationCheck("0.3", '.'), "0.3");
      expect(equationCheck("3+(", '.'), "3+(");
      expect(equationCheck("3+", '.'), "3+");
      // Checking numbers
      expect(equationCheck('0', '1'), '1');
      expect(equationCheck("3+0", '7'), "3+7");
      expect(equationCheck("3+7", '7'), "3+77");
      expect(equationCheck("3+0", '7'), "3+7");
      expect(equationCheck("3+0.", '7'), "3+0.7");
      // Checking operators
      expect(equationCheck('0', '-'), "0-");
      expect(equationCheck("0-", '+'), "0+");
      expect(equationCheck("0-(", '+'), "0-(");
      // Checking parentheses
      expect(equationCheck("3+2.", '('), "3+2.");
      expect(equationCheck("3+2.", ')'), "3+2.");
      expect(equationCheck("3+", '('), "3+(");
      expect(equationCheck("3+2", ')'), "3+2");
      expect(equationCheck("3+(2", ')'), "3+(2)");
    }
  );

  test(
    "Testing solve postfix",
    (){
      // Testing postfixResolution
      expect(postfixResolution("1 2 + "), 3);
      expect(postfixResolution("5 2 3 ^ * 4 + "), 44);
      expect(solveEquation("1+2"), 3);
      expect(solveEquation("1+(0"), 1.0);
    }
  );

}// Main
