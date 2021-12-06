grammar Synth;
///Grammar File for language Synply for WTM's SD MSc Project @UoG///
// @header {
// package SynthInterpreter;
// }

//Parser rules//
//parser rules act as higher level constructs used to capture certain structures in the input script
//they use the preceding token rules at the bottom of the file to build up these rules.
//descriptor capture
synth_params   
    : part_name description
    ;

//Naming syntax rule
part_name
    : Identifier Colon NewLine
    ;

//Decriptions can be line lists or other unimplimented formats such as single line
description
    : line_list
    ;

//capture rule for lists
line_list
    : single_line (NewLine single_line)* 
    ;

//Lines always fall within one of these two rules
single_line
    : assignment 
    | association
    ;

//Association rule
association
    : Identifier Associate memberIdentifier
    ;

//initiator rule capture
initiator
    : voice_initiator
    | lfo_initiator
    ;

//single initator rule for voice
voice_initiator
    : GenKeyWord LPar assignment_list RPar
    ;

//single initator rule for lfo
lfo_initiator
    : LFOKeyWord LPar assignment_list RPar
    ;

//Assignments are a broad rule, some need their own rule for easy access when parsing.
assignment
    : Identifier '=' Identifier
    | poly_assignment
    | FreqFlag '=' Number
    | WaveFlag '=' Wavetype
    | initiator_assignment
    ;

//poly assignment rule is important to have seperated as it is directly linked to a synth global variable
poly_assignment
    : PolyFlag '=' boolid
    ;

//Usually objects are assigned from their contructors/initations
initiator_assignment
    : Identifier '=' initiator
    ;

//list capture for assignments
assignment_list
    : assignment (',' assignment)*
    ;

//used to access the different modifiable parameters of the generator such as frequency
memberIdentifier
    : Identifier Period FreqFlag
    ;

//simple bool rule
boolid
    : TrueBool
    | FalseBool
    ;

//wavtype token rule, this is a hybrid rule that actually counts as a token and cannot be accessed by the parser.
//it makes getting the string of infomation back easier during parsing when its encapsulated ina  token
Wavetype
    : Sinewave
    | Trianglewave
    | Squarewave
    | Sawwave
    ;


///TokenRules/// 
//order of capture is from top to bottom so if identifier was above number,
//then no numbers would ever be captured as all would be seen as identifiers

//common tokens
Assign      :       '='                 ;
Associate   :       '->'                ;
Colon       :       ':'                 ;
Comma       :       ','                 ;
LPar        :       '('                 ;
RPar        :       ')'                 ;
Period      :       '.'                 ;

//keywords
GenKeyWord  :       'Gen'               ;
LFOKeyWord  :       'LFO'               ;
PolyFlag    :       'Poly'              ;
FreqFlag    :       'Freq'              ;
WaveFlag    :       'Wave'              ;
Sinewave    :       'Sine'              ;
Squarewave  :       'Square'            ;
Trianglewave:       'Triangle'          ;
Sawwave     :       'Saw'               ;

//bool tokens
TrueBool    :       'True'              ;
FalseBool   :       'False'             ;

//WS tokens
WS          :   [ \t\r]+ -> skip        ;
NewLine     :   ['\r'? '\n' | '\r']+    ;

//alphanum
Number      :       [0-9]+              ;
Identifier  :     [A-Za-z0-9_]+         ;

