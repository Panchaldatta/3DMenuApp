import 'package:flutter/material.dart';
import 'package:menuverse/core/theme/colors.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;

  Category({required this.id, required this.name, required this.icon});
}

class CategorySwitcher extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategoryId;
  final Function(String) onCategorySelected;

  const CategorySwitcher({
    Key? key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedCategoryId;

          return GestureDetector(
            onTap: () => onCategorySelected(category.id),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.neonBlue : AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? AppColors.neonBlue : AppColors.divider,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.neonBlue.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    category.icon,
                    color: isSelected ? Colors.white : Colors.white60,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
