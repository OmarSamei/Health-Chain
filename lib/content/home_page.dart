import 'package:flutter/material.dart';
import 'package:health_chain/content/break_page.dart';
import 'package:health_chain/content/doctors_page.dart';
import 'package:health_chain/content/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // الصفحات اللي هننتقل بينها
  final List<Widget> _pages = const [
    HomeContent(), // الصفحة الرئيسية
    BreakPage(),
    DoctorsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ الـ AppBar هيتغير حسب الصفحة المفتوحة
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _selectedIndex == 0
            ? const Text(
                'Good Morning, Omar 🎉',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            : null, // باقي الصفحات مش هيظهر فيها العنوان
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {},
                ),
              ]
            : [], // زرار الإشعارات مش هيظهر غير في الهوم
      ),

      // الصفحات
      body: IndexedStack(index: _selectedIndex, children: _pages),

      // الـ Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_satisfied_alt),
            label: 'Break',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// صفحة المحتوى الرئيسية
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.0,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            const SizedBox(height: 5),
            const Text(
              "You've completed 0/0 tasks today",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Today\'s Plan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset('assets/frames/pana.png', height: 200),
                  const SizedBox(height: 20),
                  const Text(
                    'No tasks yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Start your journey to better productivity! Add your first task now',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
