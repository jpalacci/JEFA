#include <stdio.h>
#include <stdlib.h>
typedef struct Node_t {
	struct Node_t ** children;
	char * info;
	int index;
} Node;

static Node *
new_node(char * info){
	Node * a = (Node *)malloc(sizeof(*a));
	a->info = info;
	a->index = 0;
	a->children = malloc(10 * sizeof(*a->children));
	return a;
}

void
add_node(Node * p, Node * c){
	p->children[p->index++] = c;
}

Node *
new_tree(){
	return new_node(NULL);
}

void
add_terminal_node(Node * p, char * info){
	if(p == NULL)
		return;

	p->children[p->index++] = new_node(info);
}

void
set_info(Node * n, char * new_info){
	n->info = new_info;
}

char *
get_info(Node * n){
	return n->info;
}

void
print_tree(Node * t){
	if(t->index == 0){
		if(t->info == NULL){
			printf("%s\n", "MALO");
		}else{
			printf("%s",t->info );
		}

	}
	for(int i = 0; i < t->index; i++){
		print_tree(t->children[i]);
	}
}