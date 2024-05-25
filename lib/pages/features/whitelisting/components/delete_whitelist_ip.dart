import 'package:flutter/material.dart';
import 'package:forti_grad/widgets/input/delete_button.dart';
import 'package:forti_grad/widgets/spacers.dart';

import '../../../../models/ip_info.dart';

class DeleteExistingWhitelist extends StatefulWidget {
  const DeleteExistingWhitelist(
      {required this.ips, required this.onDelete, super.key});
  final Future<List<IPInfo>> ips;
  final Function(String) onDelete;
  @override
  State<DeleteExistingWhitelist> createState() =>
      _DeleteExistingWhitelistState();
}

class _DeleteExistingWhitelistState extends State<DeleteExistingWhitelist> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VSpacer20(),
        Text(
          "Delete Existing IP",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        const VSpacer20(),
        FutureBuilder(
            future: widget.ips,
            builder: (context, dataSnapshot) {
              if (dataSnapshot.hasData) {
                List<IPInfo>? whiteList = dataSnapshot.data;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: whiteList!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: const Color(0xff2b2b2b),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          hoverColor: Colors.white60,
                          onTap: () {},
                          leading: Text(
                            (index + 1).toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                          title: Text(
                            whiteList[index].ip,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                          trailing: DeleteButton(
                            onTap: () async {
                              await widget.onDelete(whiteList[index].id);
                            },
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    primary: false,
                  ),
                );
              } else if (dataSnapshot.hasError) {
                return Center(
                  child: Text(dataSnapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ],
    );
  }
}
