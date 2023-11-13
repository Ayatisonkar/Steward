abstract class AccountEvent {
  const AccountEvent();
}

class FetchAccount extends AccountEvent {
  final String accountId;

  FetchAccount({required this.accountId});

  @override
  List<Object> get props => [accountId];
}

class RefreshAccount extends AccountEvent {}
