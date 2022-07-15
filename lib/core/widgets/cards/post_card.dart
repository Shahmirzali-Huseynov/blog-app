import 'package:blog_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.title, this.deleteOnTap, this.updateOnTap, this.cardOnTap}) : super(key: key);
  final String title;
  final void Function(BuildContext)? deleteOnTap;
  final void Function(BuildContext)? updateOnTap;
  final void Function()? cardOnTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.35,
        children: [
          SlidableAction(
            flex: 1,
            onPressed: deleteOnTap,
            backgroundColor: const Color(0xFFF34040),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: cardOnTap,
        child: Container(
          height: 100,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: context.paddingSymmetric(0, 20),
          child: Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
