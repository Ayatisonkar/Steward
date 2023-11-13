import 'package:equatable/equatable.dart';
import 'package:Steward_flutter/models/models.dart';

// TODO: need to re-visit filters handling in states
abstract class AccountTransactionsState extends Equatable {
  final GetTransactionsInput? filters;

  const AccountTransactionsState(this.filters);
  @override
  List<Object?> get props => [];
}

class AccountTransactionsEmpty extends AccountTransactionsState {
  const AccountTransactionsEmpty(super.filters);
}

class AccountTransactionsLoading extends AccountTransactionsState {
  const AccountTransactionsLoading(GetTransactionsInput super.filters);
}

class AccountTransactionsLoaded extends AccountTransactionsState {
  final TransactionsResult allAccountTransactions;
  final TransactionsResult filteredAccountTransactions;
  @override
  final GetTransactionsInput? filters;

  const AccountTransactionsLoaded(
      {required this.allAccountTransactions,
      required this.filteredAccountTransactions,
      required this.filters})
      : super(filters);

  @override
  List<Object?> get props =>
      [allAccountTransactions, filteredAccountTransactions, filters];
}

class AccountTransactionsError extends AccountTransactionsState {
  const AccountTransactionsError(GetTransactionsInput super.filters);
}
