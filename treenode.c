#include <stdio.h>
#include <stdlib.h>
#include "treenode.h"
#include <string.h>

static Node *
new_node(token token, char * value){
	Node * a = (Node *)malloc(sizeof(*a));
	a->token = token;
	a->value = value;
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
	return new_node(NULL, NULL);
}

void
add_terminal_node(Node * p, token token){
	if(p == NULL)
		return;

	p->children[p->index++] = new_node(token, NULL);
}

void
set_value(Node * n, char * new_value){
	n->value = new_value;
}

char *
get_value(Node * n){
	return n->value;
}

void
print_tree(Node * t){
	if(t->index == 0){
		set_info(t);

		if(t->value == NULL){
			printf("%s\n", "MALO");
		}else{
			printf("%s",t->value );
		}

		return;

	}
	switch(t->token){

		case and_:

			printf("%s", "BasicOperations.intersection(");
			print_tree(t->children[0]);
			putchar(',');
			print_tree(t->children[2]);
			printf("%s", ")");

		break;

		case or_:

			printf("%s", "BasicOperations.union(");
			print_tree(t->children[0]);
			putchar(',');
			print_tree(t->children[2]);
			printf("%s", ")");

		break;

		case ne_:
			putchar('!');

			//no pongo break !!

		case eqcomp_:
			print_tree(t->children[0]);
			printf("%s",".equals(");
			print_tree(t->children[2]);
			printf("%s", ")");

		break;

		default: 
		{
			for(int i = 0; i < t->index; i++){
				print_tree(t->children[i]);
			}
		};
	}
	
}
void
print_headers(){

}

void
print_program(Node * t){
	//print_headers();
	print_tree(t);
	//print_end();
}

void
set_info(Node * t) {

	if(t->token == int_) {

		char * text = "new Integer(";
		char * aux = t->value;
		t->value = malloc(strlen(text) + strlen(t->value) + 3);
		sprintf(t->value, "new Integer(%s)", aux);
	}
	if(t->token == int_ || t->token == string_ || t->token == id_) {
		return;
	}


	t->value = tokens[t->token];
}

void
add_terminal_node_with_value(Node * p, token token, char * value) {

	if(p == NULL)
		return;

	p->children[p->index++] = new_node(token, value);

}