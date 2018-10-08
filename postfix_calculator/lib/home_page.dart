// Defining the home page of the app

import 'package:flutter/material.dart';

import 'package:postfix_calculator/InfixToPostifix/EquationCheck.dart';

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

  /// Update the equation state each time a button is pressed
  void updateEquation(String newInput){
    setState(() {
          equation = equationCheck(equation, newInput);
        });
  }

  /// Erase the last element of the equation
  void eraseLast() {
    setState(() {
        // if the string contains only 1 element, return a string with only a zero
          if(equation.length == 1) equation = '0';
          else equation = equation.substring(0,equation.length-1);
        });
  }

  // Expanded(MaterialButton(Conteiner(Center(Text()))))
  /// Create a button whit the desired label
  Widget _buildButton(value){
    return Expanded(
      flex: 1,
      child: MaterialButton(
        onPressed: () => updateEquation("$value"),
        child: Container(
          child: Center(
            child:Text(
              "$value",
              style: TextStyle(
                fontSize: 45.0,
              ),
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
          // TODO set boundaries, the text musn't overflow from the text widget
          Expanded(
            flex: 1,
            child: Center(
              child:Padding(
                padding: EdgeInsets.all(10.0), 
                child: Text(
                  equation,
                  style: TextStyle(fontSize: 45.0,),
                ),
              ),
            ),
          ),
          // Gridview containing the "keyboard"
          // TODO "keyboard"
          Expanded(
            flex: 2,
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
                // Operation keys
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      // Erase Button
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () => eraseLast(),
                          child: Container(
                            child: Center(
                              child: Icon(
                                Icons.backspace,
                              ),
                            ),
                          ),
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