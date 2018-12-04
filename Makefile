CC	= gcc
CFLAGS	= -c -Wall
LDFLAGS	= -Wall
SOURCES=main.c hello.c
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=hello
DIR= ~/case/
HEAD=hello.h

# Сборка всего проекта
all: hello

clean: ## Приведение проекта в исходное состояние
	rm -vf *~ *.o hello *.tar.gz

# Компиляция объектного модуля main
main.o: main.c hello.h
	$(CC) $(CFLAGS) main.c -o main.o

# Компиляция объектного модуля inout
hello.o: hello.c hello.h
	$(CC) $(CFLAGS) hello.c -o hello.o

# Редактирование связей и сборка программы из объектных модулей
hello: main.o hello.o
	$(CC) $(LDFLAGS) -o hello main.o hello.o

install: ## установка скомпилированного проекта
	install ./$(EXECUTABLE) $(DIR)

uninstall: ## Удаление установленного скомпилированного проекта  проекта
	rm -f $(DIR)/$(EXECUTABLE)

doc: ## сщздание документации
	cat file1 file2 >manual

dist: ## создание дистрибутива проекта
	tar -cvzf $(EXECUTABLE).tar.gz $(SOURCES) $(HEAD)  Makefile manual

help: ## справка об использовании файла сборки
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

wc:
	wc $(SOURCES) $(HEAD)

# "Ложные" целииии
.PHONY: all clean instal dist wc
.DEFAULT:
	@echo "Данной цели не существуетtt. Для справки об использовании файла сборки введите: 'make help'."
