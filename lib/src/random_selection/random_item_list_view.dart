import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'selection_item.dart';

/// Displays a list of SelectionItems using a parallax scrolling effect.
class RandomItemListView extends StatelessWidget {
  const RandomItemListView({
    super.key,
    this.items = const [
      SelectionItem(
        1,
        'Random Number',
        'Get Random Number',
        '/randomnumber',
        'https://images.unsplash.com/photo-1509228468518-180dd4864904?w=800',
      ),
      SelectionItem(
        2,
        'Random Dog Video/Image',
        'Get Random Dog',
        '/randomdog',
        'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800',
      ),
      SelectionItem(
        3,
        'Random Cat Image',
        'Get Random Cat',
        '/randomcat',
        'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=800',
      ),
    ],
  });

  static const routeName = '/';

  final List<SelectionItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Things'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'itemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return _ParallaxCard(item: items[index]);
        },
      ),
    );
  }
}

/// A card widget that displays a [SelectionItem] with a parallax background.
class _ParallaxCard extends StatelessWidget {
  const _ParallaxCard({required this.item});

  final SelectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, item.routeName, arguments: item);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                _ParallaxBackground(item: item),
                _buildGradientOverlay(),
                _buildTitleText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.details,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.info,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders the parallax background image for a [_ParallaxCard].
///
/// The background image is shifted vertically based on how far the card is
/// from the centre of the viewport, creating a parallax depth effect.
class _ParallaxBackground extends StatefulWidget {
  const _ParallaxBackground({required this.item});

  final SelectionItem item;

  @override
  State<_ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<_ParallaxBackground> {
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          widget.item.imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return ColoredBox(
              color: Colors.grey.shade300,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return ColoredBox(
              color: Colors.grey.shade400,
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.white, size: 48),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// A [FlowDelegate] that shifts a background image to create a parallax effect.
class _ParallaxFlowDelegate extends FlowDelegate {
  _ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Locate the list item and the scrollable in the render tree.
    final scrollableBox =
        scrollable.context.findRenderObject() as RenderBox?;
    final listItemBox =
        listItemContext.findRenderObject() as RenderBox?;
    if (scrollableBox == null || listItemBox == null) return;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );

    // Map the item's center position to a [0, 1] fraction within the viewport.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Convert the fraction to a vertical alignment value in [-1, 1].
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Calculate the pixel offset for the background image.
    final backgroundSize =
        (backgroundImageKey.currentContext?.findRenderObject() as RenderBox?)
            ?.size;
    if (backgroundSize == null) return;

    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(_ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
