import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:Steward_flutter/widgets/input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker(
      {super.key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime});

  final String? labelText;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final ValueChanged<DateTime>? selectDate;
  final ValueChanged<TimeOfDay>? selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate!(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime!);
    if (picked != null && picked != selectedTime) selectTime!(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? valueStyle = Theme.of(context).textTheme.titleLarge;
    return Theme(
      data: Theme.of(context)
          .copyWith(primaryColor: Theme.of(context).colorScheme.secondary),
      child: Builder(
        builder: (context) => Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: InputDropdown(
                labelText: labelText,
                valueText: DateFormat.yMMMd().format(selectedDate!),
                valueStyle: valueStyle,
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              flex: 3,
              child: InputDropdown(
                valueText: selectedTime!.format(context),
                valueStyle: valueStyle,
                onPressed: () {
                  _selectTime(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
