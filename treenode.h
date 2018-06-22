typedef enum token { 

	while_, lparen_, rparen_, lcurly_, rcurly_, if_, else_,
    semicol_, eqass_, or_, and_, eqcomp_, ne_, lt_, le_, gt_, ge_, add_, sub_,
    mul_, div_, mod_, string_t_, int_t_, new_, 
    print_, auto_t, regexp_t, int_, string_, id_,
    
    // Non terminals
    file_, statement_, definition_, assignment_,
    type_, expression_, conjunction_, equality_, equop_, relation_, relop_, addition_,
    addop_, term_, mulop_, factor_, unaryop_, primary_, fuint_, fustring_, reint_, restring_, operand_, boperator,
    
} token;

static char * tokens[255] = {"while", "(", ")", "{", "}", "if", "else", ";", "=", "||", "&&", ".equals(", "!", "<", "<=", ">", ">", "+", "-", "*", "/", "%", "String ", "Integer ", "new ", "syso", "Automaton ", "RegExp "};


typedef struct Node_t {
	struct Node_t ** children;
	char * value;
	int index;
	token token;
} Node;

Node *
new_tree();

void
add_terminal_node(Node * p, token token);

void
set_info(Node * n);

char *
get_info(Node * n);
void
add_node(Node * p, Node * c);

void
print_tree(Node * t);

void
add_terminal_node_with_value(Node * p, token token, char * value);

void 
print_headers();

void
print_program();

void
print_end();

