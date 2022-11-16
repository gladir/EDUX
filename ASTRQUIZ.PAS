{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/edux)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program AstrQuiz;

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
  (Question:'Quel est la troisiŠme planŠte du systŠme solaire en partant du soleil';
   AnswerA:'Venus';
   AnswerB:'Mercure';
   AnswerC:'Terre';
   AnswerD:'Mars';
   Response:'C'),
  (Question:'Quel planŠte possŠde la plus haute montagne du systŠme solaire';
   AnswerA:'Mercure';
   AnswerB:'Venus';
   AnswerC:'Terre (Everest)';
   AnswerD:'Mars (Olympus Mons)';
   Response:'D'),
  (Question:'Quel est la huitiŠme planŠte du systŠme solaire en partant du soleil';
   AnswerA:'Jupiter';
   AnswerB:'Saturne';
   AnswerC:'Uranus';
   AnswerD:'Neptune';
   Response:'D'),
  (Question:'Quel planŠte subit les vents les plus rapides, soit 1931 Km/h';
   AnswerA:'Terre';
   AnswerB:'Jupiter';
   AnswerC:'Saturne';
   AnswerD:'Neptune';
   Response:'D'),
  (Question:'Combien de temps prendre la lumiŠre du soleil pour atteindre la terre';
   AnswerA:'0 secondes';
   AnswerB:'Environ 8 minutes et 15 secondes';
   AnswerC:'Environ 30 minutes et 30 secones';
   AnswerD:'Environ 1 heure';
   Response:'B'),
  (Question:'Combien de temps prend le soleil pour faire une r‚volution complŠte de notre galaxie';
   AnswerA:'24 heures';
   AnswerB:'365 jours';
   AnswerC:'100 ans';
   AnswerD:'250 millions d''ann‚es';
   Response:'D'),
  (Question:'Combien de temps prendre le soleil pour une rotation sur lui-mˆme';
   AnswerA:'24 heures';
   AnswerB:'3 jours';
   AnswerC:'24 jours';
   AnswerD:'25 jours';
   Response:'D'),
  (Question:'Quel est le nom de notre galaxie';
   AnswerA:'AndromŠde';
   AnswerB:'Galaxie';
   AnswerC:'Voie lact‚e';
   AnswerD:'Aucun';
   Response:'C'),
  (Question:'Combien prendre de jours la terre pour faire le tour du soleil';
   AnswerA:'1 jour';
   AnswerB:'180 jours';
   AnswerC:'360 jours';
   AnswerD:'365 jours';
   Response:'D'),
  (Question:'Combien prendre de temps la terre pour une rotation sur elle-mˆme';
   AnswerA:'24 heures';
   AnswerB:'12 heures';
   AnswerC:'1 heure';
   AnswerD:'30 minutes';
   Response:'A'),
  (Question:'Parmi les choix suivants, nomm‚s des galaxies';
   AnswerA:'Pluton, Ceres';
   AnswerB:'Voie lact‚e, AndromŠde';
   AnswerC:'Jupiter, Saturne';
   AnswerD:'Halley, Holmes';
   Response:'B')
 );

BEGIN
 {$IFDEF FPC}
  {$IFDEF WINDOWS}
   SetUseACP(False);
  {$ENDIF}
 {$ENDIF}
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')Then Begin
  WriteLn('ASTRQUIZ - Cette commande permet de passer un QUIZ d''astronomie');
  WriteLn;
  WriteLn('Syntaxe : ASTRQUIZ');
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
   WriteLn(' ':30,'QUIZ d''Astronomie');
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