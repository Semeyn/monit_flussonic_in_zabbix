# Мониторинг сервера Flussonic в Zabbix
## Описание
### Шаблон позвояет:
### 1. Мониторить основные показатели сервера:
* Версия
* Время работы
* Загрузка планировщика
* Загрузка процессора
* Клиент с максимальным количеством потоков (IP клиента)
* Клиент с максимальным количеством потоков (Количество)
* Количество клиентов
* Количество ошибок авторизации
* Количество потоков
* Количество процессов Flussonic
* Скорость входящая
* Скорость исходящая
### 2. Мониторить потоки:
* Статус потока
* Статус записи потока
* Ошибки потока
* Количество клиентов
* URL потока
## Установка
1. Импортируем шаблон Template App Flussonic Service API.xml в Zabbix
2. Добавляем к шаблон к узлу сервера Flussonic
3. Копируем все файлы в каталог /usr/libexec/zabbix-extensions на сервере Flussonic
4. Редактируем параметры мониторинга в файле /usr/libexec/zabbix-extensions/scripts/flussonic.cfg
API_IP=""
API_USER=""
API_PASS=""
5. Создаем символическую ссылку в /etc/cron.d на файл /usr/libexec/zabbix-extensions/flussonic_cron на сервере Flussonic
6. Создаем символическую ссылку в /etc/zabbix/zabbix_agentd.d на файл /usr/libexec/zabbix-extensions/flussonic.conf на сервере Flussonic
(В настройках ZabbixAgent на сервере Flussonic в файле /etc/zabbix/zabbix_agentd.conf должна быть расскоментирована стройка Include=/etc/zabbix/zabbix_agentd.d/*.conf)
7. Перезапускаем ZabbixAgent на сервере Flussonic
8. Ждем минуту проверяем
