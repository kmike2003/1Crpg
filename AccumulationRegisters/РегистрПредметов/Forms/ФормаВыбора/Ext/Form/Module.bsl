﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("Игрок") И Параметры.Свойство("Экипировка") тогда               
		РеквизитТекущийИгрок = Параметры.Игрок;                                             
		РеквизитЭкипировка = Параметры.Экипировка;   
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	РегистрПредметовОстатки.Предмет КАК Предмет
			|ИЗ
			|	РегистрНакопления.РегистрПредметов.Остатки(
			|			,
			|			Игрок = &Игрок
			|				И Предмет.ТипПредмета = &Экипировка) КАК РегистрПредметовОстатки";
		
		Запрос.УстановитьПараметр("Игрок", РеквизитТекущийИгрок);
		Запрос.УстановитьПараметр("Экипировка", РеквизитЭкипировка);
		
		РезультатЗапроса = Запрос.Выполнить().Выгрузить();
		Если РезультатЗапроса.Количество() > 0 тогда
			РеквизитСписокПредметов.Загрузить(РезультатЗапроса);
		Иначе
			СтандартнаяОбработка = ложь;
		КонецЕсли;
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СписокПредметовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Закрыть(Элемент.ТекущиеДанные.Предмет);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Закрыть(ПолучитьПустойПредмет());
КонецПроцедуры

&НаСервере
Функция ПолучитьПустойПредмет()
	Возврат Справочники.Предметы.ПустаяСсылка();	
КонецФункции;
