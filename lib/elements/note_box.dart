import 'package:flutter/material.dart';
import 'package:notely/elements/style.dart';


class NoteBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> tags;
  final String imageUrl;
  final bool isSingleColumn;

  const NoteBox({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.imageUrl,
    required this.isSingleColumn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorlessvisible, // Set the background color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: tags
                        .map((tag) => Chip(
                      label: Text(
                        tag.trim(),
                        style: TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Theme.of(context).secondaryHeaderColor, // Set the tag color
                      labelStyle: TextStyle(color: Colors.white),
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
