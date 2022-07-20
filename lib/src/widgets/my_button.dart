part of 'widgets.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final bool isOutline;
  final Function() onPressed;
  final Color textColor;
  final double textSize;

  const MyButton(
      {super.key,
      required this.title,
      this.color = Colors.white,
      this.isOutline = false,
      required this.onPressed,
      this.textSize = 12,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 10.0,
          shadowColor: color.withOpacity(.2),
          primary: color,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      onPressed: onPressed,
      child: title.text
          .size(textSize)
          .buttonText(context)
          .bold
          .color(textColor)
          .make(),
    );
  }
}
