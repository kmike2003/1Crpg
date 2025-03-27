﻿#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)   
	РеквезитТекущийИгрок = Параметры.Игрок;
	ПолучитьХарактеристикиИгрока();
	ВывестиТЗ(Элементы.ХарактИгрока,РеквезитХарактеристикиИгрока);
	СоздатьСтартовоеМеню();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиКомандФормы            

#Область МенюВзаимодействия            

&НаСервере
Процедура СоздатьСтартовоеМеню()
	СоздатьКнопкуПоиск();
	СоздатьКнопкуОткрытьИнвентарь();
		
	ДобавитьТекстНаПоле("Вы зашли на луга.");
	ДобавитьТекстНаПоле("Что вы будете делать?");
	ДобавитьТекстНаПоле(" ");
КонецПроцедуры

&НаСервере
Процедура СоздатьМенюСражения()
	ОчиститьГруппу(Элементы.Управление);
	Парам = Новый Структура;
	// вызов из сражения и оповещения для использования предмета
	СоздатьКнопкуАтака();
	СоздатьКнопкуЗащиты();
	СоздатьКнопкуОткрытьИнвентарь();
		
	ДобавитьТекстНаПоле("Вы нашли врага: " + Строка(ТекущийВраг));
	ДобавитьТекстНаПоле("Ваши действия?");
	ДобавитьТекстНаПоле(" ");
КонецПроцедуры

&НаСервере
Процедура СоздатьКнопкуПоиск()
	КомандаПоиска = Команды.Добавить("ПоискСобытия");
	КомандаПоиска.Заголовок = "Поиск";
	КомандаПоиска.Действие = "ПоискСобытия";
	
	ЭлементПоиска = Элементы.Добавить("ПоискСобытия", Тип("КнопкаФормы"),Элементы.Управление);
	ЭлементПоиска.Заголовок = "Поиск";
	ЭлементПоиска.ИмяКоманды = "ПоискСобытия";
КонецПроцедуры

&НаСервере
Процедура СоздатьКнопкуОткрытьИнвентарь()
	Если Команды.Найти("ОткрытьИнвентарь") = Неопределено тогда
		КомандаИнвентаря = Команды.Добавить("ОткрытьИнвентарь");
		КомандаИнвентаря.Заголовок = "Открыть инвентарь";
		КомандаИнвентаря.Действие = "ОткрытьИнвентарь";
		
		ЭлементИнвентаря = Элементы.Добавить("ОткрытьИнвентарь", Тип("КнопкаФормы"),Элементы.Управление);
		ЭлементИнвентаря.Заголовок = "Открыть инвентарь";
		ЭлементИнвентаря.ИмяКоманды = "ОткрытьИнвентарь";           
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СоздатьКнопкуАтака()
	КомандаИнвентаря = Команды.Добавить("Атаковать");
	КомандаИнвентаря.Заголовок = "Атаковать";
	КомандаИнвентаря.Действие = "Атаковать";
	
	ЭлементИнвентаря = Элементы.Добавить("Атаковать", Тип("КнопкаФормы"),Элементы.Управление);
	ЭлементИнвентаря.Заголовок = "Атаковать";
	ЭлементИнвентаря.ИмяКоманды = "Атаковать";	
КонецПроцедуры

&НаСервере
Процедура СоздатьКнопкуЗащиты()
	КомандаИнвентаря = Команды.Добавить("Защита");
	КомандаИнвентаря.Заголовок = "Защищаться";
	КомандаИнвентаря.Действие = "Защита";
	
	ЭлементИнвентаря = Элементы.Добавить("Защита", Тип("КнопкаФормы"),Элементы.Управление);
	ЭлементИнвентаря.Заголовок = "Защищаться";
	ЭлементИнвентаря.ИмяКоманды = "Защита";	
КонецПроцедуры

#КонецОбласти

#Область ПроцедурыОбработкиВзаимодействия
&НаКлиенте
Процедура ПоискСобытия(Команда)
	ПоискСобытияНаСервере();
КонецПроцедуры 

&НаСервере
Процедура ПоискСобытияНаСервере()
	СлучайноеЧисло = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
	ТипСобытия = Перечисления.ТипСобытия.Получить(СлучайноеЧисло.СлучайноеЧисло(0,1));
	ВызватьСобытие(ТипСобытия);
КонецПроцедуры

&НаКлиенте
Процедура Атаковать(Команда)
	поражение = АтаковатьНаСервере();
	если поражение тогда
		Вопрос("фывфыв",РежимДиалогаВопрос.ОК);
		ЭтаФорма.Закрыть();
	КонецЕсли;
КонецПроцедуры

&НаСервере
функция АтаковатьНаСервере()
	УронПоВрагу = ПолучитьУрон(ТекущийВраг);
	ЗдоровьеВрага = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","Здоровье"))[0].Значение);
	ИзменитьЗдоровьеТекущегоВрага(ЗдоровьеВрага, УронПоВрагу);
	
 	ДобавитьТекстНаПоле("Вы нанесли " + Строка(УронПоВрагу) + " урона!");
	ДобавитьТекстНаПоле("У врага осталось " + ЗдоровьеВрага + " здоровья.");
	ДобавитьТекстНаПоле(" ");
	
	
	Если ЗдоровьеВрага <= 0 тогда
		ИтогиСражения(Истина);
		Возврат Ложь;
	КонецЕсли;
	
	УронПоИгроку = ПолучитьУрон();
	ЗдоровьеИгрока = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","Здоровье"))[0].Значение);
	ИзменитьЗдоровьеИгрока(ЗдоровьеИгрока, УронПоИгроку);
	
	ВывестиТз(Элементы.ХарактИгрока, РеквезитХарактеристикиИгрока);
	ВывестиТЗ(Элементы.ОжидаемыеДанные, РеквезитОжидаемыеДанные);
	ВывестиТЗ(Элементы.ХарактВрага,РеквезитХарактеристикиВрага);
	
	ДобавитьТекстНаПоле("Вам нанесли " + Строка(УронПоИгроку) + " урона!");
	ДобавитьТекстНаПоле("У игрока осталось " + ЗдоровьеИгрока + " здоровья.");
	ДобавитьТекстНаПоле(" ");
	
	Если ЗдоровьеИгрока <= 0 тогда
		возврат Истина;
	КонецЕсли;
	возврат ложь;
КонецФункции
&НаКлиенте
Процедура Защита(Команда)
	Сообщить("as");
	//Элементы.Найти(НазваниеХарактеристики + "_" + ИмяГруппы);
КонецПроцедуры


&НаКлиенте
Процедура ОткрытьИнвентарь(Команда)
	Отбор = Новый Структура("Игрок", РеквезитТекущийИгрок);  
	ОткрытьФорму("РегистрНакопления.РегистрПредметов.Форма.ФормаИтогов", Новый Структура("Отбор", Отбор));
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработкаИнтерфейса

&НаСервере
Процедура ОчиститьМенюВыбор()
	для Индекс = 1 по Элементы.Управление.ПодчиненныеЭлементы.Количество() цикл
		Элементы.Удалить(Элементы.Управление.ПодчиненныеЭлементы.Получить(0));
	КонецЦикла;
	для каждого команда из Команды цикл
		Команды.Удалить(команда);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ДобавитьТекстНаПоле(текст)
	ИгровоеПоле.Вставить(ИгровоеПоле.ПолучитьЗакладкуНачала(),текст + Символы.ПС,ТипЭлементаФорматированногоДокумента.Текст);
КонецПроцедуры

&НаСервере
Процедура ОчиститьГруппу(Группа)
	МассивКоманд = Новый Массив;
	Для ИндексЭлемента = 1 по Группа.ПодчиненныеЭлементы.Количество() Цикл
		Элемент = Группа.ПодчиненныеЭлементы.Получить(0);
		Если ТипЗнч(Элемент) = Тип("КнопкаФормы") тогда
			МассивКоманд.Добавить(Элемент.ИмяКоманды);
		КонецЕсли;
		Элементы.Удалить(Группа.ПодчиненныеЭлементы.Получить(0));	
	КонецЦикла;
	Для Каждого Команда из МассивКоманд Цикл
		Команды.Удалить(Команды.Найти(Команда));
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ВывестиТЗ(Группа,ТЗ)
	ОчиститьГруппу(Группа);
	Для Каждого Строка Из ТЗ Цикл
		Попытка
			Название = Строка.Характеристика + "_" + Группа.Имя;
			НоваяНадпись = Элементы.Добавить(Название, Тип("ДекорацияФормы"), Группа);
	        НоваяНадпись.Вид = ВидДекорацииФормы.Надпись;
	        НоваяНадпись.Заголовок = Строка.Характеристика  + ": " + Строка.Значение;
		Исключение
			Сообщить("ошибка в ВывестиТЗ:"+ ОписаниеОшибки());	
		КонецПопытки;			
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПолучениеЛута()
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДропСМоба.Враг КАК Враг,
		|	ДропСМоба.Предмет КАК Предмет,
		|	ДропСМоба.Количество КАК Количество
		|ИЗ
		|	РегистрСведений.ДропСМоба КАК ДропСМоба
		|ГДЕ
		|	ДропСМоба.Враг = &Враг";
	
	Запрос.УстановитьПараметр("Враг", ТекущийВраг);
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	КоличествоПредметовСМоба = Новый Соответствие;
	Предметы = Новый Массив;
	
	Пока РезультатЗапроса.Следующий() Цикл
		Предметы.Добавить(РезультатЗапроса.Предмет);
		КоличествоПредметовСМоба.Вставить(РезультатЗапроса.Предмет,РезультатЗапроса.Количество);
	КонецЦикла;                                                                            
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	РегистрПредметовОстатки.Предмет КАК Предмет,
		|	РегистрПредметовОстатки.КоличествоОстаток КАК Количество
		|ИЗ
		|	РегистрНакопления.РегистрПредметов.Остатки(
		|		,
		|		Игрок = &Игрок
		|		И Предмет В (&Предметы)) КАК РегистрПредметовОстатки";
	
	Запрос.УстановитьПараметр("Игрок", РеквезитТекущийИгрок);
	Запрос.УстановитьПараметр("Предметы", Предметы);
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	КоличествоПредметовВИнвентаре = Новый Соответствие;
	
	
	Пока РезультатЗапроса.Следующий() Цикл
		КоличествоПредметовВИнвентаре.Вставить(РезультатЗапроса.Предмет,РезультатЗапроса.Количество);
	КонецЦикла;
	
	Операция = Документы.Заглушка.СоздатьДокумент();
	Операция.Дата = ТекущаяДата();
	Операция.Игрок = РеквезитТекущийИгрок;
	Операция.Записать(РежимЗаписиДокумента.Запись);
	
	НаборЗаписей = Операция.Движения.РегистрПредметов;
	Для каждого Предмета из КоличествоПредметовСМоба Цикл
		НоваяЗапись = НаборЗаписей.Добавить();
		НоваяЗапись.Период = Операция.Дата;
		НоваяЗапись.Игрок = РеквезитТекущийИгрок;
		НоваяЗапись.Предмет = Предмета.Ключ;
		ДобавитьТекстНаПоле("Вы получили:" + Предмета.Значение + " " + Предмета.Ключ);
		Если РезультатЗапроса.Количество() > 0 и РезультатЗапроса.НайтиСледующий(Новый Структура("Предмет",Предмета.Ключ)) тогда
			КоличествоБыло = РезультатЗапроса.НайтиСледующий("Предмет",Предмета.Ключ);
			НоваяЗапись.Количество = Предмета.Значение + КоличествоБыло;
		Иначе
		    НоваяЗапись.Количество = Предмета.Значение;
		КонецЕсли;
	КонецЦикла;
	НаборЗаписей.Записать();
	
   	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗначениеХарактеристикИгроков.Игрок КАК Игрок,
		|	ЗначениеХарактеристикИгроков.Характеристика КАК Характеристика,
		|	ЗначениеХарактеристикИгроков.Значение КАК Значение
		|ИЗ
		|	РегистрСведений.ЗначениеХарактеристикИгроков КАК ЗначениеХарактеристикИгроков
		|ГДЕ
		|	ЗначениеХарактеристикИгроков.Игрок = &Игрок
		|	И ЗначениеХарактеристикИгроков.Характеристика = &Характеристика";	
	Запрос.УстановитьПараметр("Игрок", РеквезитТекущийИгрок);
	Запрос.УстановитьПараметр("Характеристика", ПланыВидовХарактеристик.ВидыХарактеристикИгроков.НайтиПоНаименованию("Опыт"));	
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	ОпытаБыло = РезультатЗапроса[0].Значение; 
	Опыт = ОпытаБыло + ТекущийВраг.Опыт;
	// сейчас это повышение только уровня а нужно повышать все характеристики
	Если Опыт >= 1000 тогда
		ПовышениеУровня();
		Опыт = Опыт - 1000;
		ДобавитьТекстНаПоле("Вы Получили: " + ТекущийВраг.Опыт + " Опыта!");
	КонецЕсли;
	
	НаборЗаписейХаракт = РегистрыСведений.ЗначениеХарактеристикИгроков.СоздатьНаборЗаписей();
	НаборЗаписейХаракт.Отбор.Характеристика.Установить(РеквезитТекущийИгрок);
	НаборЗаписейХаракт.Отбор.Характеристика.Установить(ПланыВидовХарактеристик.ВидыХарактеристикИгроков.НайтиПоНаименованию("Опыт"));
	НоваяЗаписьХаракт = НаборЗаписейХаракт.Добавить();
	НоваяЗаписьХаракт.Игрок = РеквезитТекущийИгрок;
	НоваяЗаписьХаракт.Характеристика = ПланыВидовХарактеристик.ВидыХарактеристикИгроков.НайтиПоНаименованию("Опыт");
	НоваяЗаписьХаракт.Значение = Опыт;
	НаборЗаписейХаракт.Записать(Истина);      
	ДобавитьТекстНаПоле("Вы Получили: " + ТекущийВраг.Опыт + " Опыта!");
КонецПроцедуры  

&НаСервере
Процедура ПовышениеУровня()
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЗначениеХарактеристикИгроков.Игрок КАК Игрок,
	|	ЗначениеХарактеристикИгроков.Характеристика КАК Характеристика,
	|	ЗначениеХарактеристикИгроков.Значение КАК Значение
	|ИЗ
	|	РегистрСведений.ЗначениеХарактеристикИгроков КАК ЗначениеХарактеристикИгроков
	|ГДЕ
	|	ЗначениеХарактеристикИгроков.Игрок = &Игрок";	
	Запрос.УстановитьПараметр("Игрок", РеквезитТекущийИгрок);
	//Запрос.УстановитьПараметр("Характеристика", ПланыВидовХарактеристик.ВидыХарактеристикИгроков.НайтиПоНаименованию("Уровень"));	
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	ЗначениеПовышения = Новый Соответствие;
	ЗначениеПовышения.Вставить("Сила", 1);
	ЗначениеПовышения.Вставить("Ловкость", 1);
    ЗначениеПовышения.Вставить("Выносливость", 1);
    ЗначениеПовышения.Вставить("Интелект", 1);
    ЗначениеПовышения.Вставить("ЗащитаВЕдиницах", 2);
    ЗначениеПовышения.Вставить("ЗащитаВПроцентах", 1);
    ЗначениеПовышения.Вставить("ШансУворота", 1);
    ЗначениеПовышения.Вставить("МаксСтамина", 5);
    ЗначениеПовышения.Вставить("Стамина", 5);
    ЗначениеПовышения.Вставить("МаксМана", 5);
    ЗначениеПовышения.Вставить("Мана", 5);
    ЗначениеПовышения.Вставить("ФизическийУрон", 5);
    ЗначениеПовышения.Вставить("МагическийУрон", 0);
    ЗначениеПовышения.Вставить("ПробивнойУрон", 2);
	ЗначениеПовышения.Вставить("МаксЗдоровье", 10);
	ЗначениеПовышения.Вставить("Здоровье", 10);
	ЗначениеПовышения.Вставить("Уровень", 1);
	ЗначениеПовышения.Вставить("Внимательность", 1);
	ЗначениеПовышения.Вставить("Удача", 1);
	ЗначениеПослеПовышенияУровня = Новый Соответствие;
	
	НаборЗаписейХаракт = РегистрыСведений.ЗначениеХарактеристикИгроков.СоздатьНаборЗаписей();
	НаборЗаписейХаракт.Отбор.Игрок.Установить(РеквезитТекущийИгрок);
	Для каждого Строка из ЗначениеПовышения Цикл
		ЗначениеХарактБыло = РезультатЗапроса.НайтиСтроки(Новый Структура("Характеристика",ПланыВидовХарактеристик.ВидыХарактеристикИгроков.НайтиПоНаименованию(Строка.Ключ)))[0].Значение;
		ЗначениеХарактСтало = Строка.Значение + ЗначениеХарактБыло;
		НоваяЗаписьХаракт = НаборЗаписейХаракт.Добавить();
		НоваяЗаписьХаракт.Игрок = РеквезитТекущийИгрок;
		НоваяЗаписьХаракт.Характеристика = ПланыВидовХарактеристик.ВидыХарактеристикИгроков.НайтиПоНаименованию(Строка.Ключ);
		НоваяЗаписьХаракт.Значение = ЗначениеХарактСтало;
	КонецЦикла;
	НаборЗаписейХаракт.Записать();      
		
КонецПроцедуры

&НаСервере
Процедура ИтогиСражения(Победа)
	Если Победа Тогда
		ПолучениеЛута();
		ДобавитьТекстНаПоле("Вы Победили!");
		ДобавитьТекстНаПоле(" "); 
		РеквезитХарактеристикиВрага.Очистить();
		ОчиститьГруппу(Элементы.ХарактВрага);
		ОчиститьГруппу(Элементы.ОжидаемыеДанные);
		ТекущийВраг = Неопределено;
		ПолучитьХарактеристикиИгрока(Истина);
		ВывестиТЗ(Элементы.ХарактИгрока, РеквезитХарактеристикиИгрока);
		
		ОчиститьГруппу(Элементы.Управление);
		СоздатьСтартовоеМеню();
	Иначе
		ЭтаФорма.Закрыть();
	КонецЕсли;
КонецПроцедуры      

&НаСервере
Процедура ВызватьСобытие(ТипСобытия)
	Если ТипСобытия = Перечисления.ТипСобытия.ПоискВрагов тогда
		ВыбратьПротивника();
		ПолучитьХарактеристикиСущества(ТекущийВраг);
		ПолучитьОжидаемыеДанные();
		ВывестиТЗ(Элементы.ОжидаемыеДанные, РеквезитОжидаемыеДанные);
		ВывестиТЗ(Элементы.ХарактВрага, РеквезитХарактеристикиВрага);
		СоздатьМенюСражения();
	ИначеЕсли ТипСобытия = Перечисления.ТипСобытия.ПоискПредметов тогда
		
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ВыбратьПротивника()
	СлучайноеЧисло = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
	УровеньИгрока = РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","Уровень"))[0].Значение;
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Враги.Ссылка КАК Ссылка,
		|	Враги.Уровень КАК Уровень
		|ИЗ
		|	Справочник.Враги КАК Враги
		|ГДЕ
		|	Враги.Уровень < &Уровень";
	Запрос.УстановитьПараметр("Уровень", УровеньИгрока + 3);
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();                               
	
	ИндексВрага = СлучайноеЧисло.СлучайноеЧисло(0,РезультатЗапроса.Количество()-1);
	ТекущийВраг = РезультатЗапроса.Получить(ИндексВрага).Ссылка;
КонецПроцедуры

&НаСервере
Процедура ПолучитьХарактеристикиИгрока(ВЛюбомСлучае = Ложь)
	Если РеквезитХарактеристикиИгрока.Количество() = 0 или ВЛюбомСлучае тогда
	    Запрос = Новый Запрос;
	    Запрос.Текст = 
	        "ВЫБРАТЬ
	        |   ЗначениеХарактеристикИгроков.Характеристика КАК Характеристика,
	        |   ЗначениеХарактеристикИгроков.Значение КАК Значение
	        |ИЗ
	        |   РегистрСведений.ЗначениеХарактеристикИгроков КАК ЗначениеХарактеристикИгроков
	        |ГДЕ
	        |   ЗначениеХарактеристикИгроков.Игрок = &Игрок";
	    Запрос.УстановитьПараметр("Игрок", РеквезитТекущийИгрок);
	    Результат = Запрос.Выполнить().Выбрать();
	    
	    РеквезитХарактеристикиИгрока.Очистить();
	    
	    // Заполняем таблицу значений данными из результата запроса
		Если Результат.Количество() > 0 тогда		
		    Пока Результат.Следующий() Цикл
		        НоваяСтрока = РеквезитХарактеристикиИгрока.Добавить();
		        НоваяСтрока.Характеристика = Результат.Характеристика;
		        НоваяСтрока.Значение = Результат.Значение;
		    КонецЦикла;
		КонецЕсли;
		//РеквезитХарактеристикиИгрока.Сдвинуть(14,-14);
		//РеквезитХарактеристикиИгрока.Сдвинуть(12,-11);
		//РеквезитХарактеристикиИгрока.Сдвинуть(13,-11);
		//РеквезитХарактеристикиИгрока.Сдвинуть(14,-11);
		//РеквезитХарактеристикиИгрока.Сдвинуть(8,-4);
		//РеквезитХарактеристикиИгрока.Сдвинуть(9,-4);
    КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПолучитьОжидаемыеДанные()
	РеквезитОжидаемыеДанные.Очистить();
	НоваяСтрока = РеквезитОжидаемыеДанные.Добавить();
	НоваяСтрока.Характеристика = "УронПоВрагу";
	НоваяСтрока.Значение = ПолучитьМинМаксУрон();
	
	НоваяСтрока = РеквезитОжидаемыеДанные.Добавить();
	НоваяСтрока.Характеристика = "УронПоИгроку";
	НоваяСтрока.Значение = ПолучитьМинМаксУрон(ТекущийВраг);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьУрон(Существо = Неопределено)
	СлучайноеЧисло = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
	Если Существо <> неопределено тогда
		ПолучитьХарактеристикиИгрока();
		ФизическийУрон = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ФизическийУрон"))[0].Значение);
		МагическийУрон = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","МагическийУрон"))[0].Значение);
		ПробивнойУрон = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ПробивнойУрон"))[0].Значение);
		ПолучитьХарактеристикиСущества(ТекущийВраг);
	    ЗащитаВЕдиницах = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВЕдиницах"))[0].Значение);
		ЗащитаВПроцентах = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВПроцентах"))[0].Значение);                                                                                             	
	    ИтоговыйУрон = (ФизическийУрон + МагическийУрон + СлучайноеЧисло.СлучайноеЧисло(0,4) - 2) * ((100-ЗащитаВПроцентах)/100) - ЗащитаВЕдиницах + ПробивнойУрон;
		ИтоговыйУрон = ?(ИтоговыйУрон=Цел(ИтоговыйУрон),ИтоговыйУрон, Окр((ИтоговыйУрон+0.5),0));
		Возврат ?(ИтоговыйУрон<0,0,ИтоговыйУрон); 
	Иначе
		ПолучитьХарактеристикиИгрока();
		Урон = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","Урон"))[0].Значение);
		ПолучитьХарактеристикиСущества(ТекущийВраг);
	    ЗащитаВЕдиницах = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВЕдиницах"))[0].Значение);
		ЗащитаВПроцентах = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВПроцентах"))[0].Значение);                                                                                             	
	    ИтоговыйУрон = (урон + СлучайноеЧисло.СлучайноеЧисло(0,4) - 2) * ((100-ЗащитаВПроцентах)/100) - ЗащитаВЕдиницах;
		ИтоговыйУрон = ?(ИтоговыйУрон=Цел(ИтоговыйУрон),ИтоговыйУрон, Окр((ИтоговыйУрон+0.5),0));
		Возврат ?(ИтоговыйУрон<0,0,ИтоговыйУрон);;
	КонецЕсли;
КонецФункции

&НаСервере
Функция ПолучитьМинМаксУрон(Существо = Неопределено)
	СлучайноеЧисло = Новый ГенераторСлучайныхЧисел(ТекущаяУниверсальнаяДатаВМиллисекундах());
	Если Существо <> неопределено тогда
		ПолучитьХарактеристикиИгрока();
		ФизическийУрон = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ФизическийУрон"))[0].Значение);
		МагическийУрон = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","МагическийУрон"))[0].Значение);
		ПробивнойУрон = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ПробивнойУрон"))[0].Значение);
		ПолучитьХарактеристикиСущества(ТекущийВраг);
	    ЗащитаВЕдиницах = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВЕдиницах"))[0].Значение);
		ЗащитаВПроцентах = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВПроцентах"))[0].Значение);                                                                                             	
	    ИтоговыйУрон = (ФизическийУрон + МагическийУрон) * ((100-ЗащитаВПроцентах)/100) - ЗащитаВЕдиницах + ПробивнойУрон;
		ИтоговыйУрон = ?(ИтоговыйУрон=Цел(ИтоговыйУрон),ИтоговыйУрон, Окр((ИтоговыйУрон+0.5),0));
		Возврат ИтоговыйУрон-2 + "-" + ИтоговыйУрон+2; 
	Иначе
		ПолучитьХарактеристикиИгрока();
		Урон = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","Урон"))[0].Значение);
		ПолучитьХарактеристикиСущества(ТекущийВраг);
	    ЗащитаВЕдиницах = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВЕдиницах"))[0].Значение);
		ЗащитаВПроцентах = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","ЗащитаВПроцентах"))[0].Значение);                                                                                             	
	    ИтоговыйУрон = урон * ((100-ЗащитаВПроцентах)/100) - ЗащитаВЕдиницах;
		ИтоговыйУрон = ?(ИтоговыйУрон=Цел(ИтоговыйУрон),ИтоговыйУрон, Окр((ИтоговыйУрон+0.5),0));
		Возврат ИтоговыйУрон-2 + "-" + ИтоговыйУрон+2;
	КонецЕсли;
КонецФункции

&НаСервере
Функция ПолучитьХарактеристикиСущества(Существо)
	Если РеквезитХарактеристикиВрага.Количество() = 0 тогда			
		НоваяСтрока = РеквезитХарактеристикиВрага.Добавить();
	    НоваяСтрока.Характеристика = "Здоровье";
	    НоваяСтрока.Значение = Существо.Здоровье;
		
		НоваяСтрока = РеквезитХарактеристикиВрага.Добавить();
	    НоваяСтрока.Характеристика = "Урон";
	    НоваяСтрока.Значение = Существо.Урон;
		
		НоваяСтрока = РеквезитХарактеристикиВрага.Добавить();
	    НоваяСтрока.Характеристика = "ЗащитаВЕдиницах";
	    НоваяСтрока.Значение = Существо.ЗащитаВЕдиницах;
		
		НоваяСтрока = РеквезитХарактеристикиВрага.Добавить();
	    НоваяСтрока.Характеристика = "ЗащитаВПроцентах";
	    НоваяСтрока.Значение = Существо.ЗащитаВПроцентах;
    КонецЕсли;
КонецФункции

&НаСервере
Процедура ИзменитьЗдоровьеТекущегоВрага(ЗдоровьеВрага = Неопределено, Урон)
	Если ЗдоровьеВрага = Неопределено тогда
		ЗдоровьеВрага = Число(РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","Здоровье"))[0].Значение);	
	КонецЕсли;
	ЗдоровьеВрага = ЗдоровьеВрага - Урон;
    СтрокаЗдоровья = РеквезитХарактеристикиВрага.НайтиСтроки(Новый Структура("Характеристика","Здоровье"))[0];
	ИндексСтрокиЗдоровья = РеквезитХарактеристикиВрага.Индекс(СтрокаЗдоровья);
	РеквезитХарактеристикиВрага.Удалить(ИндексСтрокиЗдоровья);
	НоваяСтрока = РеквезитХарактеристикиВрага.Добавить();
	НоваяСтрока.Характеристика = "Здоровье";
    НоваяСтрока.Значение = ЗдоровьеВрага;
	РеквезитХарактеристикиВрага.Сдвинуть(3,-3);
КонецПроцедуры

&НаСервере
Процедура ИзменитьЗдоровьеИгрока(ЗдоровьеИгрока = Неопределено, Урон = 0)  
	Если ЗдоровьеИгрока = Неопределено тогда
		ЗдоровьеИгрока = Число(РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","Здоровье"))[0].Значение);	
	КонецЕсли;
	ЗдоровьеИгрока = ЗдоровьеИгрока - Урон;
    СтрокаЗдоровья = РеквезитХарактеристикиИгрока.НайтиСтроки(Новый Структура("Характеристика","Здоровье"))[0];
	ИндексСтрокиЗдоровья = РеквезитХарактеристикиИгрока.Индекс(СтрокаЗдоровья);
	РеквезитХарактеристикиИгрока.Удалить(ИндексСтрокиЗдоровья);
	НоваяСтрока = РеквезитХарактеристикиИгрока.Добавить();
	НоваяСтрока.Характеристика = "Здоровье";
    НоваяСтрока.Значение = ЗдоровьеИгрока;
КонецПроцедуры

#КонецОбласти