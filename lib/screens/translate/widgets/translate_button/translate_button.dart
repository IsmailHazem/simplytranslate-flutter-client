import 'package:flutter/material.dart';
import '/data.dart';
import '/simplytranslate.dart' as simplytranslate;

class GoogleTranslateButton extends StatelessWidget {
  const GoogleTranslateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: googleInCtrl.text == ''
          ? null
          : googleInCtrl.text.length <= 5000
              ? () async {
                  FocusScope.of(context).unfocus();
                  isTranslationCanceled = false;
                  setStateOverlord(() => loading = true);
                  try {
                    final translatedText = await simplytranslate.translate(
                      googleInCtrl.text,
                      fromLangVal,
                      toLangVal,
                    );
                    if (!isTranslationCanceled)
                      setStateOverlord(() {
                        googleOutput = translatedText;
                        loading = false;
                      });
                  } catch (_) {
                    setStateOverlord(() => loading = false);
                  }
                }
              : null,
      child: Text(
        i18n().main.translate,
        style: TextStyle(
          fontSize: 18,
          color: theme == Brightness.dark
              ? null
              : googleInCtrl.text == ''
                  ? lightThemeGreyColor
                  : Colors.white,
        ),
      ),
    );
  }
}
