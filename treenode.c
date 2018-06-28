#include <stdio.h>
#include <stdlib.h>
#include "treenode.h"
#include <string.h>

static token type;

#define IS_A_UOP(token) (token == comp_ || token == toregexp_ || token == min_ || token == det_)

static Node *
new_node(token token_, char * value, token node_type){
	Node * a = (Node *)malloc(sizeof(*a));
	a->token = token_;
	a->value = value;
	a->index = 0;
	a->children = malloc(10 * sizeof(*a->children));
	a->node_type = node_type;
	return a;
}

void
add_node(Node * p, Node * c){
	p->children[p->index++] = c;
}

Node *
new_tree(){
	return new_node(root_, NULL, no_type_);
}

void
add_terminal_node(Node * p, token token){
	if(p == NULL)
		return;

	p->children[p->index++] = new_node(token, NULL, no_type_);
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
set_type(Node * n, token node_type){
	n->node_type = node_type;
}

token
get_type(Node * n){
	return n->node_type;
}

static int random_names = 1;


void
print_tree(Node * t){
	if(t->index == 0){

		if(set_info(t) == -1){
			exit(1);
		}


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
			t->node_type = auto_t;
			if(t->children[0]->node_type != auto_t || t->children[2]->node_type != auto_t){
				fprintf(stderr, "\n\nError de compilacion: La opereacion 'and' se usa con dos automatas\n");
				exit(1);
			}

		break;

		case or_:

			printf("%s", "BasicOperations.union(");
			print_tree(t->children[0]);
			putchar(',');
			print_tree(t->children[2]);
			printf("%s", ")");
			t->node_type = auto_t;
			if(t->children[0]->node_type != auto_t || t->children[2]->node_type != auto_t){
				fprintf(stderr, "\n\nError de compilacion: La opereacion 'or' se usa con dos automatas\n");
				exit(1);
			}

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

		case graph_:
			printf("%s%d%s","try { graph = new PrintWriter(\"graph" ,random_names++,  ".dot\"); graph.print(" );
			print_tree(t->children[1]);
			printf("%s", ".toDot()); graph.close();} catch(Exception e){}");
			t->node_type = auto_t;
			if(t->children[1]->node_type != auto_t){
				fprintf(stderr, "\n\nError de compilacion: La funcion 'graph' recibe un automata\n");
				exit(1);
			}

		break;

		case print_:
			printf("%s","System.out.println(" );
			print_tree(t->children[1]);
			printf("%s", ")");
			break;

		case toregexp_:
			printf("%s","new RegExp(" );
			print_tree(t->children[1]);
			printf("%s",").toAutomaton()" );
			t->node_type = auto_t;
			if(t->children[1]->node_type != string_t_){
				fprintf(stderr, "\n\nError de compilacion: El operador '_' recibe un automata\n");
				exit(1);
			}			
		break;	

		case scan_:
			
			print_tree(t->children[1]);
			printf("%s", "= scan.nextLine()");

		break;

		case acc_:
			print_tree(t->children[0]);
			printf("%s", ".run(");
			print_tree(t->children[2]);
			printf("%s", ")" );
		break;

		case det_:
			print_tree(t->children[1]);
			printf("%s", ".determinize()");
			if(t->children[1]->node_type != auto_t){
				fprintf(stderr, "\n\nError de compilacion: La opereacion 'det' se usa con un automatas\n");
				exit(1);
			}
		break;

		case comp_:
			print_tree(t->children[1]);
			printf("%s", ".complement()");
		break;

		case min_:
			print_tree(t->children[1]);
			printf("%s", ".minimize()");
			if(t->children[1]->node_type != auto_t){
				fprintf(stderr, "\n\nError de compilacion: El operador 'min' se usa con un automata\n");
				exit(1);
			}
		break;

		case concat_:
			printf("%s", "BasicOperations.concatenate(");
			print_tree(t->children[0]);
			putchar(',');
			print_tree(t->children[2]);
			printf("%s", ")");
			if(t->children[0]->node_type != auto_t || t->children[0]->node_type != auto_t){
				fprintf(stderr, "\n\nError de compilacion: El operador 'concat' se usa con dos automatas\n");
				exit(1);
			}
		break;


		default: 
		{
			for(int i = 0; i < t->index; i++){
				print_tree(t->children[i]);
			}
			if(t->index == 1){
				t->node_type = t->children[0]->node_type;
				return;
			}
		};
	}
	
}

void
print_program(Node * t){
	print_headers();
	print_tree(t);
	print_end();
}

void 
print_headers() {
	char * headers = "import dk.brics.automaton.*;import java.io.PrintWriter;import java.util.Scanner; public class Main { public static void main(String[] args) {";
	printf("%s",headers);
	printf("%s\n","Scanner scan = new Scanner(System.in);");
	printf("%s\n","PrintWriter graph;" );
}

void
print_end() {
	printf("%s\n", "scan.close();");
	printf("%s\n", "}}");
}

//Devuelve 0 si no la encontro 
int
search_variable(char * id){
	for (int i = 0; i < last_position; ++i)
	{
		if(!strcmp(id, ids[i])){
			return i;
		}
	}
	return -1;
}

//devuelve 0 si ya esta definida
int
define_variable(char * id){
	if(search_variable(id) != -1){
		return -1;
	}
	int len = strlen(id);
	ids[last_position] = malloc(len);
	strcpy(ids[last_position], id);
	types[last_position++] = type;
}

int
set_info(Node * t) {

	if(t->token == id_){
		int ret;
		if(new_id_definition){
			ret = define_variable(t->value);
			t->node_type = type;
			if(ret == -1){
				fprintf(stderr, "\n\nError de compilacion: La variable '%s' ya esta definida\n",t->value);
				return -1;
			}	
		} else {
			ret = search_variable(t->value);
			if(ret == -1){
				fprintf(stderr, "\n\nError de compilacion: La variable '%s' se usa y no esta definida\n",t->value);
				return -1;
			}
			t->node_type = types[ret];
		}
		new_id_definition = 0;
		return ret;
	}

	if(t->token == int_) {

		char * text = "new Integer(";
		char * aux = t->value;
		t->value = malloc(strlen(text) + strlen(t->value) + 3);
		sprintf(t->value, "new Integer(%s)", aux);
	}

	if(t->token == int_ || t->token == string_ ) {
		return 1;
	}

	if(t->token == auto_t || t->token == int_t_ || t->token == string_t_ ) {
		type = t->token;
		new_id_definition = 1;
	}



	t->value = tokens[t->token];
	return 1;
}

void
add_terminal_node_with_value(Node * p, token token_, char * value, token node_type) {

	if(p == NULL)
		return;

	p->children[p->index++] = new_node(token_, value, node_type);

}