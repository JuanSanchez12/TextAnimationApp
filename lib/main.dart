import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
  ),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLight = true;

  void toggleTheme() {
    setState(() {
      if (_isLight) {
        _isLight = false;
      } else {
        _isLight = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme;

    if (_isLight) {
      currentTheme = lightMode;
    } else {
      currentTheme = darkMode;
    }

    return MaterialApp(
      theme: currentTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fading Text Animation'),
          actions: [
            IconButton(
              icon: () {
                if (_isLight) {
                  return Icon(Icons.wb_sunny);
                } else {
                  return Icon(Icons.nightlight_round);
                }
              }(),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: PageView(
          children: [
            FadingTextAnimation(
              text: 'Hello, Flutter! This is the first screen.',
              duration: Duration(seconds: 1),
              curve: Curves.easeIn,
            ),
            FadingTextAnimation(
              text: 'Welcome to the second screen!',
              duration: Duration(seconds: 3),
              curve: Curves.bounceIn,
            ),
            ImageToggleScreen(),
          ],
        ),
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final String text;
  final Duration duration;
  final Curve curve;

  FadingTextAnimation({
    required this.text,
    required this.duration,
    required this.curve,
  });

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      if (_isVisible) {
        _isVisible = false;
      } else {
        _isVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double opacity;

    if (_isVisible) {
      opacity = 1.0;
    } else {
      opacity = 0.0;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: opacity,
            duration: widget.duration,
            curve: widget.curve,
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: toggleVisibility,
            child: Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}

class ImageToggleScreen extends StatefulWidget {
  @override
  _ImageToggleScreenState createState() => _ImageToggleScreenState();
}

class _ImageToggleScreenState extends State<ImageToggleScreen> {
  bool _showFrame = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: () {
                if (_showFrame) {
                  return Border.all(color: Colors.blue, width: 4);
                } else {
                  return null;
                }
              }(),

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://images.pexels.com/photos/577585/pexels-photo-577585.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                width: 300,
                height: 300,
              ),
            ),
          ),
          SizedBox(height: 20),
          SwitchListTile(
            title: Text('Show Frame'),
            value: _showFrame,
            onChanged: (bool value) {
              setState(() {
                _showFrame = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
