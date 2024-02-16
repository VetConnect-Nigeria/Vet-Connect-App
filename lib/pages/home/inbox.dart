import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vet_connect/api/file_manager.dart';
import 'package:vet_connect/components/message.dart';
import 'package:vet_connect/components/conversation.dart';
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/functions.dart';
import 'package:vet_connect/misc/providers.dart';
import 'package:vet_connect/misc/widgets.dart';

class InboxPage extends ConsumerStatefulWidget {
  final Conversation conversation;

  const InboxPage({
    super.key,
    required this.conversation,
  });

  @override
  ConsumerState<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends ConsumerState<InboxPage> {
  late String currentUserID;
  final List<Message> messages = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentUserID = ref.read(userProvider).id;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendMessage() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          iconSize: 26.r,
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: AssetImage(widget.conversation.image),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.conversation.header,
                  style: context.textTheme.titleSmall,
                ),
                if (widget.conversation.active) SizedBox(height: 5.h),
                if (widget.conversation.active)
                  Text(
                    "Active",
                    style: context.textTheme.bodySmall,
                  )
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SizedBox(
            width: 375.w,
            height: 800.h,
            child: ColoredBox(
              color: weirdGrey2,
              child: ListView.separated(
                itemBuilder: (_, index) {
                  if (index == messages.length) {
                    return SizedBox(height: 50.h);
                  }

                  return Row(
                    mainAxisAlignment: messages[index].senderID == currentUserID
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: messages[index].senderID == currentUserID
                              ? brightBlue
                              : weirdBlue,
                          image: messages[index].image != null
                              ? DecorationImage(
                                  image: AssetImage(messages[index].image!))
                              : null,
                        ),
                        child: messages[index].text != null
                            ? Column(
                                children: [
                                  Text(
                                    messages[index].text!,
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: messages[index].senderID ==
                                              currentUserID
                                          ? Colors.white
                                          : weirdBlack,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      formatTime(messages[index].timeStamp),
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        color: messages[index].senderID ==
                                                currentUserID
                                            ? Colors.white
                                            : weirdBlack,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : null,
                      )
                    ],
                  );
                },
                separatorBuilder: (_, __) => SizedBox(height: 15.h),
                itemCount: messages.length + 1,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpecialForm(
                controller: controller,
                width: 280.w,
                height: 50.h,
                action: TextInputAction.send,
                onActionPressed: (text) {

                },
              ),
              IconButton(
                onPressed: () {
                  FileManager.multiple(type: FileType.image).then((resp) {
                    if (!mounted) return;
                  });
                },
                icon: const Icon(Icons.image_outlined),
                iconSize: 26.r,
                splashRadius: 20.r,
              )
            ],
          ),
        ),
      ),
    );
  }
}
