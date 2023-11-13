import 'package:equatable/equatable.dart';

abstract class TransactionCommentsEvent extends Equatable {
  const TransactionCommentsEvent();
}

class PostTransactionComment extends TransactionCommentsEvent {
  final String transactionId;
  final String comment;

  const PostTransactionComment({required this.comment, required this.transactionId});

  @override
  List<Object> get props => [transactionId, comment];
}

class LoadTransactionComments extends TransactionCommentsEvent {
  final String transactionId;

  const LoadTransactionComments({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}
