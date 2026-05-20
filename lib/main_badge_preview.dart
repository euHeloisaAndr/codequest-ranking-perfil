import "package:flutter/material.dart";
import "package:ranking_screens/user_model.dart";
import "package:ranking_screens/liga_badge.dart";

void main() {
  runApp(const PreviewApp());
}

class PreviewApp extends StatelessWidget {
  const PreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Liga.values.map((l) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: LigaBadge(liga: l, compact: false),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
