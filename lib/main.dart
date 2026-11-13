
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const QuizMasterApp(),
    ),
  );
}

// 1. PROVIDER
class AppProvider extends ChangeNotifier {
  bool isDarkMode = false;
  int totalScore = 0;

  void changeTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void updateScore(int score) {
    totalScore += score;
    notifyListeners();
  }
}

// 2. QUIZ DATA
final Map<String, List<Map<String, dynamic>>> quizData = {
  'Science': [
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'answer': 1,
      'explanation': 'Mars appears red because of iron oxide on its surface.'
    },
    {
      'question': 'What is the chemical formula of water?',
      'options': ['CO2', 'O2', 'H2O', 'NaCl'],
      'answer': 2,
      'explanation': 'Water contains two hydrogen atoms and one oxygen atom.'
    },
  ],
  'Sports': [
    {
      'question': 'How many players are in a cricket team?',
      'options': ['9', '10', '11', '12'],
      'answer': 2,
      'explanation': 'A cricket team has eleven players.'
    },
    {
      'question': 'Which sport uses a shuttlecock?',
      'options': ['Tennis', 'Badminton', 'Football', 'Hockey'],
      'answer': 1,
      'explanation': 'Badminton is played using a shuttlecock.'
    },
  ],
  'Computers': [
    {
      'question': 'What does CPU stand for?',
      'options': [
        'Central Processing Unit',
        'Computer Personal Unit',
        'Central Program Utility',
        'Control Processing User'
      ],
      'answer': 0,
      'explanation': 'CPU stands for Central Processing Unit.'
    },
    {
      'question': 'Which language is used in Flutter?',
      'options': ['Java', 'Python', 'Dart', 'C'],
      'answer': 2,
      'explanation': 'Flutter applications are developed using Dart.'
    },
  ],
  'History': [
    {
      'question': 'Who was the first Prime Minister of India?',
      'options': [
        'Mahatma Gandhi',
        'Jawaharlal Nehru',
        'Sardar Patel',
        'Rajendra Prasad'
      ],
      'answer': 1,
      'explanation': 'Jawaharlal Nehru was the first Prime Minister of India.'
    },
    {
      'question': 'In which year did India gain independence?',
      'options': ['1945', '1946', '1947', '1950'],
      'answer': 2,
      'explanation': 'India became independent on 15 August 1947.'
    },
  ],
  'Mathematics': [
    {
      'question': 'What is 12 multiplied by 5?',
      'options': ['50', '55', '60', '65'],
      'answer': 2,
      'explanation': '12 multiplied by 5 equals 60.'
    },
    {
      'question': 'What is the square root of 81?',
      'options': ['7', '8', '9', '10'],
      'answer': 2,
      'explanation': '9 multiplied by 9 equals 81.'
    },
  ],
  'Movies': [
    {
      'question': 'Which industry is popularly called Bollywood?',
      'options': ['Tamil', 'Hindi', 'Telugu', 'Malayalam'],
      'answer': 1,
      'explanation': 'Bollywood commonly refers to the Hindi film industry.'
    },
    {
      'question': 'What does CGI stand for?',
      'options': [
        'Computer Generated Imagery',
        'Creative Graphic Internet',
        'Computer General Image',
        'Central Graphic Interface'
      ],
      'answer': 0,
      'explanation': 'CGI means Computer Generated Imagery.'
    },
  ],
  'General Knowledge': [
    {
      'question': 'What is the capital of India?',
      'options': ['Mumbai', 'Hyderabad', 'New Delhi', 'Chennai'],
      'answer': 2,
      'explanation': 'New Delhi is the capital of India.'
    },
    {
      'question': 'Which is the largest ocean?',
      'options': ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      'answer': 3,
      'explanation': 'The Pacific Ocean is the largest ocean.'
    },
  ],
};

// 3. COLOURS AND ICONS FOR TOPICS
final Map<String, Color> topicColors = {
  'Science': const Color(0xFF6750E8),
  'Sports': const Color(0xFF00A896),
  'Computers': const Color(0xFF2878E5),
  'History': const Color(0xFFE58A24),
  'Mathematics': const Color(0xFFE05291),
  'Movies': const Color(0xFF8B5CF6),
  'General Knowledge': const Color(0xFF169B62),
};

final Map<String, IconData> topicIcons = {
  'Science': Icons.science_rounded,
  'Sports': Icons.sports_cricket_rounded,
  'Computers': Icons.computer_rounded,
  'History': Icons.account_balance_rounded,
  'Mathematics': Icons.calculate_rounded,
  'Movies': Icons.movie_rounded,
  'General Knowledge': Icons.public_rounded,
};

// 4. MAIN APPLICATION AND THEMES
class QuizMasterApp extends StatelessWidget {
  const QuizMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    const purple = Color(0xFF6750E8);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Master',
      themeMode: app.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F6FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F6FC),
          foregroundColor: Color(0xFF25213A),
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}

// 5. CUSTOM TOPIC CARD - STATELESS WIDGET
class TopicCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const TopicCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = topicColors[title] ?? Colors.blue;
    final icon = topicIcons[title] ?? Icons.quiz;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.16),
                color.withOpacity(0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 25),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const Text(
                '2 Questions  →',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 6. HOME SCREEN
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    final topics = quizData.keys
        .where((topic) =>
            topic.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QUIZ MASTER',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GRADIENT WELCOME BANNER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6750E8),
                    Color(0xFF9675F5),
                    Color(0xFF4D9DE0),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.amber,
                    size: 35,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Hello, Quiz Champion!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Challenge yourself and learn something new.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.stars, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(
                        'Total Score: ${app.totalScore}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Explore Categories',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Choose your favourite topic and start playing!',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),

            const SizedBox(height: 16),

            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search your favourite topic...',
                prefixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: topics.isEmpty
                  ? const Center(child: Text('No topics found!'))
                  : GridView.builder(
                      itemCount: topics.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.12,
                      ),
                      itemBuilder: (context, index) {
                        final topic = topics[index];

                        return TopicCard(
                          title: topic,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizScreen(topic: topic),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// 7. QUIZ SCREEN
class QuizScreen extends StatefulWidget {
  final String topic;

  const QuizScreen({super.key, required this.topic});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  int selectedAnswer = -1;
  int score = 0;
  bool submitted = false;

  void submitAnswer() {
    if (selectedAnswer == -1) return;

    setState(() {
      submitted = true;

      if (selectedAnswer ==
          quizData[widget.topic]![questionIndex]['answer']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    final questions = quizData[widget.topic]!;

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswer = -1;
        submitted = false;
      });
    } else {
      context.read<AppProvider>().updateScore(score);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            topic: widget.topic,
            score: score,
            total: questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = quizData[widget.topic]!;
    final question = questions[questionIndex];
    final options = question['options'] as List<String>;
    final color = topicColors[widget.topic] ?? Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic),
        backgroundColor: color.withOpacity(0.12),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'YOUR CHALLENGE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    '${questionIndex + 1} / ${questions.length}',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: (questionIndex + 1) / questions.length,
                  minHeight: 9,
                  backgroundColor: color.withOpacity(0.15),
                  color: color,
                ),
              ),

              const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withOpacity(0.75),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb_rounded,
                      color: Colors.amber,
                      size: 30,
                    ),
                    const SizedBox(height: 14),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        question['question'] as String,
                        key: ValueKey(questionIndex),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Choose your answer',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final isCorrect = index == question['answer'];
                    final isSelected = index == selectedAnswer;

                    Color tileColor = Theme.of(context).cardColor;
                    Color borderColor = Colors.transparent;

                    if (submitted && isCorrect) {
                      tileColor = Colors.green.withOpacity(0.15);
                      borderColor = Colors.green;
                    } else if (submitted && isSelected && !isCorrect) {
                      tileColor = Colors.red.withOpacity(0.12);
                      borderColor = Colors.red;
                    } else if (isSelected) {
                      tileColor = color.withOpacity(0.12);
                      borderColor = color;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 1.5),
                      ),
                      child: RadioListTile<int>(
                        value: index,
                        groupValue: selectedAnswer,
                        activeColor: color,
                        title: Text(
                          options[index],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onChanged: submitted
                            ? null
                            : (value) {
                                setState(() {
                                  selectedAnswer = value!;
                                });
                              },
                      ),
                    );
                  },
                ),
              ),

              if (submitted)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: selectedAnswer == question['answer']
                        ? Colors.green.withOpacity(0.12)
                        : Colors.orange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    selectedAnswer == question['answer']
                        ? 'Correct! Well done!'
                        : 'Not quite! ${question['explanation']}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: submitted
                      ? nextQuestion
                      : selectedAnswer == -1
                          ? null
                          : submitAnswer,
                  child: Text(
                    submitted
                        ? questionIndex == questions.length - 1
                            ? 'View Result'
                            : 'Next Question'
                        : 'Submit Answer',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 8. RESULT SCREEN
class ResultScreen extends StatelessWidget {
  final String topic;
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.topic,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final color = topicColors[topic] ?? Colors.blue;
    final percentage = score / total;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Result')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.16),
                  color.withOpacity(0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.emoji_events_rounded,
                  size: 95,
                  color: Colors.amber.shade700,
                ),
                const SizedBox(height: 15),
                const Text(
                  'QUIZ COMPLETED!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(topic, style: TextStyle(color: color, fontSize: 18)),
                const SizedBox(height: 24),
                Text(
                  '$score / $total',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(percentage * 100).round()}% Score',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 15),
                Text(
                  percentage == 1
                      ? 'Perfect score! Amazing work!'
                      : percentage >= 0.5
                          ? 'Great effort! Keep learning!'
                          : 'Good try! Practice makes progress!',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Back to Home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 9. PROFILE SCREEN AND FORM VALIDATION
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF6750E8), Color(0xFF4D9DE0)],
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 55,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your Profile',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Enter Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                          .hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must contain 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6750E8),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 10. SETTINGS SCREEN
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6750E8), Color(0xFF4D9DE0)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.amber,
                    size: 40,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Quiz Score',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '${app.totalScore}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: SwitchListTile(
                secondary: const Icon(Icons.dark_mode_rounded),
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Change app appearance'),
                value: app.isDarkMode,
                onChanged: (_) {
                  context.read<AppProvider>().changeTheme();
                },
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About Quiz Master'),
                subtitle: Text('Learn, play and improve your knowledge!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
