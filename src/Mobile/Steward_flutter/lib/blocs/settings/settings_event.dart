abstract class SettingsEvent {
  const SettingsEvent();
}

class LoadUserSettings extends SettingsEvent {}

class ChangeDefaultCurrency extends SettingsEvent {
  final String currencyCode;

  ChangeDefaultCurrency({required this.currencyCode});


  List<Object> get props => [currencyCode];
}
