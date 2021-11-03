import SynthInterpreter.*;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.IOException;

public class main {
    public static void main(String[] args) {
        //var synth_script_path = "C:\\Users\\thorf\\Documents\\JavaWS\\AntlrSynthGrammar\\build\\generated-src\\antlr\\main\\synthexample.syn";
        var synth_script_path = args[0];
        CharStream chars = null;
        try {
            chars = CharStreams.fromFileName(synth_script_path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        var lexer = new SynthLexer(chars);
        var tokens  = new CommonTokenStream(lexer);
        var parser = new SynthParser(tokens);

        var tree = parser.synth_params();
        //SynthPrintVisitor synp = new SynthPrintVisitor();
        //synp.visit(tree);

        SynthJsonVisitor synj = new SynthJsonVisitor(args[1]);
        synj.visit(tree);
        //System.out.print("dad?");
    }
}
