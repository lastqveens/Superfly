import 'package:flutter/material.dart';
import 'dart:async'; // Import Timer

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet"; // Default pet name
  int happinessLevel = 50;
  int hungerLevel = 50;
  TextEditingController nameController = TextEditingController(); // Controller for the input field
  bool isNameSet = false; // Flag to check if the pet's name is set
  Timer? _hungerTimer; // Timer for increasing hunger level
  Timer? _winTimer; // Timer for win condition
  int _winTime = 0; // Counter to track how long happiness has been above 80
  bool _hasWon = false; // Flag to check if the player has already won

  @override
  void initState() {
    super.initState();
    _startHungerTimer(); // Start the hunger timer when the app starts
  }

  @override
  void dispose() {
    _hungerTimer?.cancel(); // Cancel the hunger timer when the app is closed
    _winTimer?.cancel(); // Cancel the win timer
    super.dispose();
  }

  // Function to start a timer that increases the pet's hunger every 30 seconds
  void _startHungerTimer() {
    _hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel + 10).clamp(0, 100); // Increase hunger
        _checkHungerAndHappiness(); // Check if hunger impacts happiness
      });
    });
  }

  // Function to check and adjust happiness level based on hunger
  void _checkHungerAndHappiness() {
    if (hungerLevel == 100 && happinessLevel <= 10) {
      // If hunger reaches 100 and happiness is 10 or less, game over
      _showGameOver();
    } else if (hungerLevel >= 80) {
      // Lower happiness if hunger is very high
      happinessLevel = (happinessLevel - 5).clamp(0, 100);
    }
    
    // Check win condition if happiness is above 80
    if (happinessLevel > 80 && !_hasWon) {
      _startWinTimer();
    } else if (happinessLevel <= 80) {
      _winTimer?.cancel(); // Reset win timer if happiness drops below 80
      _winTime = 0; // Reset the win time
    }
  }

  // Function to display a Game Over message
  void _showGameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your pet is too hungry and sad!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to display a Win message
  void _showWinMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Win!'),
          content: Text('You have kept your pet happy for 3 minutes!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to start the win timer
  void _startWinTimer() {
    _winTimer?.cancel(); // Cancel any existing win timer
    _winTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _winTime++;
      if (_winTime >= 90) { // 1 minute & 30 seconds (90 seconds)
        _hasWon = true;
        _winTimer?.cancel(); // Stop the win timer
        _showWinMessage(); // Display the win message
      }
    });
  }

  // Function to get pet's color based on happiness level
  Color _getPetColor() {
    if (happinessLevel > 70) {
      return Colors.green; // Happy
    } else if (happinessLevel >= 30 && happinessLevel <= 70) {
      return Colors.yellow; // Neutral
    } else {
      return Colors.red; // Unhappy
    }
  }

  // Get mood description
  String _getMood() {
    if (happinessLevel > 70) {
      return "😊 Happy";
    } else if (happinessLevel >= 30 && happinessLevel <= 70) {
      return "😐 Neutral";
    } else {
      return "😭 Unhappy";
    }
  }

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
    });
  }

  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
  }

  // Function to set the pet's name
  void _setPetName() {
    setState(() {
      petName = nameController.text; // Update the pet's name with the input
      isNameSet = true; // Mark the name as set
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      backgroundColor: _getPetColor(), // Dynamic background color
      body: Center(
        child: isNameSet
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Name: $petName', // Display the pet's name
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),

                  // Display pet image
                  Image.asset(
                    'assets/dog.png',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 16.0),

                  // Display happiness and hunger levels
                  Text(
                    'Happiness Level: $happinessLevel',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Hunger Level: $hungerLevel',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),

                  // Display mood based on happiness
                  Text(
                    _getMood(),
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 32.0),

                  // Buttons to interact with the pet
                  ElevatedButton(
                    onPressed: _playWithPet,
                    child: Text('Play with Your Pet'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _feedPet,
                    child: Text('Feed Your Pet'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enter your pet\'s name:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: nameController, // Input field controller
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pet Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _setPetName, // Set the pet's name on button press
                    child: Text('Confirm Name'),
                  ),
                ],
              ),
      ),
    );
  }
}
