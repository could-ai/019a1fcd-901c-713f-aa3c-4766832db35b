import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Design App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeDesign {
  final String id;
  final String imageUrl;
  final String title;
  bool isFavorite;

  HomeDesign({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.isFavorite = false,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HomeDesign> _designs = [
    HomeDesign(id: "1", imageUrl: "https://picsum.photos/seed/picsum/400/400", title: "Modern Living Room"),
    HomeDesign(id: "2", imageUrl: "https://picsum.photos/seed/picsum2/400/400", title: "Cozy Bedroom"),
    HomeDesign(id: "3", imageUrl: "https://picsum.photos/seed/picsum3/400/400", title: "Minimalist Kitchen"),
    HomeDesign(id: "4", imageUrl: "https://picsum.photos/seed/picsum4/400/400", title: "Bohemian Patio"),
    HomeDesign(id: "5", imageUrl: "https://picsum.photos/seed/picsum5/400/400", title: "Rustic Dining Area"),
    HomeDesign(id: "6", imageUrl: "https://picsum.photos/seed/picsum6/400/400", title: "Scandinavian Office"),
  ];

  void _toggleFavorite(String id) {
    setState(() {
      final design = _designs.firstWhere((d) => d.id == id);
      design.isFavorite = !design.isFavorite;
    });
  }

  void _addDesign() {
    setState(() {
      final newId = (_designs.length + 1).toString();
      _designs.add(
        HomeDesign(
          id: newId,
          imageUrl: "https://picsum.photos/seed/picsum${newId}/400/400",
          title: "New User Design",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Design Gallery"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.8,
        ),
        itemCount: _designs.length,
        itemBuilder: (context, index) {
          final design = _designs[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    design.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          design.title,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          design.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: design.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleFavorite(design.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDesign,
        tooltip: "Post your design",
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
