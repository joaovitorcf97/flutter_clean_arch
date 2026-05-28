import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/di/injector_container.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_state.dart';

class HabitsFormDialog extends StatefulWidget {
  const HabitsFormDialog({super.key});

  @override
  State<HabitsFormDialog> createState() => _HabitsFormDialogState();
}

class _HabitsFormDialogState extends State<HabitsFormDialog> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HabitCubit _habitCubit = sl<HabitCubit>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    await _habitCubit.insertHabit(title);

    if (!mounted) return;
    if (_habitCubit.state.actionErrorMessage == null) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Habit'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(hintText: 'Enter habit title'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Title is required';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        BlocBuilder<HabitCubit, HabitState>(
          bloc: _habitCubit,
          buildWhen: (previous, current) =>
              previous.isSaving != current.isSaving,
          builder: (context, state) {
            return TextButton(
              onPressed: state.isSaving ? null : _submit,
              child: state.isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            );
          },
        ),
      ],
    );
  }
}
