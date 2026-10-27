abstract class Maintainable {
  void performMaintenance();
}

mixin GPSLogger {
  void logCoordinates(double lat, double lng) {
    print('  [GPS Logger] Current Location: ($lat, $lng)');
  }
}

class Vehicle {
  String brand;
  String model;
  double price;

  Vehicle(this.brand, this.model, this.price);

  void displayInfo() {
    print('Vehicle: $brand $model | Price: \$$price');
  }
}

class ElectricCar extends Vehicle with GPSLogger implements Maintainable {
  double batteryCapacity; // in kWh

  ElectricCar(String brand, String model, double price, this.batteryCapacity)
      : super(brand, model, price);

  void displayInfo() {
    super.displayInfo();
    print('  Type: EV | Battery: ${batteryCapacity} kWh');
  }

  @override
  void performMaintenance() {
    print('  [Maintenance] Diagnostics running: Battery health at 98%.');
  }

  Future<String> saveRecordToCloud() async {
    print('  [Cloud Sync] Connecting to remote server for $brand $model...');

    await Future.delayed(const Duration(seconds: 2));

    return 'SUCCESS: Telemetry record for $brand $model saved to cloud database.';
  }
}

class GasCar extends Vehicle implements Maintainable {
  double tankCapacity; // in Liters

  GasCar(String brand, String model, double price, this.tankCapacity)
      : super(brand, model, price);

  void displayInfo() {
    super.displayInfo();
    print('  Type: Gas | Tank Capacity: ${tankCapacity}L');
  }

  void performMaintenance() {
    print('  [Maintenance] Engine oil check and filter replacement completed.');
  }
}

void main() async {
  print('====================================================');
  print('   PC16 WEEK 11: DART ASYNC PROGRAMMING DEMO');
  print('====================================================\n');

  ElectricCar tesla = ElectricCar('Tesla', 'Model 3', 39990.0, 75.0);
  GasCar toyota = GasCar('Toyota', 'Camry', 26400.0, 60.0);

  tesla.displayInfo();
  tesla.performMaintenance();
  tesla.logCoordinates(14.5995, 120.9842);

  print('');
  toyota.displayInfo();
  toyota.performMaintenance();

  print('\n----------------------------------------------------');
  print('[1] Triggering Async Method: tesla.saveRecordToCloud()...');

  Future<String> saveFuture = tesla.saveRecordToCloud();

  print('[2] NON-BLOCKING PROOF: Console/UI continues working during delay!');
  print('[3] User can still click buttons, process data, or render UI...');

  String cloudResult = await saveFuture;

  print('[4] RESULT RECEIVED: $cloudResult');
  print('====================================================');
}