

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const QuizMasterApp(),
    ),
  );
}

// 1. PROVIDER STATE MANAGEMENT
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

// 2. QUIZ QUESTIONS
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

// 3. MAIN APPLICATION
class QuizMasterApp extends StatelessWidget {
  const QuizMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Master',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness:
            app.isDarkMode ? Brightness.dark : Brightness.light,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

// 4. CUSTOM TOPIC CARD - STATELESS WIDGET
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
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 5. HOME SCREEN - SEARCH AND NAVIGATION
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final topics = quizData.keys
        .where((topic) =>
            topic.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Master'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Quiz Master!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Choose a topic and test your knowledge.'),
            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Search topics...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Available Topics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

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
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (context, index) {
                        final topic = topics[index];

                        return TopicCard(
                          title: topic,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QuizScreen(topic: topic),
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

// 6. QUIZ SCREEN - STATEFUL WIDGET AND SETSTATE
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
          builder: (context) => ResultScreen(
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

    return Scaffold(
      appBar: AppBar(title: Text(widget.topic)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${questionIndex + 1} of ${questions.length}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: (questionIndex + 1) / questions.length,
            ),

            const SizedBox(height: 25),

            // ANIMATION USING ANIMATED SWITCHER
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                question['question'] as String,
                key: ValueKey(questionIndex),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            ...List.generate(options.length, (index) {
              Color? cardColor;

              if (submitted && index == question['answer']) {
                cardColor = Colors.green.withOpacity(0.2);
              } else if (submitted && index == selectedAnswer) {
                cardColor = Colors.red.withOpacity(0.2);
              }

              return Card(
                color: cardColor,
                child: RadioListTile<int>(
                  title: Text(options[index]),
                  value: index,
                  groupValue: selectedAnswer,
                  onChanged: submitted
                      ? null
                      : (value) {
                          setState(() {
                            selectedAnswer = value!;
                          });
                        },
                ),
              );
            }),

            const SizedBox(height: 10),

            if (submitted)
              Text(
                selectedAnswer == question['answer']
                    ? 'Correct answer! Well done!'
                    : 'Incorrect answer.\n${question['explanation']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 7. RESULT SCREEN
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
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.emoji_events,
              size: 90,
              color: Colors.amber,
            ),
            const SizedBox(height: 15),
            Text(
              topic,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 15),
            Text(
              'Your Score: $score / $total',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// 8. PROFILE FORM AND VALIDATION
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
      appBar: AppBar(title: const Text('User Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must contain 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form submitted successfully!'),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 9. SETTINGS AND THEME MANAGEMENT
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Change app appearance'),
            value: app.isDarkMode,
            onChanged: (value) {
              context.read<AppProvider>().changeTheme();
            },
          ),

          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Total Quiz Score'),
            trailing: Text('${app.totalScore}'),
          ),
        ],
      ),
    );
  }
}

