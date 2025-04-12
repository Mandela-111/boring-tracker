import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:habit_tracker/data/services/storage_service.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:habit_tracker/data/services/subscription_service.dart';
import 'package:habit_tracker/presentation/screens/habit_tracking_screen.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/day_button.dart';

class OnboardingScreen extends StatefulWidget {
  final SubscriptionService subscriptionService;

  const OnboardingScreen({required this.subscriptionService});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final StorageService _storageService = StorageService();
  String? _selectedHabit;
  final TextEditingController _habitController = TextEditingController();
  List<bool> _selectedDays = List.filled(7, false);
  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 0);

  @override
  void initState() {
    super.initState();
    widget.subscriptionService.purchaseStream.listen((purchases) {
      for (var purchase in purchases) {
        if (purchase.status == PurchaseStatus.purchased) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchase successful!')),
          );
        } else if (purchase.status == PurchaseStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchase failed!')),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _habitController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildZeroScreen(),
              _buildSecretScreen(),
              _buildHabitTrackingIntroScreen(),
              _buildSubscriptionScreen(),
              _buildMiserableScreen(),
              _buildGuideScreen(),
              _buildGuideMeditateScreen(),
              _buildWhatSmallThingScreen(),
              _buildHabitSelectionScreen(),
              _buildRepetitionScreen(),
              _buildScientificScreen(),
              _buildScientific60Screen(),
              _buildMasterHabitScreen(),
              _buildReach60RepetitionsScreen(),
              _buildCountdownScreen(),
              _buildAchievementScreen(),
              _buildAddWidgetScreen(),
              _buildSetRoutineScreen(),
              _buildSmileyScreen(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '(Not Boring) Habits',
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentPage < 18) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HabitTrackingScreen()),
                      );
                    }
                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  'curated by Mobbin',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZeroScreen() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '-0-0-',
            style: TextStyle(fontSize: 48, color: Colors.grey),
          ),
          Positioned(
            left: -20,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 10,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 10,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -20,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 1000.ms).scale(),
    );
  }

  Widget _buildSecretScreen() {
    return OnboardingPage(
      title: 'WANT TO KNOW THE SECRET\nTO BUILDING BETTER\nHABITS..?',
      onTap: () => _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    ).animate().fadeIn(duration: 1000.ms).scale();
  }

  Widget _buildHabitTrackingIntroScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: 0.5,
                strokeWidth: 10,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              Icon(
                Icons.check,
                size: 50,
                color: Colors.black,
              ),
            ],
          ).animate().fadeIn(duration: 1000.ms).scale(),
          SizedBox(height: 10),
          Icon(
            Icons.bolt,
            size: 30,
            color: Colors.yellow,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayButton(day: '30', label: 'TUE', isToday: false),
              DayButton(day: '31', label: 'WED', isToday: false),
              DayButton(day: '1', label: 'THU', isToday: false),
              DayButton(day: '2', label: 'FRI', isToday: false),
              DayButton(day: '3', label: 'SAT', isToday: false),
              DayButton(day: '4', label: 'SUN', isToday: false),
              DayButton(day: '5', label: 'TODAY', isToday: true),
            ],
          ).animate().fadeIn(delay: 500.ms).slideY(),
        ],
      ),
    );
  }

  Widget _buildSubscriptionScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LIVE THE\n(NOT BORING)\nLIFE',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'EXPIRES ${DateTime.now().add(Duration(days: 7)).toString().substring(0, 10)}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              '(NOT BORING) MEMBER',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'PATRON',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await widget.subscriptionService.purchaseProduct('believer_subscription');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: Text('BELIEVER'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await widget.subscriptionService.purchaseProduct('patron_subscription');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('PATRON'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'UNLOCKS ALL (NOT BORING) APPS',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAppIcon(Icons.favorite, 'HABITS'),
                _buildAppIcon(Icons.cloud, 'WEATHER'),
                _buildAppIcon(Icons.calculate, 'CALCULATOR'),
                _buildAppIcon(Icons.timer, 'TIMER'),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.pink],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'TRY 7 DAYS FREE',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'THEN \$101.98/YEAR, CANCEL ANYTIME',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              'UNLOCK SKINS (BEAUTIFULLY PLAYFUL)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 1000.ms).scale(),
    );
  }

  Widget _buildMiserableScreen() {
    return Stack(
      children: [
        OnboardingPage(
          title: 'IT DOESN’T HAVE TO BE\nMISERABLE.',
          onTap: () => _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
        ).animate().fadeIn(duration: 1000.ms).scale(),
        Positioned(
          top: 200,
          right: 100,
          child: Icon(
            Icons.play_arrow,
            size: 20,
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }

  Widget _buildGuideScreen() {
    return OnboardingPage(
      title: 'WE’RE YOUR GUIDE. EVERY\nDAY WE HELP YOU TAKE A\nSTEP.',
      graphic: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.check,
            size: 60,
            color: Colors.black,
          ),
        ),
      ),
      onTap: () => _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    ).animate().fadeIn(duration: 1000.ms).scale();
  }

  Widget _buildGuideMeditateScreen() {
    return OnboardingPage(
      title: 'WE’RE YOUR GUIDE. EVERY\nDAY WE HELP YOU TAKE A\nSTEP.',
      graphic: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Text(
            _selectedHabit ?? 'MEDITATE',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
      onTap: () => _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    ).animate().fadeIn(duration: 1000.ms).scale();
  }

  Widget _buildWhatSmallThingScreen() {
    return OnboardingPage(
      title: 'WHAT SMALL THING COULD\nYOU DO EVERY DAY TO\nIMPROVE YOUR LIFE?',
      onTap: () => _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    ).animate().fadeIn(duration: 1000.ms).scale();
  }

  Widget _buildHabitSelectionScreen() {
    final habits = ['MEDITATE', 'STRETCH', 'EAT VEGGIES', 'CALL MOM'];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'START A NEW HABIT',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'TIP: THINK SMALL. START WITH 1\nMINUTE, 1 MILE, 1 MEAL...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'NAME YOUR HABIT',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            ...habits.map((habit) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedHabit = habit;
                  });
                  final habitBox = _storageService.getHabitsBox();
                  habitBox.put(
                    'selected_habit',
                    Habit(
                      id: '1',
                      name: habit,
                      date: DateTime.now(),
                      completedDates: [],
                    ),
                  );
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  habit,
                  style: TextStyle(
                    fontSize: 18,
                    color: _selectedHabit == habit ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            )),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _habitController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter custom habit',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                textAlign: TextAlign.center,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _selectedHabit = value.toUpperCase();
                    });
                    final habitBox = _storageService.getHabitsBox();
                    habitBox.put(
                      'selected_habit',
                      Habit(
                        id: '1',
                        name: _selectedHabit!,
                        date: DateTime.now(),
                        completedDates: [],
                      ),
                    );
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 1000.ms).scale(),
    );
  }

  Widget _buildRepetitionScreen() {
    return Stack(
      children: [
        OnboardingPage(
          title: 'IT SIMPLY COMES DOWN TO\nREPETITION.',
          onTap: () => _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
        ).animate().fadeIn(duration: 1000.ms).scale(),
        ..._buildScatteredTriangles(),
      ],
    );
  }

  Widget _buildScientificScreen() {
    return Stack(
      children: [
        OnboardingPage(
          title: 'SCIENTIFIC STUDIES HAVE\nSHOWN YOU NEED TO REPEAT\nA NEW BEHAVIOR 60 TIMES\nFOR IT TO STICK.',
          onTap: () => _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
        ).animate().fadeIn(duration: 1000.ms).scale(),
        ..._buildScatteredTriangles(),
      ],
    );
  }

  Widget _buildScientific60Screen() {
    return Stack(
      children: [
        OnboardingPage(
          title: 'SCIENTIFIC STUDIES HAVE\nSHOWN YOU NEED TO REPEAT\nA NEW BEHAVIOR 60 TIMES\nFOR IT TO STICK.',
          onTap: () => _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
        ).animate().fadeIn(duration: 1000.ms).scale(),
        Positioned(
          top: 100,
          child: Text(
            '60',
            style: TextStyle(fontSize: 100, color: Colors.white.withOpacity(0.2)),
          ),
        ),
        ..._buildScatteredTriangles(),
      ],
    );
  }

  Widget _buildMasterHabitScreen() {
    return OnboardingPage(
      title: 'UNTIL YOU’RE A MASTER OF\nYOUR NEW HABIT.',
      graphic: Container(
        width: 100,
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: 50,
                height: 30,
                color: Colors.black,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: 30,
                height: 120,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
      onTap: () => _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    ).animate().fadeIn(duration: 1000.ms).scale();
  }

  Widget _buildReach60RepetitionsScreen() {
    return OnboardingPage(
      title: 'AND GUIDE YOU TO REACH\nYOUR 60 REPETITIONS (OR\nMORE, IF YOU LIKE).',
      graphic: Container(
        width: 150,
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Transform.rotate(
                      angle: 0.7854,
                      child: Icon(
                        Icons.play_arrow,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
      onTap: () => _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    ).animate().fadeIn(duration: 1000.ms).scale();
  }

  Widget _buildCountdownScreen() {
    return Center(
      child: CountdownWidget(),
    );
  }

  Widget _buildAchievementScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _selectedHabit ?? 'STRETCH',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            'THE BASE',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'LIGHT SCATTERS ACROSS A\nFORGOTTEN FORM.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 20),
          Container(
            width: 150,
            height: 150,
            color: Colors.grey.withOpacity(0.5),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Text(
              'TAP TO CONTINUE',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 1000.ms).scale(),
    );
  }

  Widget _buildAddWidgetScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'THE BASE',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              'ADD A WIDGET',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'KEEP YOUR HABIT TOP OF MIND AND\nPUT A REMINDER OR SHOW YOUR\nPROGRESS ON YOUR HOME SCREEN.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey.withOpacity(0.5),
                  child: Center(child: Text('Widget 1')),
                ),
                SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey.withOpacity(0.5),
                  child: Center(child: Text('Widget 2')),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // TODO: Link to widget setup guide
              },
              child: Text(
                'LEARN MORE',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 1000.ms).scale(),
    );
  }

  Widget _buildSetRoutineScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SET A ROUTINE',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'TIP: CUES ARE IMPORTANT WHEN\nLEARNING A NEW HABIT. DON’T WORRY,\nYOU CAN CHANGE THIS LATER.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(7, (index) {
                final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDays[index] = !_selectedDays[index];
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedDays[index] ? Colors.white : Colors.transparent,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          days[index],
                          style: TextStyle(
                            color: _selectedDays[index] ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (picked != null) {
                  setState(() {
                    _selectedTime = picked;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _selectedTime.format(context),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                'SKIP',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final habitBox = _storageService.getHabitsBox();
                final habit = habitBox.get('selected_habit') as Habit;
                habitBox.put(
                  'selected_habit',
                  Habit(
                    id: habit.id,
                    name: habit.name,
                    date: habit.date,
                    days: _selectedDays,
                    time: '${_selectedTime.hour}:${_selectedTime.minute}',
                    completedDates: habit.completedDates,
                  ),
                );
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: Colors.white),
              ),
              child: Text(
                'CONTINUE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 1000.ms).scale(),
    );
  }

  Widget _buildSmileyScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text('X', style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Text('X', style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
                Positioned(
                  bottom: 20,
                  left: 40,
                  child: Container(
                    width: 20,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 20,
                  child: Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 1000.ms).scale(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ).animate().fadeIn(delay: 500.ms).slideX(),
              SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              ).animate().fadeIn(delay: 700.ms).slideX(),
              SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
              ).animate().fadeIn(delay: 900.ms).slideX(),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildScatteredTriangles() {
    return [
      Positioned(
        top: 50,
        left: 50,
        child: _buildTriangle().animate().fadeIn(duration: 1000.ms).moveY(begin: -10, end: 0),
      ),
      Positioned(
        top: 100,
        right: 50,
        child: _buildTriangle().animate().fadeIn(duration: 1200.ms).moveY(begin: -10, end: 0),
      ),
      Positioned(
        top: 150,
        left: 100,
        child: _buildTriangle().animate().fadeIn(duration: 1400.ms).moveY(begin: -10, end: 0),
      ),
      Positioned(
        top: 200,
        right: 100,
        child: _buildTriangle().animate().fadeIn(duration: 1600.ms).moveY(begin: -10, end: 0),
      ),
      Positioned(
        bottom: 50,
        left: 50,
        child: _buildTriangle().animate().fadeIn(duration: 1000.ms).moveY(begin: 10, end: 0),
      ),
      Positioned(
        bottom: 100,
        right: 50,
        child: _buildTriangle().animate().fadeIn(duration: 1200.ms).moveY(begin: 10, end: 0),
      ),
      Positioned(
        bottom: 150,
        left: 100,
        child: _buildTriangle().animate().fadeIn(duration: 1400.ms).moveY(begin: 10, end: 0),
      ),
      Positioned(
        bottom: 200,
        right: 100,
        child: _buildTriangle().animate().fadeIn(duration: 1600.ms).moveY(begin: 10, end: 0),
      ),
    ];
  }

  Widget _buildTriangle() {
    return Transform.rotate(
      angle: 0.7854,
      child: Icon(
        Icons.play_arrow,
        size: 20,
        color: Colors.yellow,
      ),
    );
  }

  Widget _buildAppIcon(IconData icon, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class CountdownWidget extends StatefulWidget {
  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  int _count = 3;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() async {
    while (_count > 0) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _count > 0 ? '$_count' : '1',
        style: TextStyle(fontSize: 100, color: Colors.white),
      ).animate().fadeIn(duration: 1000.ms).scale(),
    );
  }
}