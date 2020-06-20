import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/sticker/sticker.dart';

typedef OnStickerSendCallback = Function(String url);

class StickerPane extends StatelessWidget {
  final OnStickerSendCallback onStickerSend;

  StickerPane({@required this.onStickerSend});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(15),
        height: 150,
        child: BlocBuilder<StickerBloc, StickerState>(
          builder: (context, state) {
            if (state is StickerLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is StickerNotLoaded) {
              return Center(
                child: Text('Could not load sticker'),
              );
            }
            if (state is StickersLoaded) {
              final stickers = state.stickers;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: stickers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onStickerSend(stickers[index].url),
                    child: CachedNetworkImage(
                      imageUrl: stickers[index].url,
                      placeholder: (context, url) => Container(
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
