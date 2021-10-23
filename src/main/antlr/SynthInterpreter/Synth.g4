grammar Synth;

// @header {
// package SynthInterpreter;
// }

//descriptor capture
synth_params   
    : part_name description
    ;

part_name
    : Identifier Colon NewLine
    ;

description
    : line_list
    ;

single_line
    : assignment 
    | association
    ;


line_list
    : single_line (NewLine single_line)* 
    ;

association
    : Identifier Associate Identifier
    ;

initiator
    : Identifier LPar assignment_list RPar
    ;
 


assignment
    : Identifier '=' Identifier
    | FreqFlag '=' Number
    | WaveFlag '=' Wavetype
    | Identifier '=' initiator
    ;

assignment_list
    : assignment (',' assignment)*
    ;


Wavetype
    : Sinewave
    | TriangleWave
    | Squarewave
    | Sawwave
    ;
    
    
//common tokens
Assign      :       '='                 ;
Associate   :       '->'                ;
Colon       :       ':'                 ;
Comma       :       ','                 ;
LPar        :       '('                 ;
RPar        :       ')'                 ;
Period      :       '.'                 ;
FreqFlag    :       'Freq'              ;
WaveFlag    :       'Wave'              ;
Sinewave    :       'Sine'              ;
Squarewave  :       'Square'            ;
TriangleWave:       'Triangle'          ;
Sawwave     :       'Saw'               ;
WS          :   [ \t\r]+ -> skip        ;
NewLine     :   ['\r'? '\n' | '\r']+    ;
Number      :   [0-9]+                  ;
Identifier  :   [A-Za-z0-9_.]+          ;


