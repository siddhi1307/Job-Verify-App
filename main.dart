import 'package:flutter/material.dart';

void main() {
  runApp(const JobVerifyApp());
}

// ============================================================
// COLORS
// ============================================================

const Color primaryBlue = Color(0xFF2853D8);
const Color darkBlue = Color(0xFF092F63);
const Color lightBlue = Color(0xFFEAF0FF);
const Color green = Color(0xFF18A866);
const Color red = Color(0xFFF04444);
const Color orange = Color(0xFFFFA726);
const Color textDark = Color(0xFF172B54);
const Color textGrey = Color(0xFF687994);
const Color backgroundColor = Color(0xFFF7F9FF);

// ============================================================
// REPORT MODEL
// ============================================================

class ScamReport {
  final String company;
  final String reason;
  final String details;
  final String date;
  final String risk;

  ScamReport({
    required this.company,
    required this.reason,
    required this.details,
    required this.date,
    required this.risk,
  });
}

// ============================================================
// SAVED JOB MODEL
// ============================================================

class SavedJob {
  final String company;
  final String position;
  final String website;
  final String recruiterName;
  final String recruiterPhone;
  final String recruiterEmail;
  final String location;
  final String salary;
  final String interviewMethod;
  final bool paymentRequested;
  final String risk;

  SavedJob({
    required this.company,
    required this.position,
    this.website = '',
    this.recruiterName = '',
    this.recruiterPhone = '',
    this.recruiterEmail = '',
    this.location = '',
    this.salary = '',
    this.interviewMethod = '',
    this.paymentRequested = false,
    this.risk = 'Low Risk',
  });
}

// ============================================================
// APP DATA
// ============================================================

class AppData extends ChangeNotifier {
  AppData._privateConstructor();

  static final AppData instance =
  AppData._privateConstructor();

  // ----------------------------------------------------------
  // REPORTS
  // ----------------------------------------------------------

  final List<ScamReport> reports = [
    ScamReport(
      company: 'GlobalTech Solutions',
      reason: 'Asked for money',
      details: 'Asked for registration fee.',
      date: '12 Apr 2025',
      risk: 'High Risk',
    ),
    ScamReport(
      company: 'PrimeJobs India',
      reason: 'Fake website',
      details: 'Website looked suspicious.',
      date: '8 Apr 2025',
      risk: 'Medium Risk',
    ),
    ScamReport(
      company: 'TechCareers',
      reason: 'Job does not exist',
      details: 'Job could not be verified.',
      date: '5 Apr 2025',
      risk: 'Low Risk',
    ),
    ScamReport(
      company: 'NextGen Careers',
      reason: 'Fake recruiter',
      details: 'Recruiter email was suspicious.',
      date: '28 Mar 2025',
      risk: 'Medium Risk',
    ),
    ScamReport(
      company: 'CareerHub',
      reason: 'Personal information requested',
      details: 'Asked for sensitive information.',
      date: '20 Mar 2025',
      risk: 'High Risk',
    ),
  ];

  // ----------------------------------------------------------
  // SAVED JOBS
  // ----------------------------------------------------------

  final List<SavedJob> savedJobs = [];

  int jobsChecked = 0;

  // ----------------------------------------------------------
  // ADD REPORT
  // ----------------------------------------------------------

  void addReport({
    required String company,
    required String reason,
    required String details,
  }) {
    reports.insert(
      0,
      ScamReport(
        company: company,
        reason: reason,
        details: details,
        date: 'Today',
        risk: calculateRisk(reason),
      ),
    );

    notifyListeners();
  }

  // ----------------------------------------------------------
  // RISK
  // ----------------------------------------------------------

  String calculateRisk(String reason) {
    if (reason == 'Asked for money') {
      return 'High Risk';
    }

    if (reason == 'Fake website' ||
        reason == 'Fake recruiter') {
      return 'Medium Risk';
    }

    return 'Low Risk';
  }

  // ----------------------------------------------------------
  // JOB CHECKED
  // ----------------------------------------------------------

  void jobChecked() {
    jobsChecked++;
    notifyListeners();
  }

  // ----------------------------------------------------------
  // CHECK IF JOB IS SAVED
  // ----------------------------------------------------------

  bool isJobSaved(
      String company,
      String position,
      ) {
    return savedJobs.any(
          (job) =>
      job.company.toLowerCase() ==
          company.toLowerCase() &&
          job.position.toLowerCase() ==
              position.toLowerCase(),
    );
  }

  // ----------------------------------------------------------
  // SAVE / UNSAVE JOB
  // ----------------------------------------------------------

  void toggleSavedJob(
      String company,
      String position,
      {
        String website = '',
        String recruiterName = '',
        String recruiterPhone = '',
        String recruiterEmail = '',
        String location = '',
        String salary = '',
        String interviewMethod = '',
        bool paymentRequested = false,
        String risk = 'Low Risk',
      }) {
    final index = savedJobs.indexWhere(
          (job) =>
      job.company.toLowerCase() ==
          company.toLowerCase() &&
          job.position.toLowerCase() ==
              position.toLowerCase(),
    );

    if (index >= 0) {
      // Already saved → remove it
      savedJobs.removeAt(index);
    } else {
      // Not saved → add it
      savedJobs.insert(
        0,
        SavedJob(
          company: company,
          position: position,
          website: website,
          recruiterName: recruiterName,
          recruiterPhone: recruiterPhone,
          recruiterEmail: recruiterEmail,
          location: location,
          salary: salary,
          interviewMethod: interviewMethod,
          paymentRequested: paymentRequested,
          risk: risk,
        ),
      );
    }

    notifyListeners();
  }

  // ----------------------------------------------------------
  // REMOVE SAVED JOB
  // ----------------------------------------------------------

  void removeSavedJob(int index) {
    if (index >= 0 &&
        index < savedJobs.length) {
      savedJobs.removeAt(index);
      notifyListeners();
    }
  }
}
// ============================================================
// APP
// ============================================================

class JobVerifyApp extends StatelessWidget {
  const JobVerifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobVerify',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ============================================================
// SPLASH SCREEN
// ============================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
          () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const RegistrationScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF172A91),
              Color(0xFF244ED8),
              Color(0xFF102B72),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.verified_user_rounded,
                    size: 75,
                    color: primaryBlue,
                  ),
                ),

                const SizedBox(height: 25),

                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Job',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Verify',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF22D7D0),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Smart Job Scam Detection\n& Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 80),

                const Text(
                  'Verify before you trust.\nStay safe from job scams.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.6,
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

// ============================================================
// REGISTRATION
// ============================================================

String registeredFullName = '';
String registeredUsername = '';
String registeredEmail = '';
String registeredPassword = '';
bool accountCreated = false;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void createAccount() {
    if (!formKey.currentState!.validate()) return;

    registeredFullName = fullNameController.text.trim();
    registeredUsername = usernameController.text.trim();
    registeredEmail = emailController.text.trim();
    registeredPassword = passwordController.text;
    accountCreated = true;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully! Please login.'),
        backgroundColor: green,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  String? requiredField(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    final email = value.trim();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.verified_user_rounded,
                  size: 85,
                  color: primaryBlue,
                ),
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Job',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                      ),
                      TextSpan(
                        text: 'Verify',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create your account',
                  style: TextStyle(color: textGrey),
                ),
                const SizedBox(height: 35),

                const FieldTitle('Full Name'),
                AppTextField(
                  controller: fullNameController,
                  hint: 'Enter your full name',
                  icon: Icons.person_outline,
                  validator: (value) =>
                      requiredField(value, 'Please enter your full name'),
                ),

                const SizedBox(height: 15),
                const FieldTitle('Username'),
                AppTextField(
                  controller: usernameController,
                  hint: 'Create a username',
                  icon: Icons.account_circle_outlined,
                  validator: (value) {
                    final error = requiredField(value, 'Please enter a username');
                    if (error != null) return error;
                    if (value!.trim().length < 3) {
                      return 'Username must have at least 3 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                const FieldTitle('Email'),
                AppTextField(
                  controller: emailController,
                  hint: 'Enter your email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),

                const SizedBox(height: 15),
                const FieldTitle('Password'),
                AppTextField(
                  controller: passwordController,
                  hint: 'Create a password',
                  icon: Icons.lock_outline,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: primaryBlue,
                    ),
                    onPressed: () {
                      setState(() => obscurePassword = !obscurePassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must have at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                const FieldTitle('Confirm Password'),
                AppTextField(
                  controller: confirmPasswordController,
                  hint: 'Re-enter your password',
                  icon: Icons.lock_reset_outlined,
                  obscureText: obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: primaryBlue,
                    ),
                    onPressed: () {
                      setState(() => obscureConfirmPassword = !obscureConfirmPassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),
                PrimaryButton(
                  text: 'Create Account',
                  onPressed: createAccount,
                ),

                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (!accountCreated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please create an account first.'),
          backgroundColor: red,
        ),
      );
      return;
    }

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password.')),
      );
      return;
    }

    if (username == registeredUsername && password == registeredPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeDashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password.'),
          backgroundColor: red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Icon(
                Icons.verified_user_rounded,
                size: 85,
                color: primaryBlue,
              ),
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Job',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                    TextSpan(
                      text: 'Verify',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to continue',
                style: TextStyle(color: textGrey),
              ),
              const SizedBox(height: 35),

              const FieldTitle('Username'),
              AppTextField(
                controller: usernameController,
                hint: 'Username',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 15),
              const FieldTitle('Password'),
              AppTextField(
                controller: passwordController,
                hint: 'Password',
                icon: Icons.lock_outline,
                obscureText: obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: primaryBlue,
                  ),
                  onPressed: () {
                    setState(() => obscurePassword = !obscurePassword);
                  },
                ),
              ),

              const SizedBox(height: 25),
              PrimaryButton(
                text: 'Login',
                onPressed: login,
              ),

              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME
// ============================================================

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Home',
      selectedIndex: 0,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, Siddhi 👋',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Welcome to JobVerify',
              style: TextStyle(
                color: textGrey,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3159DD),
                    Color(0xFF193B9E),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.verified_user,
                    color: Colors.white,
                    size: 45,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Verify before you trust.\nStay safe from job scams.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: DashboardCard(
                    icon: Icons.search,
                    color: primaryBlue,
                    title: 'Check a Job',
                    subtitle: 'Analyze job offer',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const CheckJobScreen(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: DashboardCard(
                    icon: Icons.warning_rounded,
                    color: red,
                    title: 'Report Scam',
                    subtitle: 'Report suspicious job',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const ReportScamScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              'How It Works?',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            const SizedBox(height: 15),

            const Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                HowWorkItem(
                  icon: Icons.business,
                  text: 'Company',
                ),
                HowWorkItem(
                  icon: Icons.language,
                  text: 'Website',
                ),
                HowWorkItem(
                  icon: Icons.email,
                  text: 'Email',
                ),
                HowWorkItem(
                  icon: Icons.payment,
                  text: 'Payment',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CHECK JOB
// ============================================================

class CheckJobScreen extends StatefulWidget {
  const CheckJobScreen({super.key});

  @override
  State<CheckJobScreen> createState() =>
      _CheckJobScreenState();
}

class _CheckJobScreenState
    extends State<CheckJobScreen> {
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final websiteController = TextEditingController();
  final recruiterNameController = TextEditingController();
  final recruiterPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final jobLocationController = TextEditingController();
  final salaryController = TextEditingController();

  bool paymentRequested = false;
  String interviewMethod = 'Video Call';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Check a Job',
      selectedIndex: 1,
      showBack: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text(
              'Enter job details and we\'ll analyze multiple risk signals.',
              style: TextStyle(
                color: textGrey,
              ),
            ),

            const SizedBox(height: 25),

            const FieldTitle('Job Title'),

            AppTextField(
              controller: jobTitleController,
              hint: 'Software Developer Intern',
              icon: Icons.work_outline,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Company Name'),

            AppTextField(
              controller: companyController,
              hint: 'TCS',
              icon: Icons.business,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Job Website / Link'),

            AppTextField(
              controller: websiteController,
              hint: 'https://company-careers.com',
              icon: Icons.language,
              keyboardType: TextInputType.url,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Recruiter Name'),

            AppTextField(
              controller: recruiterNameController,
              hint: 'Rahul Sharma',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Recruiter Phone / WhatsApp'),

            AppTextField(
              controller: recruiterPhoneController,
              hint: '+91 98765 43210',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Recruiter Email'),

            AppTextField(
              controller: emailController,
              hint: 'hr@company.com',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Job Location'),

            AppTextField(
              controller: jobLocationController,
              hint: 'Mumbai, Maharashtra / Remote',
              icon: Icons.location_on_outlined,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Salary / Stipend'),

            AppTextField(
              controller: salaryController,
              hint: '₹25,000/month',
              icon: Icons.currency_rupee,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 15),

            const FieldTitle('Interview Method'),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: const Color(0xFFDDE4F0),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: interviewMethod,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryBlue,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Video Call',
                      child: Row(
                        children: [
                          Icon(
                            Icons.video_call_outlined,
                            color: primaryBlue,
                          ),
                          SizedBox(width: 12),
                          Text('Video Call'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Phone Call',
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: primaryBlue,
                          ),
                          SizedBox(width: 12),
                          Text('Phone Call'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'In-person',
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: primaryBlue,
                          ),
                          SizedBox(width: 12),
                          Text('In-person'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'WhatsApp Chat',
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat_outlined,
                            color: primaryBlue,
                          ),
                          SizedBox(width: 12),
                          Text('WhatsApp Chat'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Telegram Chat',
                      child: Row(
                        children: [
                          Icon(
                            Icons.send_outlined,
                            color: primaryBlue,
                          ),
                          SizedBox(width: 12),
                          Text('Telegram Chat'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'No Interview',
                      child: Row(
                        children: [
                          Icon(
                            Icons.block_outlined,
                            color: primaryBlue,
                          ),
                          SizedBox(width: 12),
                          Text('No Interview'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        interviewMethod = value;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(13),
                border: Border.all(
                  color: const Color(0xFFDDE4F0),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.payment,
                    color: primaryBlue,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Payment Requested?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Switch(
                    value: paymentRequested,
                    onChanged: (value) {
                      setState(() {
                        paymentRequested = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            PrimaryButton(
              text: 'Analyze Job',
              onPressed: () {
                AppData.instance.jobChecked();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        JobAnalysisScreen(
                          jobTitle: jobTitleController.text.isEmpty
                              ? 'Software Developer Intern'
                              : jobTitleController.text,
                          company: companyController.text.isEmpty
                              ? 'TCS'
                              : companyController.text,
                          website: websiteController.text,
                          recruiterName: recruiterNameController.text,
                          recruiterPhone: recruiterPhoneController.text,
                          recruiterEmail: emailController.text,
                          location: jobLocationController.text,
                          salary: salaryController.text,
                          interviewMethod: interviewMethod,
                          paymentRequested: paymentRequested,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// JOB ANALYSIS
// ============================================================

class RiskResult {
  final int score;
  final String risk;

  const RiskResult({required this.score, required this.risk});
}

RiskResult calculateJobRisk({
  required String website,
  required String recruiterName,
  required String recruiterPhone,
  required String recruiterEmail,
  required String interviewMethod,
  required bool paymentRequested,
}) {
  int score = 0;

  // Strong warning signal
  if (paymentRequested) score += 45;

  // Interview/channel warning signals
  if (interviewMethod == 'No Interview') {
    score += 25;
  } else if (interviewMethod == 'Telegram Chat' ||
      interviewMethod == 'WhatsApp Chat') {
    score += 15;
  }

  // Missing recruiter information is a smaller warning signal.
  if (recruiterName.trim().isEmpty) score += 5;
  if (recruiterPhone.trim().isEmpty) score += 5;

  // Website/email consistency is only treated as a simple input-based
  // warning here; this does not perform a live internet verification.
  if (website.trim().isEmpty) {
    score += 10;
  }

  if (recruiterEmail.trim().isEmpty) {
    score += 10;
  } else if (website.trim().isNotEmpty) {
    final email = recruiterEmail.trim().toLowerCase();
    final url = website.trim().toLowerCase();
    final emailDomain = email.contains('@')
        ? email.split('@').last
        : '';
    final websiteDomain = url
        .replaceFirst(RegExp(r'^https?://'), '')
        .split('/').first
        .replaceFirst(RegExp(r'^www\.'), '');

    if (emailDomain.isNotEmpty &&
        websiteDomain.isNotEmpty &&
        emailDomain != websiteDomain) {
      score += 20;
    }
  }

  if (score > 100) score = 100;

  if (score >= 60) {
    return RiskResult(score: score, risk: 'High Risk');
  }

  if (score >= 30) {
    return RiskResult(score: score, risk: 'Medium Risk');
  }

  return RiskResult(score: score, risk: 'Low Risk');
}

class JobAnalysisScreen extends StatefulWidget {
  final String jobTitle;
  final String company;
  final String website;
  final String recruiterName;
  final String recruiterPhone;
  final String recruiterEmail;
  final String location;
  final String salary;
  final String interviewMethod;
  final bool paymentRequested;

  const JobAnalysisScreen({
    super.key,
    required this.jobTitle,
    required this.company,
    required this.website,
    required this.recruiterName,
    required this.recruiterPhone,
    required this.recruiterEmail,
    required this.location,
    required this.salary,
    required this.interviewMethod,
    required this.paymentRequested,
  });

  @override
  State<JobAnalysisScreen> createState() => _JobAnalysisScreenState();
}

class _JobAnalysisScreenState extends State<JobAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    final result = calculateJobRisk(
      website: widget.website,
      recruiterName: widget.recruiterName,
      recruiterPhone: widget.recruiterPhone,
      recruiterEmail: widget.recruiterEmail,
      interviewMethod: widget.interviewMethod,
      paymentRequested: widget.paymentRequested,
    );
    final score = result.score;
    final risk = result.risk;
    final isHighRisk = risk == 'High Risk';
    final isMediumRisk = risk == 'Medium Risk';
    final isSaved = AppData.instance.isJobSaved(
      widget.company,
      widget.jobTitle,
    );

    return AppScaffold(
      title: 'Job Analysis',
      selectedIndex: 1,
      showBack: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isHighRisk ? red : (isMediumRisk ? orange : green),
                  width: 12,
                ),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color:
                      isHighRisk ? red : (isMediumRisk ? orange : green),
                    ),
                  ),
                  const Text('/100'),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Text(
              risk.toUpperCase(),
              style: TextStyle(
                color: isHighRisk ? red : (isMediumRisk ? orange : green),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            CompanyCard(
              company: widget.company,
              verified: !isHighRisk,
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verification Results',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            VerificationItem(
              icon: Icons.business,
              title: 'Company Check',
              subtitle: isHighRisk
                  ? 'Job not found on official careers page'
                  : (isMediumRisk
                  ? 'Could not fully verify the job'
                  : 'Found in official records'),
              danger: isHighRisk || isMediumRisk,
            ),

            VerificationItem(
              icon: Icons.language,
              title: 'Website Check',
              subtitle: isHighRisk
                  ? 'Suspicious domain'
                  : (isMediumRisk
                  ? 'Website needs additional verification'
                  : 'Domain matches company'),
              danger: isHighRisk || isMediumRisk,
            ),

            VerificationItem(
              icon: Icons.email,
              title: 'Recruiter Email',
              subtitle: isHighRisk
                  ? 'Doesn\'t match company domain'
                  : (isMediumRisk
                  ? 'Email could not be fully verified'
                  : 'Uses company domain'),
              danger: isHighRisk || isMediumRisk,
            ),

            VerificationItem(
              icon: Icons.payment,
              title: 'Payment Check',
              subtitle: widget.paymentRequested
                  ? 'Payment requested'
                  : (isMediumRisk
                  ? 'No payment requested, but other warning signals exist'
                  : 'No payment requested'),
              danger: widget.paymentRequested,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  AppData.instance.toggleSavedJob(
                    widget.company,
                    widget.jobTitle,
                    website: widget.website,
                    recruiterName: widget.recruiterName,
                    recruiterPhone: widget.recruiterPhone,
                    recruiterEmail: widget.recruiterEmail,
                    location: widget.location,
                    salary: widget.salary,
                    interviewMethod: widget.interviewMethod,
                    paymentRequested: widget.paymentRequested,
                    risk: risk,
                  );

                  setState(() {});

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isSaved
                            ? 'Job removed from Saved Jobs'
                            : 'Job saved successfully',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(
                  isSaved
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
                label: Text(
                  isSaved ? 'Saved Job' : 'Save Analyzed Job',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REPORT SCAM
// ============================================================

class ReportScamScreen extends StatefulWidget {
  const ReportScamScreen({super.key});

  @override
  State<ReportScamScreen> createState() =>
      _ReportScamScreenState();
}

class _ReportScamScreenState
    extends State<ReportScamScreen> {
  final companyController =
  TextEditingController();

  final detailsController =
  TextEditingController();

  String reason = 'Asked for money';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Report a Scam',
      selectedIndex: 2,
      showBack: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE4E4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.priority_high_rounded,
                color: red,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Report Suspicious Job',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Help the community by reporting fake jobs, recruiters or websites.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textGrey,
              ),
            ),

            const SizedBox(height: 25),

            const FieldTitle(
              'Company / Job Name',
            ),

            AppTextField(
              controller: companyController,
              hint: 'Enter company name',
              icon: Icons.business,
            ),

            const SizedBox(height: 15),

            const FieldTitle(
              'Reason for Report',
            ),

            DropdownButtonFormField<String>(
              value: reason,
              decoration: InputDecoration(
                prefixIcon:
                const Icon(Icons.warning_amber),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Asked for money',
                  child: Text('Asked for money'),
                ),
                DropdownMenuItem(
                  value: 'Fake website',
                  child: Text('Fake website'),
                ),
                DropdownMenuItem(
                  value: 'Fake recruiter',
                  child: Text('Fake recruiter'),
                ),
                DropdownMenuItem(
                  value: 'Personal information requested',
                  child: Text(
                    'Personal information requested',
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  reason = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            const FieldTitle(
              'Additional Details',
            ),

            TextField(
              controller: detailsController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText:
                'e.g. Asked for ₹2,000 registration fee...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            PrimaryButton(
              text: 'Submit Report',
              icon: Icons.send,
              onPressed: submitReport,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SUBMIT REPORT
  // ==========================================================

  void submitReport() {
    final company =
    companyController.text.trim();

    final details =
    detailsController.text.trim();

    if (company.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text('Please enter company / job name'),
        ),
      );
      return;
    }

    if (details.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text('Please enter additional details'),
        ),
      );
      return;
    }

    // SAVE DATA
    AppData.instance.addReport(
      company: company,
      reason: reason,
      details: details,
    );

    // SHOW SUCCESS
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
        Text('Report submitted successfully!'),
        backgroundColor: green,
      ),
    );

    // OPEN REPORT HISTORY
    Future.delayed(
      const Duration(milliseconds: 500),
          () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const ReportHistoryScreen(),
            ),
          );
        }
      },
    );
  }
}

// ============================================================
// REPORT HISTORY
// ============================================================

class ReportHistoryScreen extends StatelessWidget {
  const ReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, child) {
        final reports =
            AppData.instance.reports;

        return AppScaffold(
          title: 'My Reports',
          selectedIndex: 2,
          showBack: true,
          body: reports.isEmpty
              ? const Center(
            child: Text(
              'No reports submitted yet.',
            ),
          )
              : ListView.builder(
            padding:
            const EdgeInsets.all(18),
            itemCount: reports.length,
            itemBuilder:
                (context, index) {
              final report =
              reports[index];

              return ReportHistoryCard(
                report: report,
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================
// REPORT HISTORY CARD
// ============================================================

class ReportHistoryCard extends StatelessWidget {
  final ScamReport report;

  const ReportHistoryCard({
    super.key,
    required this.report,
  });

  Color getRiskColor() {
    if (report.risk == 'High Risk') {
      return red;
    }

    if (report.risk == 'Medium Risk') {
      return orange;
    }

    return green;
  }

  @override
  Widget build(BuildContext context) {
    final color = getRiskColor();

    return Container(
      margin:
      const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color:
          const Color(0xFFE0E6F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                color.withOpacity(0.12),
                child: Icon(
                  Icons.warning,
                  color: color,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  report.company,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                    color: textDark,
                  ),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration:
                BoxDecoration(
                  color:
                  color.withOpacity(0.12),
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: Text(
                  report.risk,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'Reason: ${report.reason}',
            style: const TextStyle(
              color: textDark,
              fontWeight:
              FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            report.details,
            style: const TextStyle(
              color: textGrey,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Reported on ${report.date}',
            style: const TextStyle(
              fontSize: 11,
              color: textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, child) {
        final data = AppData.instance;

        return AppScaffold(
          title: 'Profile',
          selectedIndex: 3,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const SizedBox(height: 15),

                const CircleAvatar(
                  radius: 48,
                  backgroundColor: lightBlue,
                  child: Icon(
                    Icons.person,
                    size: 55,
                    color: primaryBlue,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  registeredFullName.isEmpty
                      ? 'Student'
                      : registeredFullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  registeredEmail.isEmpty
                      ? 'No email registered'
                      : registeredEmail,
                  style: const TextStyle(
                    color: textGrey,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: StatBox(
                        number:
                        '${data.reports.length}',
                        text: 'Reports',
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: StatBox(
                        number:
                        '${data.jobsChecked}',
                        text: 'Jobs Checked',
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: StatBox(
                        number:
                        '${data.savedJobs.length}',
                        text: 'Saved',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // MY REPORTS
                ProfileOption(
                  icon:
                  Icons.description_outlined,
                  title: 'My Reports',
                  trailing:
                  '${data.reports.length}',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const ReportHistoryScreen(),
                      ),
                    );
                  },
                ),

                // SAVED JOBS
                ProfileOption(
                  icon:
                  Icons.bookmark_border,
                  title: 'Saved Jobs',
                  trailing:
                  '${data.savedJobs.length}',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const SavedJobsScreen(),
                      ),
                    );
                  },
                ),

                // SETTINGS
                ProfileOption(
                  icon:
                  Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const SettingsScreen(),
                      ),
                    );
                  },
                ),

                // HELP
                ProfileOption(
                  icon:
                  Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const HelpSupportScreen(),
                      ),
                    );
                  },
                ),

                // ABOUT
                ProfileOption(
                  icon:
                  Icons.info_outline,
                  title: 'About JobVerify',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const AboutScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const LoginScreen(),
                      ),
                          (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                  label: const Text('Logout'),
                  style:
                  OutlinedButton.styleFrom(
                    foregroundColor: red,
                    side: const BorderSide(
                      color: red,
                    ),
                    minimumSize:
                    const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// SAVED JOB DETAIL
// ============================================================

class _SavedJobDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SavedJobDetail({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: primaryBlue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: textGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SAVED JOBS
// ============================================================

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, child) {
        final jobs = AppData.instance.savedJobs;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: darkBlue,
            foregroundColor: Colors.white,
            title: const Text('Saved Jobs'),
          ),
          body: jobs.isEmpty
              ? const Center(
            child: Text(
              'No saved jobs',
              style: TextStyle(
                color: textGrey,
                fontSize: 16,
              ),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.work_outline,
                      color: primaryBlue,
                    ),
                  ),
                  title: Text(
                    job.position.isEmpty
                        ? 'Untitled Job'
                        : job.position,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textDark,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      job.company,
                      style: const TextStyle(color: textGrey),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: job.risk == 'High Risk'
                              ? const Color(0xFFFFE5E5)
                              : (job.risk == 'Medium Risk'
                              ? const Color(0xFFFFF1D6)
                              : const Color(0xFFE5F8EE)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          job.risk,
                          style: TextStyle(
                            color: job.risk == 'High Risk'
                                ? red
                                : (job.risk == 'Medium Risk'
                                ? orange
                                : green),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: textGrey,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SavedJobDetailsScreen(job: job),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================
// SAVED JOB DETAILS
// ============================================================

class SavedJobDetailsScreen extends StatelessWidget {
  final SavedJob job;

  const SavedJobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final bool highRisk = job.risk == 'High Risk';
    final bool mediumRisk = job.risk == 'Medium Risk';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
        title: const Text('Job Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3159DD),
                    Color(0xFF193B9E),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.work_outline,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    job.position.isEmpty ? 'Untitled Job' : job.position,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    job.company,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Job Risk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: highRisk
                    ? const Color(0xFFFFE5E5)
                    : (mediumRisk
                    ? const Color(0xFFFFF1D6)
                    : const Color(0xFFE5F8EE)),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: highRisk ? red : (mediumRisk ? orange : green),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    highRisk || mediumRisk
                        ? Icons.warning_amber_rounded
                        : Icons.verified_user_outlined,
                    color: highRisk ? red : (mediumRisk ? orange : green),
                    size: 30,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.risk,
                          style: TextStyle(
                            color: highRisk ? red : (mediumRisk ? orange : green),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          highRisk
                              ? 'This job showed strong warning signals during analysis.'
                              : (mediumRisk
                              ? 'This job showed some warning signals. Verify the details before proceeding.'
                              : 'No major warning signal was found in the saved analysis.'),
                          style: const TextStyle(
                            color: textGrey,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Complete Job Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 12),

            _JobInfoCard(
              icon: Icons.business_outlined,
              title: 'Company Name',
              value: job.company,
            ),
            _JobInfoCard(
              icon: Icons.language_outlined,
              title: 'Job Website / Link',
              value: job.website,
            ),
            _JobInfoCard(
              icon: Icons.person_outline,
              title: 'Recruiter Name',
              value: job.recruiterName,
            ),
            _JobInfoCard(
              icon: Icons.phone_outlined,
              title: 'Recruiter Phone / WhatsApp',
              value: job.recruiterPhone,
            ),
            _JobInfoCard(
              icon: Icons.email_outlined,
              title: 'Recruiter Email',
              value: job.recruiterEmail,
            ),
            _JobInfoCard(
              icon: Icons.location_on_outlined,
              title: 'Job Location',
              value: job.location,
            ),
            _JobInfoCard(
              icon: Icons.currency_rupee,
              title: 'Salary / Stipend',
              value: job.salary,
            ),
            _JobInfoCard(
              icon: Icons.video_call_outlined,
              title: 'Interview Method',
              value: job.interviewMethod,
            ),
            _JobInfoCard(
              icon: Icons.payment_outlined,
              title: 'Payment Requested?',
              value: job.paymentRequested ? 'Yes' : 'No',
              valueColor: job.paymentRequested ? red : green,
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  AppData.instance.removeSavedJob(
                    AppData.instance.savedJobs.indexOf(job),
                  );
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove from Saved Jobs'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: red,
                  side: const BorderSide(color: red),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const _JobInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value.trim().isEmpty ? 'Not provided' : value;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9E2F2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryBlue, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayValue,
                  style: TextStyle(
                    color: valueColor ?? textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SETTINGS
// ============================================================

class SettingsScreen
    extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  bool notifications = true;
  bool safeMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          SwitchListTile(
            title: const Text(
              'Notifications',
            ),
            subtitle: const Text(
              'Receive safety alerts',
            ),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text(
              'Safe Mode',
            ),
            subtitle: const Text(
              'Show additional scam warnings',
            ),
            value: safeMode,
            onChanged: (value) {
              setState(() {
                safeMode = value;
              });
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.lock_outline,
              color: primaryBlue,
            ),
            title: const Text(
              'Privacy',
            ),
            onTap: () {
              showMessage(
                context,
                'Your information is kept private.',
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.security,
              color: primaryBlue,
            ),
            title: const Text(
              'Security',
            ),
            onTap: () {
              showMessage(
                context,
                'Security settings are active.',
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HELP & SUPPORT
// ============================================================

class HelpSupportScreen
    extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
        title:
        const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'How can we help you?',
            style: TextStyle(
              fontSize: 22,
              fontWeight:
              FontWeight.bold,
              color: textDark,
            ),
          ),

          const SizedBox(height: 20),

          ExpansionTile(
            leading: const Icon(
              Icons.question_answer,
              color: primaryBlue,
            ),
            title: const Text(
              'How does JobVerify work?',
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'JobVerify checks company information, website safety, recruiter email, payment requests and user reports.',
                ),
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(
              Icons.report,
              color: primaryBlue,
            ),
            title: const Text(
              'How can I report a scam?',
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Open Report from the bottom navigation, enter the job details and submit your report.',
                ),
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(
              Icons.security,
              color: primaryBlue,
            ),
            title: const Text(
              'What information should I avoid sharing?',
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Avoid sharing passwords, OTPs, bank details and other sensitive financial information with unknown recruiters.',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          PrimaryButton(
            text: 'Contact Support',
            icon: Icons.email,
            onPressed: () {
              showMessage(
                context,
                'Support request feature opened.',
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ABOUT
// ============================================================

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
        title:
        const Text('About JobVerify'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const Icon(
              Icons.verified_user_rounded,
              size: 90,
              color: primaryBlue,
            ),

            const SizedBox(height: 15),

            const Text(
              'JobVerify',
              style: TextStyle(
                fontSize: 36,
                fontWeight:
                FontWeight.bold,
                color: darkBlue,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Smart Job Scam Detection & Verification App',
              textAlign:
              TextAlign.center,
              style: TextStyle(
                color: textGrey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            const AboutFeature(
              text:
              'Verify Company Information',
            ),

            const AboutFeature(
              text:
              'Check Website / Domain Safety',
            ),

            const AboutFeature(
              text:
              'Validate Recruiter Email',
            ),

            const AboutFeature(
              text:
              'Detect Payment Requests',
            ),

            const AboutFeature(
              text:
              'Consider User Reports',
            ),

            const AboutFeature(
              text:
              'Calculate Risk Score',
            ),

            const AboutFeature(
              text:
              'Stay Safe from Job Scams',
            ),

            const SizedBox(height: 30),

            const Text(
              'Your Career\nOur Priority',
              textAlign:
              TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
                color: primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// APP SCAFFOLD
// ============================================================

class AppScaffold
    extends StatelessWidget {
  final String title;
  final Widget body;
  final int selectedIndex;
  final bool showBack;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.selectedIndex,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
        leading: showBack
            ? IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
            : null,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: body,

      bottomNavigationBar:
      NavigationBar(
        selectedIndex:
        selectedIndex,
        onDestinationSelected:
            (index) {
          Widget page;

          if (index == 0) {
            page =
            const HomeDashboard();
          } else if (index == 1) {
            page =
            const CheckJobScreen();
          } else if (index == 2) {
            page =
            const ReportScamScreen();
          } else {
            page =
            const ProfileScreen();
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        destinations: const [
          NavigationDestination(
            icon:
            Icon(Icons.home_outlined),
            selectedIcon:
            Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon:
            Icon(Icons.search_outlined),
            selectedIcon:
            Icon(Icons.search),
            label: 'Check Job',
          ),
          NavigationDestination(
            icon:
            Icon(Icons.report_outlined),
            selectedIcon:
            Icon(Icons.report),
            label: 'Report',
          ),
          NavigationDestination(
            icon:
            Icon(Icons.person_outline),
            selectedIcon:
            Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REUSABLE TEXT FIELD
// ============================================================

class AppTextField
    extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: primaryBlue,
        ),
        suffixIcon: suffixIcon,
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFD9E1EF),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFD9E1EF),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: primaryBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PRIMARY BUTTON
// ============================================================

class PrimaryButton
    extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon == null
            ? const SizedBox()
            : Icon(icon),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight:
            FontWeight.bold,
          ),
        ),
        style:
        ElevatedButton.styleFrom(
          backgroundColor:
          primaryBlue,
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// FIELD TITLE
// ============================================================

class FieldTitle
    extends StatelessWidget {
  final String text;

  const FieldTitle(
      this.text, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 7,
      ),
      child: Align(
        alignment:
        Alignment.centerLeft,
        child: Text(
          text,
          style:
          const TextStyle(
            fontWeight:
            FontWeight.bold,
            color: textDark,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD CARD
// ============================================================

class DashboardCard
    extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
      BorderRadius.circular(16),
      child: Container(
        padding:
        const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(16),
          border: Border.all(
            color:
            const Color(0xFFE0E6F0),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 42,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign:
              TextAlign.center,
              style:
              const TextStyle(
                fontWeight:
                FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign:
              TextAlign.center,
              style:
              const TextStyle(
                fontSize: 11,
                color: textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HOW WORK
// ============================================================

class HowWorkItem
    extends StatelessWidget {
  final IconData icon;
  final String text;

  const HowWorkItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor:
          lightBlue,
          child: Icon(
            icon,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          text,
          style:
          const TextStyle(
            fontSize: 10,
            color: textGrey,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// COMPANY CARD
// ============================================================

class CompanyCard
    extends StatelessWidget {
  final String company;
  final bool verified;

  const CompanyCard({
    super.key,
    required this.company,
    required this.verified,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(13),
        border: Border.all(
          color:
          const Color(0xFFDDE4F0),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
            lightBlue,
            child: Text(
              company.isEmpty
                  ? 'C'
                  : company[0]
                  .toUpperCase(),
              style:
              const TextStyle(
                color: primaryBlue,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  company,
                  style:
                  const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  verified
                      ? '✓ Verified Company'
                      : '✕ Not Officially Verified',
                  style: TextStyle(
                    color: verified
                        ? green
                        : red,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VERIFICATION ITEM
// ============================================================

class VerificationItem
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool danger;

  const VerificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.danger,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 8,
      ),
      padding:
      const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color:
          const Color(0xFFE0E6F0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color:
            danger ? red : green,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                  const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style:
                  TextStyle(
                    fontSize: 11,
                    color:
                    danger
                        ? red
                        : textGrey,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: textGrey,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE OPTION
// ============================================================

class ProfileOption
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color:
        const Color(0xFFF2F0F8),
        borderRadius:
        BorderRadius.circular(13),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: primaryBlue,
        ),
        title: Text(
          title,
          style:
          const TextStyle(
            fontWeight:
            FontWeight.w600,
            color: textDark,
          ),
        ),
        trailing: Row(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            if (trailing != null)
              Padding(
                padding:
                const EdgeInsets.only(
                  right: 10,
                ),
                child: Text(
                  trailing!,
                  style:
                  const TextStyle(
                    color:
                    primaryBlue,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            const Icon(
              Icons.chevron_right,
              color: textGrey,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STAT BOX
// ============================================================

class StatBox
    extends StatelessWidget {
  final String number;
  final String text;

  const StatBox({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color:
          const Color(0xFFE0E6F0),
        ),
      ),
      child: Column(
        children: [
          Text(
            number,
            style:
            const TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style:
            const TextStyle(
              fontSize: 10,
              color: textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ABOUT FEATURE
// ============================================================

class AboutFeature
    extends StatelessWidget {
  final String text;

  const AboutFeature({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
      const EdgeInsets.only(
        bottom: 12,
      ),
      padding:
      const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(13),
        border: Border.all(
          color:
          const Color(0xFFE0E6F0),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: green,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style:
              const TextStyle(
                fontWeight:
                FontWeight.w600,
                color: textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MESSAGE
// ============================================================

void showMessage(
    BuildContext context,
    String message,
    ) {
  ScaffoldMessenger.of(context)
      .showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
