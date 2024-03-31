import 'package:project/services/UserDB_service.dart';
import 'package:project/services/auth.dart';

class HomeController {
  String _username;
  double _training_time;
  double _bmi;
  double _calories;

  var auth;

  HomeController(
      this._username, this._training_time, this._bmi, this._calories,this.auth) {
    UserDBService()
        .getUsername(auth.currentUser!.uid)
        .then((value) => {_username = value ?? "No user Name"});

    UserDBService()
        .getBmi(auth.currentUser!.uid)
        .then((value) => {_bmi = value ?? 0});

    UserDBService()
        .getCalories(auth.currentUser!.uid)
        .then((value) => {_calories = value ?? 0});

    UserDBService()
        .getTime(auth.currentUser!.uid)
        .then((value) => {_training_time = value ?? 0});
  }

  String getUsername() {
    return _username;
  }

  double getTraining() {
    return _training_time;
  }

  double getBMI() {
    return _bmi;
  }

  double getCalories() {
    return _calories;
  }
}
