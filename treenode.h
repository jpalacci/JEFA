typedef struct Node_t {
	struct Node_t ** children;
	char * info;
	int index;
} Node;

Node *
new_tree();

void
add_terminal_node(Node * p, char * info);

void
set_info(Node * n, char * new_info);

char *
get_info(Node * n);
void
add_node(Node * p, Node * c);

void
print_tree(Node * t);

