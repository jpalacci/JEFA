typedef enum token { 

	while_, lparen_, rparen_, lcurly_, rcurly_, if_, else_,
    semicol_, eqass_, or_, and_, eqcomp_, ne_, lt_, le_, gt_, ge_, add_, sub_,
    mul_, div_, mod_, string_t_, int_t_, new_, 
    print_, auto_t, opp_,  true_, false_,int_, string_, id_,acc_, graph_, scan_, min_, concat_, comp_,
    det_,

    //dummy
    toregexp_, root_,
    
    // Non terminals
    file_, statement_, definition_, assignment_,
    type_, expression_, conjunction_, equality_, equop_, relation_, relop_, addition_,
    addop_, term_, mulop_, factor_, unaryop_, primary_, fuint_, fustring_, reint_, restring_, operand_, boperator, no_type_, id_t_
    
} token;

static char * tokens[255] = {"while", "(", ")", "{\n", "}\n", "if", "else", ";\n", "=", "||", "&&", ".equals(", "!", "<", "<=", ">", ">=", "+", "-", "*", "/", "%", "String ", "Integer ", "new ", "syso", "Automaton ","!" , "(new Integer(1).equals(1)) ", "(new Integer(1).equals(0))"};

static char * ids[255];

static token types[255];

static int last_position = 0;

static char new_id_definition;

typedef struct Node_t {
	struct Node_t ** children;
	char * value;
	int index;
	token token;
    token node_type;
} Node;

Node *
new_tree();

void
add_terminal_node(Node * p, token token);

int
set_info(Node * n);

char *
get_info(Node * n);

void
add_node(Node * p, Node * c);

void
print_tree(Node * t);

void
add_terminal_node_with_value(Node * p, token token_, char * value, token node_type);

void 
print_headers();

void
print_program();

void
print_end();

void
set_type(Node * n, token node_type);

token
get_type(Node * n);

