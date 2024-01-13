CC = gcc -Wall -Wextra -Werror
NC = nasm -f elf64
CFILES = ft_read.s ft_strcmp.s ft_strcpy.s ft_strdup.s ft_strlen.s ft_write.s
AR = ar -rcs
NAME = libasm.a
OFILES = $(CFILES:.s=.o)

MAN = isalpha isdigit isalnum isascii isprint strlen memset bzero memcpy\
		memmove strlcpy strlcat toupper tolower strchr strrchr strncmp memchr\
		memcmp strnstr atoi calloc strdup substr strjoin strtrim split itoa\
		strmapi striteri putchar_fd putstr_fd putendl_fd putnbr_fd
MANFC = $(addprefix ft_,$(addsuffix .c, $(MAN)))
MANO = $(MANFC:.c=.o)

BON = lstnew lstadd_front lstsize lstlast lstadd_back lstdelone lstclear\
		lstiter lstmap
BONFC = $(addprefix ft_,$(addsuffix .c, $(BON)))
BONO = $(BONFC:.c=.o)

all: $(OFILES) $(NAME)

$(OFILES): $(CFILES)
	$(NC) $(CFILES)

$(NAME): $(MANO)
	$(AR) $(ARF) $@ $^

%.o: %.c
	@$(CC) -c $(CFLAGS) $(INC) $< -o $@

clean:
	@rm -f $(MANO) $(BONO)

fclean: clean
	@rm -f $(NAME)

re: fclean all

bonus:	$(BONO)
	$(AR) $(ARF) $(NAME) $^

.PHONY: bonus all clean fclean re