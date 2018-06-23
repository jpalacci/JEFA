import dk.brics.automaton.*;import java.io.PrintWriter;import java.util.Scanner; public class Main { public static void main(String[] args) {Scanner scan = new Scanner(System.in);
PrintWriter graph;
Automaton a=new RegExp("a+b+").toAutomaton();
Automaton b=a.complement().complement();
System.out.println(a.equals(b));
scan.close();
}}
