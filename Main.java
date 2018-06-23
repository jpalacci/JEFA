import dk.brics.automaton.*;import java.io.PrintWriter;import java.util.Scanner; public class Main { public static void main(String[] args) {Scanner scan = new Scanner(System.in);
PrintWriter graph;
Automaton m=new RegExp("a|b|z").toAutomaton();
Automaton c=new RegExp("v|w|z").toAutomaton();
System.out.println(m);
System.out.println(c);
System.out.println(BasicOperations.intersection(m,c).run("z"));
try { graph = new PrintWriter("graph1.dot"); graph.print(c.toDot()); graph.close();} catch(Exception e){};
try { graph = new PrintWriter("graph2.dot"); graph.print(m.toDot()); graph.close();} catch(Exception e){};
m.determinize();
try { graph = new PrintWriter("graph3.dot"); graph.print(m.toDot()); graph.close();} catch(Exception e){};
m.minimize();
try { graph = new PrintWriter("graph4.dot"); graph.print(m.toDot()); graph.close();} catch(Exception e){};
m=BasicOperations.concatenate(c,m);
try { graph = new PrintWriter("graph5.dot"); graph.print(m.toDot()); graph.close();} catch(Exception e){};
c=c.complement();
try { graph = new PrintWriter("graph6.dot"); graph.print(c.toDot()); graph.close();} catch(Exception e){};
String s;
System.out.println(c);
Integer a=new Integer(1);
while((new Integer(1).equals(1)) ){
s= scan.nextLine();
System.out.println("Acepta:"+c.run(s));
if((new Integer(1).equals(1)) ){
a=new Integer(0);
}
}
scan.close();
}}
