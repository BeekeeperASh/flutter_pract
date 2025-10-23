import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String imageUrl;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, error) =>
                const CircularProgressIndicator(),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: Colors.pink.shade100,
              child: Icon(icon, size: 64, color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
