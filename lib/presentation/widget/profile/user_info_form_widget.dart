import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class UserInfoFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final bool isEditing;

  const UserInfoFormWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Information',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: nameController,
                label: 'Name',
                icon: Icons.person_outline,
                enabled: isEditing,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                enabled: isEditing,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (label == 'Email' && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
