// Defining the home page of the app
// TODO set limits on the screen

import 'package:flutter/material.dart';

import 'package:postfix_calculator/InfixToPostifix/equation_check.dart';
import 'package:postfix_calculator/InfixToPostifix/InfixToPostfix.dart';
import 'package:postfix_calculator/InfixToPostifix/helper_function.dart';
import 'package:postfix_calculator/InfixToPostifix/SolvePostfix.dart';

//-------------------------------------
/// Home page widget
class HomePage extends StatefulWidget {
  /// Constructor
  const HomePage();
  /// State initialization
  @override
  _HomePageState createState() => new _HomePageState();
}


//-------------------------------------------
/// Home page state
class _HomePageState extends State<HomePage>{

  /// String containing the equation to solve
  String equation = '0';
  /// String containing the solution or postfix equation
  String solution = '0';
  /// Font size of main text & buttons
  /// The solution is half this size
  double fontS = 45.0;
  /// Label on the output button
  String outputButtonLabel = "postfix";
  /// Curve around the output button
  final double outButtonRadius = 10;

  /// Update the solution 
  /// The passed equation had to be cecked
  /// To be sure that the equation is correct
  void updateState(String eq){
    setState(
      () {
        if(eq.length<40){ // Max length of the equation
          StringBuffer tempSolution = new StringBuffer();
          equation = eq;

          // Checking if the equation is correct by trying to solving it
          try{
            // If the equation ends with a number or ) just add the missing parentheses
            if (isNumber(lastChr(equation)) || lastChr(equation) == ')') // if the equation ends with a ) or a number, solve it
              if(lastChr(equation) == '.') // Add a zero after a .
                tempSolution.write(solveEquation(equation+'0').toString()); 
              else 
                tempSolution.write(solveEquation(equation).toString()); 
            else{ // otherwise, add the neutral element needed to solve the equation and the missing parentheses
              tempSolution.write(solveEquation(eqWithNeutralElement(equation)));
            }            
          } catch(e) { // If the equation is not correct, return an empty solution
            tempSolution.clear();
          }

          // Returning either the postfix or the solution
          if (outputButtonLabel == "postfix"){ // postfix
            solution = infixToPostfix(equation);
          }else{ // solution
            solution = tempSolution.toString();
          } 

        } // if max lenght
    }); // Set State
  } // Update state

  /// Create a button whit the desired label
  Widget _buildButton(value){
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () => updateState(equationCheck(equation, value.toString())),
        child: Container(
          alignment: Alignment( // Making the container as big as the parent allows
            0.0, 0.0
          ),
          child:Text(
            value.toString(),
            style: TextStyle(
              fontSize: fontS,
            ),
          ),
        ),
      ),
    );
  }

  /// Build a row of button
  /// Each button has the specified label
  Widget _buildButtonRow(List values){
    // Creating a list of buttons
    List<Widget> buttons = [];
    for (var x in values){
      buttons.add(_buildButton(x));
    }
    // Pacing the list of buttons in a Expanded(Row)
    return Expanded(
      flex: 1,
      child: Row(
        children: buttons,
      ),
    );
  }

  /// Build
  @override
  Widget build(BuildContext context){

    // Definin the AppBar
    // Using final because I won't change my appBar
    // TODO add navigation button to the bar
    var appBar = AppBar(
      title: Text("Postfix Calculator"),
    );

    // Defining the Body of the home page
    // The body is a column containing a text field and a gridview
    var body = Container(
      child: Column(
        children: <Widget>[
          // Text holding the equation
          Expanded(
            flex: 2,
            child: Center(
              child:Padding(
                padding: EdgeInsets.all(10.0), 
                child: Text(
                  equation,
                  style: TextStyle(fontSize: fontS,),
                ),
              ),
            ),
          ),
          Divider(),
          // Row with output button and results
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Row(
                children: <Widget>[
                  // Output button (postfix/result)
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(outButtonRadius)),
                      onTap: () {
                        if (outputButtonLabel == "postfix") outputButtonLabel = "solution";
                        else outputButtonLabel = "postfix";
                        updateState(equation);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(86, 86, 86, 0.1), // RGB + Opacity
                          borderRadius: BorderRadius.all(Radius.circular(outButtonRadius)),
                          //boxShadow: ,
                        ),
                        alignment: Alignment( // Making the container as big as the parent allows
                          0.0, 0.0
                        ),
                        child: Text(outputButtonLabel),
                      ),
                    ),
                  ),
                  // Results text
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          solution,
                          style: TextStyle(
                            fontSize: (fontS/2),
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
          Divider(),
          // Gridview containing the "keyboard"
          // TODO "keyboard"
          Expanded(
            flex: 4,
            // There are 2 column
            //    1) Containing the numbers
            //    2) Containing the Oparation
            child: Row(
              children: <Widget>[
                // Numeric Pad
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      _buildButtonRow([7,8,9]),
                      _buildButtonRow([4,5,6]),
                      _buildButtonRow([1,2,3]),
                      _buildButtonRow([0, '.']),
                    ],
                  ),
                ),
                Divider(),
                // Operation keys
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      // Erase Button
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            // if the string contains only 1 element, return a string with only a zero
                            if(equation.length == 1) updateState('0');
                            else updateState(equation.substring(0,equation.length-1));
                          },
                          onLongPress: () => updateState('0'),
                          child: InkWell(
                          child: Container(
                            alignment: Alignment(0.0, 0.0), // Making the container as big as the parent allows
                              child: Icon(
                                Icons.backspace,
                              ),
                          ),),
                        ),
                      ),
                      // Buttons + - / *
                      _buildButton('+'),
                      _buildButton('-'),
                      _buildButton('/'),
                      _buildButton('*'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

}