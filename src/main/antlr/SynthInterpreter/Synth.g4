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
    : Identifier Associate memberIdentifier
    ;

initiator
    : Identifier LPar assignment_list RPar
    ;
 
assignment
    : Identifier '=' Identifier
    | poly_assignment
    | FreqFlag '=' Number
    | WaveFlag '=' Wavetype
    | initiator_assignment
    ;


poly_assignment
    : PolyFlag '=' boolid
    ;

initiator_assignment
    : Identifier '=' initiator
    ;

assignment_list
    : assignment (',' assignment)*
    ;

memberIdentifier
    : Identifier Period FreqFlag
    ;

boolid
    : TrueBool
    | FalseBool
    ;

Wavetype
    : Sinewave
    | Trianglewave
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
PolyFlag    :       'Poly'              ;
FreqFlag    :       'Freq'              ;
WaveFlag    :       'Wave'              ;
Sinewave    :       'Sine'              ;
Squarewave  :       'Square'            ;
Trianglewave:       'Triangle'          ;
Sawwave     :       'Saw'               ;
TrueBool    :       'True'              ;
FalseBool   :       'False'             ;
WS          :   [ \t\r]+ -> skip        ;
NewLine     :   ['\r'? '\n' | '\r']+    ;
Number      :       [0-9]+              ;
Identifier  :     [A-Za-z0-9_]+         ;

