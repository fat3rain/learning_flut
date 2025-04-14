import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  final node1 = Node.Id(1);
  final node2 = Node.Id(2);
  final node3 = Node.Id(3);
  final node4 = Node.Id(4);
  final node5 = Node.Id(5);

  @override
  void initState() {
    super.initState();

    // Добавляем узлы в граф
    graph.addNode(node1);
    graph.addNode(node2);
    graph.addNode(node3);
    graph.addNode(node4);
    graph.addNode(node5);

    // Добавляем связи между узлами
    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3);
    graph.addEdge(node2, node4);
    graph.addEdge(node2, node5);

    // Настройки расположения узлов
    builder
      ..siblingSeparation = (20)
      ..levelSeparation = (30)
      ..subtreeSeparation = (20)
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
          color: Colors.red,
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(300),
          minScale: 0.01,
          maxScale: 5.6,
          child: GraphView(
            animated: true,
            paint: Paint()
              ..strokeWidth = 10
              ..color = Colors.white,
            graph: graph,
            algorithm:
                BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
            builder: (Node node) {
              var id = node.key?.value as int;
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Node $id'),
              );
            },
          ),
        ),
      ),
    );
  }
}
