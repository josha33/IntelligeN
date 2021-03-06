unit uNFOUtils;

interface

uses
  // Delphi
  Classes, SysUtils, Generics.Collections, Math,
  // RegExpr
  RegExpr;

type
  TNFOUtils = class
  private
    class function IsAcceptedChar(C: Char; const ASpace: Boolean = True): Boolean;
    class function IsAscii(C: Char): Boolean;
    class function IsLineBreak(C: Char): Boolean;

    class function LastPos(const SubStr, S: string): Integer;

    class function FindFirstNotOf(const SubStr, S: string; const AStartPos: Integer = 1): Integer;
    class function FindLastNotOf(const SubStr, S: string; const AStartPos: Integer = 1): Integer;

    class function TrimRightExactly(const S, SubStr: string): string;
    class function TrimLeftMax(const S, SubStr: string; const AMaximum: Integer = 0): string;

    class function CalculateLeftTrimCount(const ANFO: string; const ARequiredOccurrences: Integer = 5): Integer;

    class function ConvertLeft(const ALine: string): string;

    class function ApplyRegularExpressions(const ANFO: string): string;
  public
    class function AsStrippedText(const ANFO: string; const ARequiredOccurrences: Integer = 5): string;
  end;

implementation

class function TNFOUtils.IsAcceptedChar(C: Char; const ASpace: Boolean = True): Boolean;
begin
  Result := (C in ['A' .. 'Z', 'a' .. 'z', '0' .. '9']) or (ASpace and (C = ' '));
end;

class function TNFOUtils.IsAscii(C: Char): Boolean;
begin
  Result := Integer(C) <= $7F;
end;

class function TNFOUtils.IsLineBreak(C: Char): Boolean;
begin
  Result := Ord(C) in [10, 13];
end;

class function TNFOUtils.LastPos(const SubStr, S: string): Integer;
var
  I, J, K: Integer;
begin
  Result := 0;
  I := Length(S);
  K := Length(SubStr);
  if (K = 0) or (K > I) then
    Exit;
  while (Result = 0) and (I >= K) do
  begin
    J := K;
    if S[I] = SubStr[J] then
    begin
      while (J > 1) and (S[I + J - K - 1] = SubStr[J - 1]) do
        Dec(J);
      if J = 1 then
        Result := I - K + 1;
    end;
    Dec(I);
  end;
end;

class function TNFOUtils.FindFirstNotOf(const SubStr, S: string; const AStartPos: Integer = 1): Integer;
var
  I, LPos: Integer;
begin
  Result := 0;

  if Length(SubStr) = 0 then
  begin
    Result := AStartPos;
    Exit;
  end;

  for I := 1 to Length(S) do
  begin
    LPos := AStartPos + I;
    if (Pos(S[I], SubStr) = 0) then
    begin
      Result := LPos;
      Exit;
    end;
  end;
end;

class function TNFOUtils.FindLastNotOf(const SubStr, S: string; const AStartPos: Integer = 1): Integer;
var
  I, LPos: Integer;
begin
  Result := 0;

  if Length(SubStr) = 0 then
  begin
    Result := AStartPos;
    Exit;
  end;

  for I := Length(S) downto 1 do
  begin
    LPos := AStartPos + I;
    if LastPos(S[I], SubStr) = 0 then
    begin
      Result := LPos;
      Exit;
    end;
  end;
end;

class function TNFOUtils.TrimRightExactly(const S, SubStr: string): string;
var
  I: Integer;
begin
  I := FindLastNotOf(SubStr, S);
  if not(I = 0) then
  begin
    Result := copy(S, 1, I - 1);
  end
  else
  begin
    Result := '';
  end;
end;

class function TNFOUtils.TrimLeftMax(const S, SubStr: string; const AMaximum: Integer = 0): string;
var
  I: Integer;
begin
  I := FindFirstNotOf(SubStr, S);
  if (AMaximum = 0) then
    Result := copy(S, I)
  else
    Result := copy(S, Min(I, AMaximum) - 1);
end;

class function TNFOUtils.CalculateLeftTrimCount(const ANFO: string; const ARequiredOccurrences: Integer = 5): Integer;
var
  LFirstCharacterOccurrence: TDictionary<Integer, Integer>;
  LStringList: TStringList;
  LLineIndex, LFirstCharPos, LKey, LValue, LSmallestKey: Integer;
begin
  Result := 0;

  LFirstCharacterOccurrence := TDictionary<Integer, Integer>.Create();
  try
    LStringList := TStringList.Create;
    try
      LStringList.Text := ANFO;

      for LLineIndex := 1 to LStringList.Count - 1 do
      begin
        LFirstCharPos := FindFirstNotOf(' ', LStringList[LLineIndex]);

        if not(LFirstCharPos = 0) then
        begin
          if (LFirstCharacterOccurrence.ContainsKey(LFirstCharPos)) then
            LFirstCharacterOccurrence.Items[LFirstCharPos] := LFirstCharacterOccurrence.Items[LFirstCharPos] + 1
          else
            LFirstCharacterOccurrence.Add(LFirstCharPos, 1);
        end;
      end;

      LSmallestKey := MaxInt;
      for LKey in LFirstCharacterOccurrence.Keys do
      begin
        LValue := LFirstCharacterOccurrence.Items[LKey];

        if (LKey < LSmallestKey) and (LValue >= ARequiredOccurrences) then
        begin
          LSmallestKey := LKey;
          Result := LKey;
        end;
      end;
    finally
      LStringList.Free;
    end;
  finally
    LFirstCharacterOccurrence.Free;
  end;
end;

class function TNFOUtils.ConvertLeft(const ALine: string): string;
const
  WIDTH = 3;
var
  I, LRightPos: Integer;
begin
  Result := ALine;

  for I := 1 to Length(ALine) - 1 do
  begin
    if not IsAcceptedChar(ALine[I]) then
    begin
      LRightPos := 1;
      while (I < (Length(ALine) - 1 - LRightPos)) and not IsAcceptedChar(ALine[I + LRightPos], False) do
      begin
        Inc(LRightPos);
        if (LRightPos = WIDTH) then
        begin
          Result[I] := ' ';
          break;
        end;
      end;
    end;
  end;
end;

class function TNFOUtils.ApplyRegularExpressions(const ANFO: string): string;
/// The following code is from the iNFekt project + xREL-Team
/// Copyright (C) 2010-2014 syndicode
/// https://github.com/syndicodefront/infekt/blob/master/src/lib/nfo_data.cpp
/// Licenced under GNU GENERAL PUBLIC LICENSE Version 2
var
  LNFO: string;
begin
  LNFO := ANFO;

  with TRegExpr.Create do
    try
      ModifierM := True;

      InputString := LNFO;
      Expression := '^[^a-zA-Z0-9]+$';

      LNFO := Replace(InputString, '', False);
    finally
      Free;
    end;

  with TRegExpr.Create do
    try
      ModifierM := True;

      InputString := LNFO;
      Expression := '^(.)\1+$';

      LNFO := Replace(InputString, '', False);
    finally
      Free;
    end;

  with TRegExpr.Create do
    try
      ModifierM := True;

      InputString := LNFO;
      Expression := '^([\S])\1+\s{3,}(.+?)$';

      LNFO := Replace(InputString, '$2', True);
    finally
      Free;
    end;

  with TRegExpr.Create do
    try
      ModifierM := True;

      InputString := LNFO;
      Expression := '^(.+?)\s{3,}([\S])\2+$';

      LNFO := Replace(InputString, '$1', True);
    finally
      Free;
    end;

  with TRegExpr.Create do
    try
      ModifierM := True;

      InputString := LNFO;
      Expression := '\s+[\\\/:.#_|()\[\]*@=+ \t-]{4,}$'; // modified with 4 instead of 3

      LNFO := Replace(InputString, '', False);
    finally
      Free;
    end;

  with TRegExpr.Create do
    try
      ModifierM := True;

      InputString := LNFO;
      Expression := '^\s*.{1,3}\s*$';

      LNFO := Replace(InputString, '', True);
    finally
      Free;
    end;

  Result := LNFO;
end;

class function TNFOUtils.AsStrippedText(const ANFO: string; const ARequiredOccurrences: Integer = 5): string;
var
  LInitialNFO, LNFO: string;
  LIndex, LBestLeftTrimValue: Integer;
begin
  LInitialNFO := AdjustLineBreaks(ANFO, tlbsLF);

  // Filter for ASCII chars
  // Remove all unneeded spaces at the right side
  for LIndex := 1 to Length(LInitialNFO) do
  begin
    if IsAscii(LInitialNFO[LIndex]) then
    begin
      if IsLineBreak(LInitialNFO[LIndex]) then
      begin
        LNFO := TrimRightExactly(LNFO, ' ');
      end;

      LNFO := LNFO + LInitialNFO[LIndex];
    end
    else
    begin
      LNFO := LNFO + ' ';
    end;
  end;

  LIndex := 1;
  while LIndex < (Length(LNFO)) do
  begin
    if (IsLineBreak(LNFO[LIndex]) and (LIndex < Length(LNFO) - 2) and IsLineBreak(LNFO[LIndex + 1])) then
    begin
      Inc(LIndex, 2);

      while ((LIndex < Length(LNFO)) and IsLineBreak(LNFO[LIndex])) do
      begin
        Delete(LNFO, LIndex, 1);
      end;
    end
    else
    begin
      Inc(LIndex, 1);
    end;
  end;

  LNFO := AdjustLineBreaks(LNFO, tlbsCRLF);

  LNFO := ApplyRegularExpressions(LNFO);

  if (ARequiredOccurrences = 0) then
    LBestLeftTrimValue := MaxInt
  else
    LBestLeftTrimValue := CalculateLeftTrimCount(LNFO, ARequiredOccurrences);

  with TStringList.Create() do
    try
      Text := LNFO;
      for LIndex := 0 to Count - 1 do
      begin
        Strings[LIndex] := ConvertLeft(Strings[LIndex]);

        Strings[LIndex] := TrimLeftMax(Strings[LIndex], ' ', LBestLeftTrimValue);
      end;

      LNFO := Text;
    finally
      Free;
    end;

  LNFO := Trim(LNFO);

  Result := LNFO;
end;

end.
