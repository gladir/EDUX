{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/edux)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program QuebQuiz;

Uses Crt,Strings;

Var
 TmpQuestion:String;
 QuestionList:Array[1..255]of Byte;
 I,NumQuestion,P,Good,Bad:Integer;
 Choix:Char;
 ChoixValid:Boolean;

Type
 QuestionRec=Record
  Question:PChar;
  AnswerA,AnswerB,AnswerC,AnswerD:PChar;
  Response:Char;
 End;

Const
 Questions:Array[1..11] of QuestionRec=(
  (Question:'En quel ann‚e le Canada a-t-il ‚t‚ officiellement d‚couvert';
   AnswerA:'1492';
   AnswerB:'1534';
   AnswerC:'1608';
   AnswerD:'1634';
   Response:'B'),
  (Question:'En quel ann‚e la ville de Qu‚bec a-t-elle ‚t‚ fond‚e';
   AnswerA:'1492';
   AnswerB:'1534';
   AnswerC:'1608';
   AnswerD:'1634';
   Response:'C'),
  (Question:'Quel ‚tait le nom de la colonnie avant de s''appeller Qu‚bec';
   AnswerA:'Canada';
   AnswerB:'Nouvelle-France';
   AnswerC:'Nouvelle-Angleterre';
   AnswerD:'Montr‚al';
   Response:'B'),
  (Question:'Qui est le fondateur de la ville de Qu‚bec';
   AnswerA:'Samuel de Champlain';
   AnswerB:'Maisonneuve';
   AnswerC:'Jacque Cartier';
   AnswerD:'Bourassa';
   Response:'A'),
  (Question:'Quel personnage c‚lŠbre cr‚e la Compagnie de la Nouvelle-France en 1627';
   AnswerA:'Samuel de Champlain';
   AnswerB:'Maisonneuve';
   AnswerC:'Le Cardinal de Richelieu';
   AnswerD:'Bourassa';
   Response:'C'),
  (Question:'En quel ann‚e a ‚t‚ fond‚ Trois-RiviŠres';
   AnswerA:'1608';
   AnswerB:'1634';
   AnswerC:'1642';
   AnswerD:'1834';
   Response:'B'),
  (Question:'En quel ann‚e a ‚t‚ fond‚ Montr‚al';
   AnswerA:'1608';
   AnswerB:'1634';
   AnswerC:'1642';
   AnswerD:'1842';
   Response:'C'),
  (Question:'En quel ann‚e le trait‚ de Paris met fin … la Nouvelle-France';
   AnswerA:'1601';
   AnswerB:'1701';
   AnswerC:'1763';
   AnswerD:'1789';
   Response:'C'),
  (Question:'Quel trait‚ met fin … la Nouvelle-France en 1763';
   AnswerA:'Le trait‚ de Fontainebleu';
   AnswerB:'Le trait‚ de Paris';
   AnswerC:'Le trait‚ de Versaille';
   AnswerD:'Le trait‚ de Montr‚al';
   Response:'B'),
  (Question:'Quel roi a mandat‚ Jean Cartier pour trouver le Canada';
   AnswerA:'Francois 1er';
   AnswerB:'Samuel de Champlain';
   AnswerC:'Louis XIV';
   AnswerD:'Louis XV';
   Response:'A'),
  (Question:'Quel fut le dernier gouverneur de la Nouvelle-France';
   AnswerA:'Samuel de Champlain';
   AnswerB:'Michel-Ange Duquesne';
   AnswerC:'Pierre de Rigaud';
   AnswerD:'Jeffery Amherst';
   Response:'D')
 );

BEGIN
 {$IFDEF FPC}
  {$IFDEF WINDOWS}
   SetUseACP(False);
  {$ENDIF}
 {$ENDIF}
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')Then Begin
  WriteLn('QUEBQUIZ - Cette commande permet de passer un QUIZ sur l''histoire du Qu‚bec');
  WriteLn;
  WriteLn('Syntaxe : QUEBQUIZ');
 End
  Else
 Begin
  Randomize;
  NumQuestion:=10;
  Good:=0;
  Bad:=0;
  FillChar(QuestionList,SizeOf(QuestionList),0);
  TmpQuestion[0]:=Chr(High(Questions));
  For I:=1 to 255 do Begin
   TmpQuestion[I]:=Chr(I);
  End;
  For I:=1 to NumQuestion do Begin
   P:=1+Random(Length(TmpQuestion));
   QuestionList[I]:=Byte(TmpQuestion[P]);
   Delete(TmpQuestion,P,1);
  End;
  For I:=1 to NumQuestion do Begin
   ClrScr;
   TextColor(White);
   WriteLn(' ':30,'QUIZ d''histoire du Qu‚bec');
   WriteLn;
   WriteLn('Question (',I,'/',NumQuestion,')');
   TextColor(LightGreen);
   WriteLn('Bonne r‚ponse : ',Good);
   TextColor(LightRed);
   WriteLn('Mauvaise r‚ponse : ',Bad);
   WriteLn;
   TextColor(7);
   WriteLn(StrPas(Questions[QuestionList[I]].Question),' ?');
   WriteLn;
   WriteLn('A) ',StrPas(Questions[QuestionList[I]].AnswerA));
   WriteLn('B) ',StrPas(Questions[QuestionList[I]].AnswerB));
   WriteLn('C) ',StrPas(Questions[QuestionList[I]].AnswerC));
   WriteLn('D) ',StrPas(Questions[QuestionList[I]].AnswerD));
   WriteLn;
   Write('Votre choix : ');
   Repeat
    Choix:=ReadKey;
    ChoixValid:=True;
    Case Choix of
     'A','a':If Questions[QuestionList[I]].Response='A'Then Inc(Good)
                                                       Else Inc(Bad);
     'B','b':If Questions[QuestionList[I]].Response='B'Then Inc(Good)
                                                       Else Inc(Bad);
     'C','c':If Questions[QuestionList[I]].Response='C'Then Inc(Good)
                                                       Else Inc(Bad);
     'D','d':If Questions[QuestionList[I]].Response='D'Then Inc(Good)
                                                       Else Inc(Bad);
     #27:Begin
      TextColor(LightRed);
      WriteLn('Test abandonn‚');
      Halt;
     End;
     Else ChoixValid:=False;
    End;
   Until ChoixValid;
   WriteLn(Choix);
   WriteLn;
  End;
  If Trunc((Good/NumQuestion)*100)>60 Then Begin
   TextColor(LightGreen);
   WriteLn('VOUS AVEZ REUSSIS LE QUIZ !');
   WriteLn('FELICITATION !');
  End
   Else
  Begin
   TextColor(LightRed);
   WriteLn('VOUS AVEZ ECHOUER LE QUIZ !');
  End;
  WriteLn('Vous avez obtenu une note de ',Trunc((Good/NumQuestion)*100),'% !');
  WriteLn('Bonne r‚ponse : ',Good);
  WriteLn('Mauvaise r‚ponse : ',Bad);
 End;
END.
