import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isEditing;
  final VoidCallback? onImageTap;

  const ProfileImageWidget({super.key, required this.imageUrl, required this.isEditing, this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
          child: imageUrl.isEmpty ? Icon(Icons.person, size: 60, color: AppColors.primary) : null,
        ),
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                onPressed: onImageTap,
              ),
            ),
          ),
      ],
    );
  }
}
