import 'package:equatable/equatable.dart';
import 'package:Steward_flutter/models/models.dart';

abstract class AccountState extends Equatable {
  final String? accountId;

  const AccountState(this.accountId);

  @override
  List<Object> get props => [];
}

class AccountEmpty extends AccountState {
  const AccountEmpty(super.accountId);
}

class AccountLoading extends AccountState {
  const AccountLoading(String super.accountId);
}

class AccountLoaded extends AccountState {
  final Account account;

  AccountLoaded({required this.account}) : super(account.id);
}

class AccountFetchError extends AccountState {
  const AccountFetchError(String super.accountId);
}
