import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderModel extends StatelessWidget {
  final dynamic order;
  const CustomerOrderModel({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.yellow,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(
              maxHeight: 90,
              maxWidth: double.maxFinite,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 15),
                  constraints: const BoxConstraints(
                    maxWidth: 80,
                    maxHeight: 80,
                  ),
                  child: Image.network(
                    order['orderImage'],
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order['orderName'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${order['orderPrice'].toStringAsFixed(2)}',
                            ),
                            Text(
                              'x ${order['orderqty']}',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('See more..'),
              Text(order['deliveryStatus']),
            ],
          ),
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: order['deliveryStatus'] == 'delivered'
                    ? Colors.brown.withOpacity(0.2)
                    : Colors.yellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:${order['orderName']}',
                      style: const TextStyle(),
                    ),
                    Text(
                      'phone:${order['phone']}',
                      style: const TextStyle(),
                    ),
                    Text(
                      'Email:${order['email']}',
                      style: const TextStyle(),
                    ),
                    Text(
                      'Address:${order['address']}',
                      style: const TextStyle(),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Payment status:',
                          style: TextStyle(),
                        ),
                        Text(
                          '${order['paymentStatus']}',
                          style: const TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Delivery status     :',
                          style: TextStyle(),
                        ),
                        Text(
                          '${order['deliveryStatus']}',
                          style: const TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    order['deliveryStatus'] == 'shipping'
                        ? Text(
                            'Expected delivery date ${DateFormat('yyyy-MM-dd').format(
                            order['deliveryDate'].toDate(),
                          )}')
                        : const Text(' '),
                    order['deliveryStatus'] == 'delivered' &&
                            order['orderReview'] == false
                        ? TextButton(
                            onPressed: () {},
                            child: const Text('Write a review'),
                          )
                        : const Text(' '),
                    order['deliveryStatus'] == 'delivered' &&
                            order['orderReview'] == true
                        ? const Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                              Text(
                                'Review added',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )
                        : const Text(' '),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
