import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:badges/badges.dart' as bg;
import 'package:vet_connect/components/conversation.dart';
import 'package:vet_connect/misc/constants.dart';
import 'package:vet_connect/misc/providers.dart';
import 'package:vet_connect/misc/widgets.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> refresh() async {}

  @override
  Widget build(BuildContext context) {
    List<Conversation> conversations = ref.watch(conversationListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Chats",
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              SpecialForm(
                controller: controller,
                width: 375.w,
                height: 40.h,
                hint: "Search",
                prefix: Icon(Remix.search_line, size: 26.r),
                borderColor: brightBlue,
                radius: BorderRadius.circular(8.r),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              itemBuilder: (_, index) {
                if (index == conversations.length) {
                  return SizedBox(height: 30.h);
                }

                return ListTile(
                  tileColor: brightBlue,
                  onTap: () => context.router.pushNamed(Pages.inbox,
                      extra: conversations[index].userId),
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundImage: AssetImage(conversations[index].image),
                      ),
                      if (conversations[index].active)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: weirdYellow,
                            radius: 5.r,
                          ),
                        )
                    ],
                  ),
                  title: Text(
                    conversations[index].header,
                    style: context.textTheme.titleSmall,
                  ),
                  subtitle: Text(
                    conversations[index].subtitle.substring(0, 25),
                    style: context.textTheme.bodyMedium,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "!8:31",
                        style: context.textTheme.bodySmall,
                      ),
                      if (conversations[index].count > 0)
                        bg.Badge(
                          badgeStyle: const bg.BadgeStyle(
                            badgeColor: appPurple,
                            elevation: 1.0,
                          ),
                          badgeContent: Text(
                            "${conversations[index].count}",
                            style: context.textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
              itemCount: conversations.length + 1,
            ),
          ),
        )
      ],
    );
  }
}
