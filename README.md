Тестовое задание на позицию Flutter

Stack Used: Flutter(Dart), Flutter Bloc (for Managing state)
To run this app on your device, 
--FIRSTLY, you will need to go to https://newsapi.org/ to generate an APIKEY
--SECONDLY, go to the lib\repositories\news_repository.dart
--THIRDLY, add the value of the variable "apiKey" with your newly generated APIKEY, (example, if your generated APIKEY is xxxxxxxxxxxxx, it should look like this: const apiKey = "xxxxxxxxxxxxx";
That's all...You could run your code..

разработчика
Задача
Нужно реализовать функциональность экранов: список новостей и просмотр одной
новости
Функционал
1. При открытии страницы с новостями данные загружаются из моков (по REST в
приоритете, но можно просто из списка)
2. На экране списка новостей должны показываться:
o Карусель с Featured новостями (горизонтальный скролл)
o Список Latest news c последними новостями (вертикальный скролл)
o AppBar с кнопкой Mark all read
3. Кнопка Mark all read при нажатии "читает все записи" помечает все записи, как
прочтенные
4. При нажатии на новость из Featured или Latest news списка должна открыться
страница с подробностями новости (Страница одной новости)
Требования и примечания
1. Логика экранов должна быть организована при помощи BLoC
2. Верстка должна соотвествовать дизайну, но отметку
непрочитанности/прочитанности новости нужно придумать самим
3. Результат работы выложить на github и отправить ссылку в тг @progress_icu
Дополнительное задание:
1. При прокрутке вверх Featured запись схлопывается до размеров новости из списка
Latest news и уходит вместе с ними вверх. Это позволит дать пользователю больше
пространства на экране для просмотра записей


