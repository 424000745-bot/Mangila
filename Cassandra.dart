import 'dart:async';

abstract class Evaluatable {
  void performEvaluation();
}

mixin CertificationLogger {
  void logCertification(String certName) {
    print('  [Mixin Logger] Certification Awarded: $certName');
  }
}

abstract class Student implements Evaluatable {
  String name;
  String studentId;
  
  double _baseScore;

  Student(this.name, this.studentId, double baseScore) : _baseScore = baseScore;

  double get baseScore => _baseScore;

  set baseScore(double newScore) {
    if (newScore >= 0 && newScore <= 100) {
      _baseScore = newScore;
    }
  }

  void displaySummary() {
    print('Student: $name ($studentId) | Base Score: $_baseScore');
  }

  void performEvaluation();
}

class ITStudent extends Student with CertificationLogger {
  String specialization;

  ITStudent(String name, String studentId, double baseScore, this.specialization)
      : super(name, studentId, baseScore);

  void displaySummary() {
    super.displaySummary();
    print('  Track: Information Technology | Specialization: $specialization');
  }

  void performEvaluation() {
    print('  [Evaluation] Reviewing GitHub repository and Dart logic artifacts...');
  }

  Future<String> syncGradesToCloud() async {
    print('  [Cloud API] Initiating connection to NTC Cloud Server for $name...');

    await Future.delayed(const Duration(seconds: 2));
    
    return 'SUCCESS: Academic telemetry for $name successfully synced to server.';
  }
}

class EngineeringStudent extends Student {
  String engineeringField;

  EngineeringStudent(String name, String studentId, double baseScore, this.engineeringField)
      : super(name, studentId, baseScore);

  void displaySummary() {
    super.displaySummary();
    print('  Track: Engineering | Field: $engineeringField');
  }

  void performEvaluation() {
    print('  [Evaluation] Reviewing CAD blueprints and embedded circuits...');
  }
}

double processBatchGrades(List<Student> students, double bonusPoints) {
  try {
    if (students.isEmpty) {
      throw FormatException('ERROR: Student roster cannot be empty!');
    }

    double totalScore = 0;

    for (var student in students) {
      double finalScore = student.baseScore + bonusPoints;
      bool isPassed = finalScore >= 75.0;

      if (isPassed) {
        print('  -> ${student.name}: Final Grade = $finalScore (PASSED)');
      } else {
        print('  -> ${student.name}: Final Grade = $finalScore (FAILED)');
      }

      totalScore += finalScore;
    }

    return totalScore / students.length;
  } catch (e) {

    print('  [HANDLED EXCEPTION] $e');
    return 0.0;
  }
}

void main() async {
  print('====================================================');
  print('   NATIONAL TEACHERS COLLEGE - PC16 MILESTONE 2');
  print('   Dart Logic Practical Exam & Written Walkthrough');
  print('====================================================\n');

  ITStudent student1 = ITStudent('Yana Panogaling', '2026-001', 90.0, 'Mobile Development');
  EngineeringStudent student2 = EngineeringStudent('Cassandra Mangila', '2026-002', 88.0, 'Robotics');

  List<Student> classRoster = [student1, student2];

  print('--- [1. OOP HIERARCHY & POLYMORPHISM DEMO (WEEK 9-10)] ---');
  for (var student in classRoster) {
    student.displaySummary();
    student.performEvaluation(); 
    
    if (student is ITStudent) {
      student.logCertification('Flutter Associate Developer');
    }
    print('');
  }

  print('--- [2. FUNDAMENTALS, LOOPS & TRY/CATCH DEMO (WEEK 7-8)] ---');
  double averageGrade = processBatchGrades(classRoster, 7.5);
  print('Calculated Batch Average: $averageGrade\n');

  print('[Testing Exception Handling with Bad Input]:');
  processBatchGrades([], 5.0);

  print('\n--- [3. ASYNCHRONOUS NON-BLOCKING DEMO (WEEK 11)] ---');
  print('[1] Triggering async syncGradesToCloud() for ${student1.name}...');

  Future<String> cloudTask = student1.syncGradesToCloud();

  print('[2] NON-BLOCKING PROOF: App UI/Console remains active while waiting!');
  print('[3] User can process secondary tasks or render UI uninterrupted.');

  String result = await cloudTask;
  print('[4] RESULT RECEIVED: $result');
  print('====================================================');
}