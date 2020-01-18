import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double spendingAmount;
  final double per;

  ChartBar(this.label,this.spendingAmount,this.per);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            //to solve problem : if one value is too large then that perticular bar goes to down 
            //this box makes size of font smaller if content is large
            child: Text('₹${spendingAmount.toStringAsFixed(0)}')
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  color: Color.fromRGBO(220, 220,220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                //fraction size
                heightFactor: per,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  
                ),

              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),

      ],
      
    );
  }
}