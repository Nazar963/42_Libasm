CC = gcc -Wall -Wextra -Werror
NC = nasm -f elf64
CFILES = ft_read.s ft_strcmp.s ft_strcpy.s ft_strdup.s ft_strlen.s ft_write.s
MAINS = main.s
MAINO = main.o
EX = run
AR = ar -rcs
NAME = libasm.a
OFILES = $(CFILES:.s=.o)

all: $(NAME)

$(NAME): $(OFILES)
	$(AR) $@ $^

%.o: %.s
	@$(NC) $< -o $@

compile: $(MAINO) fin

$(MAINO): $(MAINS)
	$(NC) $< -o $@

fin: $(MAINO)
	$(CC) $(MAINO) $(NAME) -o $(EX)

clean:
	@rm -f $(OFILES) $(MAINO)

fclean: clean
	@rm -f $(NAME) $(EX)

re: fclean all compile

.PHONY: all compile fin clean fclean re