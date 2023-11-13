import 'package:Steward_flutter/utils/rest_client.dart';

abstract class AppServiceBase {
  late RestClient rest;

  AppServiceBase() {
    rest = RestClient();
  }
}
