import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterAndImageToggle(),
    );
  }
}

class CounterAndImageToggle extends StatefulWidget {
  @override
  _CounterAndImageToggleState createState() => _CounterAndImageToggleState();
}

class _CounterAndImageToggleState extends State<CounterAndImageToggle> {
  // Counter variables
  int _counter = 0;

  // Image toggle variables
  bool _showFirstImage = true;

  // Method to increment the counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Method to toggle the image
  void _toggleImage() {
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time to count'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Counter section
          Center(
            child: Column(
              children: [
                // Displays the current counter value
                Text(
                  '$_counter',
                  style: const TextStyle(fontSize: 50.0),
                ),
                const SizedBox(height: 20),
                // Increment button
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('Increment Counter'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40), // Space between sections

          // Image Toggle section
          Center(
            child: Column(
              children: [
                // Display image based on the toggle state
                _showFirstImage
                    ? Image.asset(
                        'assets/shrek.png',
                        height: 150,
                      )
                    : Image.asset(
                        'assets/dach.png',
                        height: 150,
                      ),
                const SizedBox(height: 20),
                // Toggle button to switch between images
                ElevatedButton(
                  onPressed: _toggleImage,
                  child: const Text('Toggle Image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
