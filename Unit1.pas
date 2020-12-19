﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Menus, System.Win.ComObj;

type
  Byte2 = array [0 .. 1] of byte;
  Byte4 = array [0 .. 3] of byte;
  Byte8 = array [0 .. 7] of byte;
  IMDFileType = File OF byte;

  TForm1 = class(TForm)
    OpenBtn: TButton;
    OpenDialog: TOpenDialog;
    TimeTxt: TEdit;
    BPMTxt: TEdit;
    KeyGrid: TStringGrid;
    ShakeBPMBegin: TTimer;
    ShakeBPMEnd: TTimer;
    ShakeChangedBPM: TTimer;
    SaveBtn: TButton;
    SaveDialog: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    BMSInfoMemo: TMemo;
    IsChangeBPM: TCheckBox;
    ChangeFormSize: TTimer;
    ShakeTimeTxt: TTimer;
    ShakeBPMTxt: TTimer;
    OpenInExcel: TButton;
    IMD2txt: TButton;
    KeyMenu: TPopupMenu;
    AddBelow: TMenuItem;
    AddAbove: TMenuItem;
    DeleteLine: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    ReturnToiM: TButton;
    EnterExcelMode: TTimer;
    ExcelMemo: TMemo;
    SaveAsMenu: TPopupMenu;
    SaveAsBtn: TMenuItem;
    HideHint: TCheckBox;
    CopyGrid: TMenuItem;
    PasteGrid: TMenuItem;
    OpenConnecter: TButton;
    Panel3: TPanel;
    CleanBPM: TButton;
    BPMGrid: TStringGrid;
    ChangedBPM: TEdit;
    BPMEnd: TEdit;
    BPMBegin: TEdit;
    BPMChangeBtn: TButton;
    procedure OpenBtnClick(Sender: TObject);
    procedure ReadBMS(FileName: string);
    procedure ReadIMD(FileName: string);
    function ReadByte1: byte;
    function ReadByte2: Byte2;
    function ReadByte4: Byte4;
    function ReadByte8: Byte8;
    procedure WriteByte1(a: byte);
    procedure WriteByte2(a: Byte2);
    procedure WriteByte4(a: Byte4);
    procedure WriteByte8(a: Byte8);
    procedure FormCreate(Sender: TObject);
    function GetBMSNoteTime(BPMNow: double;
      Beat, BeatLength, Grid: integer): integer;
    function BMSTrack2IMD(BMSTrack: integer): integer;
    procedure AddBPM(BeginTime, EndTime: integer; ChangedBPM: double);
    procedure ShakeBPMBeginTimer(Sender: TObject);
    procedure BPMChangeBtnClick(Sender: TObject);
    procedure ShakeBPMEndTimer(Sender: TObject);
    procedure ShakeChangedBPMTimer(Sender: TObject);
    procedure BPMBeginEnter(Sender: TObject);
    procedure BPMBeginExit(Sender: TObject);
    procedure BPMEndEnter(Sender: TObject);
    procedure BPMEndExit(Sender: TObject);
    procedure ChangedBPMEnter(Sender: TObject);
    procedure ChangedBPMExit(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SaveInf;
    procedure SortNote;
    procedure IsChangeBPMClick(Sender: TObject);
    procedure ChangeFormSizeTimer(Sender: TObject);
    procedure CleanBPMClick(Sender: TObject);
    procedure CleanKeyGrid;
    procedure ShakeTimeTxtTimer(Sender: TObject);
    procedure ShakeBPMTxtTimer(Sender: TObject);
    procedure AddAboveClick(Sender: TObject);
    procedure AddBelowClick(Sender: TObject);
    procedure DeleteLineClick(Sender: TObject);
    procedure OpenInExcelClick(Sender: TObject);
    procedure EnterExcelModeTimer(Sender: TObject);
    procedure ReturnToiMClick(Sender: TObject);
    procedure WriteToExcel;
    procedure O1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure SaveAsBtnClick(Sender: TObject);
    procedure HideHintClick(Sender: TObject);
    procedure CopyGridClick(Sender: TObject);
    procedure PasteGridClick(Sender: TObject);
    procedure TimeTxtChange(Sender: TObject);
    procedure OpenConnecterClick(Sender: TObject);
    procedure IMD2txtClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  IMDF: IMDFileType; // IMD File
  IMDGT: integer; // IMD Game Time
  IMDTL: integer; // IMD Time Lines
  IMDBPM: double;
  IMDNL: integer; // IMD Note Lines
  ExcelApp: Variant;
  BPMBeginLeft, BPMEndLeft, ChangedBPMLeft, TimeTxtLeft, BPMTxtLeft: integer;
  BPMBeginShake: integer;
  BPMEndShake: integer;
  ChangedBPMShake: integer;
  WidthAbs, HeightAbs, NowWidth, NowHeight: integer;
  OpenedIMD: string;

const
  ShakeExtent = 10;
  BMSTap = 1;
  BMSHold = 5;
  SIZE = 5000;
  StandardBPM = 120;
  IMDTap = 0;
  IMDSlide = 1;
  IMDHold = 2;

implementation

uses
  Unit2,
  Unit3;

{$R *.dfm}

procedure TForm1.WriteToExcel;
var
  i, j: integer;
  st: string;
begin
  ExcelMemo.Clear;
  for i := 1 to KeyGrid.RowCount - 1 do
  begin
    st := '';
    for j := 1 to 5 do
    begin
      st := st + KeyGrid.Cells[j, i] + #9;
    end;
    ExcelMemo.Lines.Add(st);
    // LoadProcess.Width := Trunc(i / (KeyGrid.RowCount - 1) * 510);
    Application.ProcessMessages;
  end;
  ExcelMemo.SelectAll;
  ExcelMemo.CopyToClipboard;
  ExcelApp.WorkBooks.Add(ExtractFilePath(ParamStr(0)) + 'Simple.xlsx');
  ExcelApp.Visible := True;
  ExcelApp.ActiveSheet.Range['A2'].PasteSpecial;
  // LoadProcess.Width := 0;
end;

procedure TForm1.CleanKeyGrid;
var
  i, j: integer;
begin
  for i := 1 to KeyGrid.RowCount - 1 do
    for j := 0 to 5 do
      KeyGrid.Cells[j, i] := '';
  KeyGrid.RowCount := 2;
end;

procedure TForm1.CopyGridClick(Sender: TObject);
var
  i, j: integer;
  st: string;
begin
  ExcelMemo.Clear;
  for i := 1 to KeyGrid.RowCount - 1 do
  begin
    st := '';
    for j := 1 to 5 do
    begin
      st := st + KeyGrid.Cells[j, i] + #9;
    end;
    ExcelMemo.Lines.Add(st);
    // LoadProcess.Width := Trunc(i / (KeyGrid.RowCount - 1) * 510);
    Application.ProcessMessages;
  end;
  ExcelMemo.SelectAll;
  ExcelMemo.CopyToClipboard;
end;

procedure TForm1.DeleteLineClick(Sender: TObject);
var
  i, j: integer;
begin
  if KeyGrid.RowCount = 2 then
  begin
    for i := 0 to 5 do
      KeyGrid.Cells[i, 1] := '';
    Exit;
  end;
  for i := KeyGrid.Row to KeyGrid.RowCount - 2 do
    for j := 1 to 5 do
      KeyGrid.Cells[j, i] := KeyGrid.Cells[j, i + 1];
  for i := 0 to 5 do
    KeyGrid.Cells[i, KeyGrid.RowCount - 1] := '';
  KeyGrid.RowCount := KeyGrid.RowCount - 1;
end;

var
  EnterExcelModeProcess, NowPanel1Top, NowPanel2Top, PanelTopAbs: integer;
  IsWrite: Boolean;

procedure TForm1.EnterExcelModeTimer(Sender: TObject);
begin
  EnterExcelModeProcess := EnterExcelModeProcess + 2;
  Form1.ClientHeight := NowHeight +
    Trunc(HeightAbs * sin(pi * EnterExcelModeProcess / 200));
  Form1.ClientWidth := NowWidth +
    Trunc(WidthAbs * sin(pi * EnterExcelModeProcess / 200));
  Panel1.Top := NowPanel1Top +
    Trunc(PanelTopAbs * sin(pi * EnterExcelModeProcess / 200));
  Panel2.Top := NowPanel2Top +
    Trunc(PanelTopAbs * sin(pi * EnterExcelModeProcess / 200));
  Panel3.Top := Panel1.Top;
  if EnterExcelModeProcess >= 100 then
  begin
    EnterExcelMode.Enabled := False;
    Form1.Constraints.MaxHeight := Form1.Height;
    Form1.Constraints.MaxWidth := Form1.Width;
    if IsWrite then
      WriteToExcel;
  end;
end;

procedure TForm1.AddAboveClick(Sender: TObject);
var
  i, j: integer;
begin
  KeyGrid.RowCount := KeyGrid.RowCount + 1;
  KeyGrid.Cells[0, KeyGrid.RowCount - 1] := IntToStr(KeyGrid.RowCount - 1);
  for i := KeyGrid.RowCount - 1 downto KeyGrid.Row + 1 do
    for j := 1 to 5 do
      KeyGrid.Cells[j, i] := KeyGrid.Cells[j, i - 1];
  for i := 1 to 5 do
    KeyGrid.Cells[i, KeyGrid.Row] := '';
end;

procedure TForm1.AddBelowClick(Sender: TObject);
var
  i, j: integer;
begin
  KeyGrid.RowCount := KeyGrid.RowCount + 1;
  KeyGrid.Cells[0, KeyGrid.RowCount - 1] := IntToStr(KeyGrid.RowCount - 1);
  for i := KeyGrid.RowCount - 1 downto KeyGrid.Row + 2 do
    for j := 1 to 5 do
      KeyGrid.Cells[j, i] := KeyGrid.Cells[j, i - 1];
  for i := 1 to 5 do
    KeyGrid.Cells[i, KeyGrid.Row + 1] := '';
end;

procedure TForm1.AddBPM(BeginTime: integer; EndTime: integer;
  ChangedBPM: double);
var
  s, t: double;
begin
  s := 60000 / ChangedBPM;
  t := BeginTime;
  while t < EndTime do
  begin
    BPMGrid.Cells[0, BPMGrid.RowCount - 1] := IntToStr(BPMGrid.RowCount - 1);
    BPMGrid.Cells[1, BPMGrid.RowCount - 1] := IntToStr(Trunc(t));
    BPMGrid.Cells[2, BPMGrid.RowCount - 1] := FloatToStr(ChangedBPM);
    t := t + s;
    BPMGrid.RowCount := BPMGrid.RowCount + 1;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BPMGrid.Cells[1, 0] := '时间戳';
  BPMGrid.Cells[2, 0] := 'BPM';
  KeyGrid.Cells[1, 0] := '面条';
  KeyGrid.Cells[2, 0] := '键型';
  KeyGrid.Cells[3, 0] := '时间';
  KeyGrid.Cells[4, 0] := '键位';
  KeyGrid.Cells[5, 0] := '参数';
  BPMBeginLeft := BPMBegin.Left;
  BPMEndLeft := BPMEnd.Left;
  ChangedBPMLeft := ChangedBPM.Left;
  TimeTxtLeft := TimeTxt.Left;
  BPMTxtLeft := BPMTxt.Left;
end;

procedure TForm1.O1Click(Sender: TObject);
begin
  OpenBtnClick(nil);
end;

procedure TForm1.OpenBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    if FileExists(OpenDialog.FileName) then
    begin
      if UpperCase(ExtractFileExt(OpenDialog.FileName)) = '.IMD' then
      begin
        ReadIMD(OpenDialog.FileName);
        OpenedIMD := OpenDialog.FileName;
      end
      else if UpperCase(ExtractFileExt(OpenDialog.FileName)) = '.BMS' then
      begin
        ReadBMS(OpenDialog.FileName);
        SortNote;
        OpenedIMD := '';
      end;
      Form2.Show;
      Form2.TimeLine.Position := Form2.TimeLine.Max;
    end;
end;

procedure TForm1.OpenConnecterClick(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.SortNote;
type
  aa = record
    keynum, time: integer;
  end;
var
  a: array of aa;
  keyarr: array of array [0 .. 4] of integer;
  arrcount: integer;
  i, j, k, l, m: integer;
  t: aa;
  // systime,now:TSystemTime;

  procedure qsort(l, R: integer);
  var
    i, j, m: integer;
  begin
    i := l;
    j := R;
    m := a[(i + j) div 2].time; // 注意：本句不能写成：m:=(i+j) div 2;
    repeat
      while a[i].time < m do
        inc(i);
      while m < a[j].time do
        dec(j); // 降序把这个'<'换成‘>';
      if i <= j then // 注意，是’<=';
      begin
        t := a[i];
        a[i] := a[j];
        a[j] := t;
        inc(i);
        dec(j);
      end;
    until i > j; // 注意，是大于号，不是‘>=’；
    if i < R then
      qsort(i, R);
    if j > l then
      qsort(l, j); // 这两行是递归寻找；
  end;

begin
  // GetSystemTime(systime);
  for m := 1 to KeyGrid.RowCount - 1 do
    if (Trim(KeyGrid.Cells[1, m]) = '') or (Trim(KeyGrid.Cells[2, m]) = '') or
      (Trim(KeyGrid.Cells[3, m]) = '') or (Trim(KeyGrid.Cells[4, m]) = '') or
      (Trim(KeyGrid.Cells[5, m]) = '') then
      Break;

  arrcount := m - 1;
  if arrcount <= 0 then
    Exit;
  SetLength(a, arrcount);
  SetLength(keyarr, arrcount);
  for i := 0 to arrcount - 1 do
    for j := 0 to 4 do
      keyarr[i, j] := StrToInt(KeyGrid.Cells[j + 1, i + 1]);
  k := 0;
  for i := 0 to arrcount - 1 do
  begin
    if keyarr[i, 0] in [0, 6] then
    begin
      a[k].keynum := i;
      a[k].time := keyarr[i, 2];
      k := k + 1;
    end;
  end;
  qsort(0, k - 1);
  for i := 0 to k - 2 do
    for j := i + 1 to k - 1 do
    begin
      if a[i].time <> a[j].time then
        Break;
      if keyarr[a[i].keynum, 3] > keyarr[a[j].keynum, 3] then
      begin
        t := a[i];
        a[i] := a[j];
        a[j] := t;
      end;
    end;
  l := 1;
  for i := 0 to k - 1 do
  begin
    if keyarr[a[i].keynum, 0] = 6 then
    begin
      for j := a[i].keynum to arrcount - 1 do
      begin
        for m := 0 to 4 do
        begin
          KeyGrid.Cells[m + 1, l] := IntToStr(keyarr[j, m]);
        end;
        l := l + 1;
        if keyarr[j, 0] = 10 then
          Break;
      end;
    end
    else
    begin
      for m := 0 to 4 do
      begin
        KeyGrid.Cells[m + 1, l] := IntToStr(keyarr[a[i].keynum, m]);
      end;
      l := l + 1;
    end;
  end;
  // GetSystemTime(now);
  // ShowMessage(IntToStr(now.wMilliseconds-systime.wMilliseconds));
end;

function TForm1.ReadByte1: byte;
begin
  Read(IMDF, Result);
end;

function TForm1.ReadByte2: Byte2;
var
  a: Byte2;
begin
  Read(IMDF, a[0], a[1]);
  Result := a;
end;

function TForm1.ReadByte4: Byte4;
var
  a: Byte4;
begin
  Read(IMDF, a[0], a[1], a[2], a[3]);
  Result := a;
end;

function TForm1.ReadByte8: Byte8;
var
  a: Byte8;
begin
  Read(IMDF, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
  Result := a;
end;

procedure TForm1.ReadIMD(FileName: string);
var
  i: integer;
  m: Short;
  B4: Byte4;
  B8: Byte8;
  IsNoodle: Short;
  NoteType: Short;
  NoteTime: integer;
  NoteTrack: byte;
  NoteParameter: integer;
  LastBPM: double;
  IsChangedBPM_boo: Boolean;
begin
  // 打开文件
  CleanBPMClick(nil);
  CleanKeyGrid;
  AssignFile(IMDF, FileName);
  Reset(IMDF);
  // 读取 IMD Info
  IMDGT := integer(ReadByte4);
  TimeTxt.Text := IntToStr(IMDGT);
  IMDTL := integer(ReadByte4);
  BPMGrid.RowCount := IMDTL + 1;
  IsChangedBPM_boo := False;
  for i := 1 to IMDTL do
  begin
    B4 := ReadByte4;
    B8 := ReadByte8;
    IMDBPM := double(B8);
    with BPMGrid do
    begin
      Cells[0, i] := IntToStr(i);
      Cells[1, i] := IntToStr(integer(B4));
      Cells[2, i] := FloatToStr(IMDBPM);
    end;
    if (i > 1) and (IMDBPM <> LastBPM) then
      IsChangedBPM_boo := True;
    LastBPM := IMDBPM;
  end; // 时间戳
  if IsChangedBPM_boo then
    IsChangeBPM.Checked := True
  else
  begin
    IsChangeBPM.Checked := False;
    BPMTxt.Text := FloatToStr(IMDBPM);
  end;
  // 读取 IMD Info 结束 (03 03)
  ReadByte2;
  // 读取 IMD Note
  IMDNL := integer(ReadByte4);
  KeyGrid.RowCount := IMDNL + 1;
  for i := 1 to IMDNL do
  begin
    m := Short(ReadByte2);
    IsNoodle := m div $10;
    NoteType := m mod $10;
    NoteTime := integer(ReadByte4);
    NoteTrack := ReadByte1;
    NoteParameter := integer(ReadByte4);
    with KeyGrid do
    begin
      Cells[0, i] := IntToStr(i);
      Cells[1, i] := IntToStr(IsNoodle);
      Cells[2, i] := IntToStr(NoteType);
      Cells[3, i] := IntToStr(NoteTime);
      Cells[4, i] := IntToStr(NoteTrack);
      Cells[5, i] := IntToStr(NoteParameter);
    end;
  end; // 按键
  // 关闭文件
  CloseFile(IMDF);
end;

procedure TForm1.WriteByte1(a: byte);
begin
  write(IMDF, a);
end;

procedure TForm1.WriteByte2(a: Byte2);
begin
  write(IMDF, a[0], a[1]);
end;

procedure TForm1.WriteByte4(a: Byte4);
begin
  write(IMDF, a[0], a[1], a[2], a[3]);
end;

procedure TForm1.WriteByte8(a: Byte8);
begin
  write(IMDF, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
end;

procedure TForm1.SaveInf;
var
  i: integer;
  d: double;
  ending: byte;
  IsEmpty: Boolean;
begin
  WriteByte4(Byte4(IMDGT));
  if not IsChangeBPM.Checked then
  begin
    CleanBPMClick(nil);
    AddBPM(0, StrToInt(TimeTxt.Text), StrToFloat(BPMTxt.Text));
  end;
  IsEmpty := False;
  for i := 1 to BPMGrid.RowCount - 1 do
    if (Trim(BPMGrid.Cells[1, i]) = '') or (Trim(BPMGrid.Cells[2, i]) = '') then
    begin
      IsEmpty := True;
      Break;
    end;
  if IsEmpty then
    IMDTL := i - 1
  else
    IMDTL := BPMGrid.RowCount - 1;
  WriteByte4(Byte4(IMDTL));
  for i := 1 to IMDTL do
  begin
    if (Trim(BPMGrid.Cells[1, i]) = '') or (Trim(BPMGrid.Cells[2, i]) = '') then
    begin
      Break;
    end;
    WriteByte4(Byte4(StrToInt(BPMGrid.Cells[1, i])));
    d := StrToFloat(BPMGrid.Cells[2, i]);
    WriteByte8(Byte8(d));
  end;
  ending := 03;
  Write(IMDF, ending, ending);
end;

procedure TForm1.S1Click(Sender: TObject);
begin
  SaveBtnClick(nil);
end;

procedure TForm1.SaveBtnClick(Sender: TObject);
var
  i: integer;
  m: Short;
  IsNoodle: Short;
  NoteCount: integer;
  NoteType: Short;
  NoteTime: integer;
  NoteTrack: byte;
  NoteParameter: integer;
  IsEmpty, IsBreak: Boolean;
begin
  IsBreak := False;
  if not TryStrToInt(Trim(TimeTxt.Text), i) then
  begin
    ShakeTimeTxt.Enabled := True;
    IsBreak := True;
  end;
  if (Trim(BPMTxt.Text) = '') or (not TryStrToInt(Trim(BPMTxt.Text), i) and
    not(BPMTxt.Text = '变速BPM')) or (TryStrToInt(Trim(BPMTxt.Text), i) and
    (i = 0)) then
  begin
    ShakeBPMTxt.Enabled := True;
    IsBreak := True;
  end;
  if IsBreak then
    Exit;

  if OpenedIMD <> '' then
  begin
    if LowerCase(ExtractFileExt(SaveDialog.FileName)) <> '.imd' then
      SaveDialog.FileName := SaveDialog.FileName + '.imd';
    IMDGT := StrToInt(TimeTxt.Text);
    AssignFile(IMDF, SaveDialog.FileName);
    Rewrite(IMDF);
    SaveInf;
    SortNote;
    IsEmpty := False;
    for i := 1 to KeyGrid.RowCount - 1 do
      if (Trim(KeyGrid.Cells[1, i]) = '') or (Trim(KeyGrid.Cells[2, i]) = '') or
        (Trim(KeyGrid.Cells[3, i]) = '') or (Trim(KeyGrid.Cells[4, i]) = '') or
        (Trim(KeyGrid.Cells[5, i]) = '') then
      begin
        IsEmpty := True;
        Break;
      end;
    if IsEmpty then
      NoteCount := i - 1
    else
      NoteCount := KeyGrid.RowCount - 1;
    WriteByte4(Byte4(NoteCount));
    for i := 1 to NoteCount do
    begin
      if (Trim(KeyGrid.Cells[1, i]) = '') or (Trim(KeyGrid.Cells[2, i]) = '') or
        (Trim(KeyGrid.Cells[3, i]) = '') or (Trim(KeyGrid.Cells[4, i]) = '') or
        (Trim(KeyGrid.Cells[5, i]) = '') then
        Break;
      m := StrToInt(Trim(KeyGrid.Cells[1, i])) * 16 +
        StrToInt(Trim(KeyGrid.Cells[2, i]));
      NoteTime := StrToInt(Trim(KeyGrid.Cells[3, i]));
      NoteTrack := StrToInt(Trim(KeyGrid.Cells[4, i]));
      NoteParameter := StrToInt(Trim(KeyGrid.Cells[5, i]));
      WriteByte2(Byte2(m));
      WriteByte4(Byte4(NoteTime));
      WriteByte1(NoteTrack);
      WriteByte4(Byte4(NoteParameter));
    end;
    CloseFile(IMDF);
  end
  else if (SaveDialog.Execute) then
  begin
    if (SaveDialog.FileName <> '') then
    begin
      if LowerCase(ExtractFileExt(SaveDialog.FileName)) <> '.imd' then
        SaveDialog.FileName := SaveDialog.FileName + '.imd';
      if FileExists(SaveDialog.FileName) then
        if MessageBox(Form1.Handle,
          PWideChar('“' + SaveDialog.FileName + '”已存在，是否覆盖？'), '不要在意标题',
          MB_YesNo + MB_iconQuestion) = idNo then
          Exit;

      IMDGT := StrToInt(TimeTxt.Text);
      AssignFile(IMDF, SaveDialog.FileName);
      Rewrite(IMDF);
      SaveInf;
      SortNote;
      IsEmpty := False;
      for i := 1 to KeyGrid.RowCount - 1 do
        if (Trim(KeyGrid.Cells[1, i]) = '') or (Trim(KeyGrid.Cells[2, i]) = '')
          or (Trim(KeyGrid.Cells[3, i]) = '') or
          (Trim(KeyGrid.Cells[4, i]) = '') or (Trim(KeyGrid.Cells[5, i]) = '')
        then
        begin
          IsEmpty := True;
          Break;
        end;
      if IsEmpty then
        NoteCount := i - 1
      else
        NoteCount := KeyGrid.RowCount - 1;
      WriteByte4(Byte4(NoteCount));
      for i := 1 to NoteCount do
      begin
        if (Trim(KeyGrid.Cells[1, i]) = '') or (Trim(KeyGrid.Cells[2, i]) = '')
          or (Trim(KeyGrid.Cells[3, i]) = '') or
          (Trim(KeyGrid.Cells[4, i]) = '') or (Trim(KeyGrid.Cells[5, i]) = '')
        then
          Break;
        m := StrToInt(Trim(KeyGrid.Cells[1, i])) * 16 +
          StrToInt(Trim(KeyGrid.Cells[2, i]));
        NoteTime := StrToInt(Trim(KeyGrid.Cells[3, i]));
        NoteTrack := StrToInt(Trim(KeyGrid.Cells[4, i]));
        NoteParameter := StrToInt(Trim(KeyGrid.Cells[5, i]));
        WriteByte2(Byte2(m));
        WriteByte4(Byte4(NoteTime));
        WriteByte1(NoteTrack);
        WriteByte4(Byte4(NoteParameter));
      end;
      CloseFile(IMDF);
    end;
  end;
end;

procedure TForm1.ShakeBPMBeginTimer(Sender: TObject);
begin
  BPMBeginShake := BPMBeginShake + 2;
  BPMBegin.Left := BPMBeginLeft -
    Trunc(ShakeExtent * sin(BPMBeginShake * pi / 10));
  if BPMBeginShake >= 50 then
  begin
    BPMBeginShake := 0;
    ShakeBPMBegin.Enabled := False;
  end;
end;

procedure TForm1.ShakeBPMEndTimer(Sender: TObject);
begin
  BPMEndShake := BPMEndShake + 2;
  BPMEnd.Left := BPMEndLeft - Trunc(ShakeExtent * sin(BPMEndShake * pi / 10));
  if BPMEndShake >= 50 then
  begin
    BPMEndShake := 0;
    ShakeBPMEnd.Enabled := False;
  end;
end;

procedure TForm1.ShakeChangedBPMTimer(Sender: TObject);
begin
  ChangedBPMShake := ChangedBPMShake + 2;
  ChangedBPM.Left := ChangedBPMLeft -
    Trunc(ShakeExtent * sin(ChangedBPMShake * pi / 10));
  if ChangedBPMShake >= 50 then
  begin
    ChangedBPMShake := 0;
    ShakeChangedBPM.Enabled := False;
  end;
end;

var
  TimeTxtShake, BPMTxtShake: integer;

procedure TForm1.ShakeTimeTxtTimer(Sender: TObject);
begin
  TimeTxtShake := TimeTxtShake + 2;
  TimeTxt.Left := TimeTxtLeft -
    Trunc(ShakeExtent * sin(TimeTxtShake * pi / 10));
  if TimeTxtShake >= 50 then
  begin
    TimeTxtShake := 0;
    ShakeTimeTxt.Enabled := False;
  end;
end;

procedure TForm1.ShakeBPMTxtTimer(Sender: TObject);
begin
  BPMTxtShake := BPMTxtShake + 2;
  BPMTxt.Left := BPMTxtLeft - Trunc(ShakeExtent * sin(BPMTxtShake * pi / 10));
  if BPMTxtShake >= 50 then
  begin
    BPMTxtShake := 0;
    ShakeBPMTxt.Enabled := False;
  end;
end;

procedure TForm1.ReadBMS(FileName: string);
type
  BPMType = record
    BPM: double;
    RealTime, StandardTime, SelfTime, bBeat, bBeatLength, bGrid: integer;
  end;
var
  Stack: array [1 .. 6] of integer;
  FloatBPM: array [1 .. SIZE] of double;
  BPMNow: double;
  BeatLength, BeatCount, BPMCount: integer;
  time, Track, NoteType, Beat, Grid: integer;
  WaveTrack: string;
  YES: Boolean;
  i, j, k, LastBPMRealTime, LastBPMStandardTime: integer;
  st, st2: string;
  BMSBPM: array [0 .. SIZE] of BPMType;
  t: BPMType;

begin
  BMSInfoMemo.Lines.LoadFromFile(FileName);
  { for i := 1 to SIZE do
    with Note[i] do
    begin
    if Pic <> nil then
    begin
    Pic.Free;
    Pic := nil;
    end;
    NTy := -1;
    Last := 0;
    Next := 0;
    Time := 0;
    Para := 0;
    Track := -1;
    end;
    Selected := 0; }

  CleanBPMClick(nil);
  CleanKeyGrid;
  i := 0;
  LastBPMRealTime := 0;
  LastBPMStandardTime := 0;
  while (pos('#BPM', BMSInfoMemo.Lines[i]) = 0) and
    (i < BMSInfoMemo.Lines.Count) do
  begin
    i := i + 1;
  end;
  if i >= BMSInfoMemo.Lines.Count then
    Exit;
  st := BMSInfoMemo.Lines[i];
  // 查找BPM
  Delete(st, 1, 5);
  FillChar(BMSBPM, SizeOf(BMSBPM), 0);
  FillChar(FloatBPM, SizeOf(FloatBPM), 0);
  BMSBPM[0].BPM := StrToFloat(st);
  BPMTxt.Text := st;

  k := i + 1;
  i := k;
  WaveTrack := '00';
  while (pos('#WAV', BMSInfoMemo.Lines[i]) = 0) and
    (i < BMSInfoMemo.Lines.Count) do
  begin
    i := i + 1;
  end;
  if i < BMSInfoMemo.Lines.Count then
    WaveTrack := copy(BMSInfoMemo.Lines[i], 5, 2);

  i := k;
  while (pos('MAIN DATA FIELD', BMSInfoMemo.Lines[i]) = 0) and
    (i < BMSInfoMemo.Lines.Count) do
  begin
    if pos('#BPM', BMSInfoMemo.Lines[i]) > 0 then
    begin
      st2 := copy(BMSInfoMemo.Lines[i], 5, 2);
      st := BMSInfoMemo.Lines[i]; // 查找BPM
      Delete(st, 1, 7);
      FloatBPM[StrToInt('0x' + st2)] := StrToFloat(st);
      // messagebox(Self.handle, '暂未支持BPM变速功能！', '你™在逗我？', MB_ICONASTERISK)
    end;
    i := i + 1;
  end;
  k := i;
  {
    i := BMSInfoMemo.Lines.Count - 1;
    while (pos('#', BMSInfoMemo.Lines[i]) = 0) and (i >= 0) do
    begin
    i := i - 1;
    end;
    BeatCount := strtoint(copy(BMSInfoMemo.Lines[i], 2, 3)) + 1; }
  // TimeTxt.Text := inttostr(trunc(60000 / BMSBPM[0] * BeatCount * 4));
  { Bottom := trunc(strtoint(TimeLbl.Caption) / Zoom) + TopInterval;

    for i := 0 to 6 do
    begin
    with (TShape(FindComponent('Border' + inttostr(i)) as TShape)) do
    begin
    Top := -NoteBox.VertScrollBar.Position;
    Height := Bottom + Track1SMP.Height + TopInterval;
    end;
    end;
    BeginLbl.Top := Bottom - NoteBox.VertScrollBar.Position;
    BeginLbl.Visible := True;
    LastNote := 1; }
  FillChar(Stack, SizeOf(Stack), $FF);
  /// ////////////////////////////////////////////////////////////////////////////
  i := k;
  j := 1;
  for i := i + 1 to BMSInfoMemo.Lines.Count - 1 do
  begin
    if Trim(BMSInfoMemo.Lines[i]) = '' then
      Continue;
    Beat := StrToInt(copy(BMSInfoMemo.Lines[i], 2, 3));
    NoteType := StrToInt(copy(BMSInfoMemo.Lines[i], 5, 1));
    Track := StrToInt(copy(BMSInfoMemo.Lines[i], 6, 1));
    if not(NoteType = 0) or not(Track in [3, 8]) then
      Continue;
    st2 := copy(BMSInfoMemo.Lines[i], 8, length(BMSInfoMemo.Lines[i]) - 7);
    BeatLength := length(st2) div 2;

    if Track = 3 then
    begin
      for Grid := 1 to BeatLength do
      begin
        st := copy(st2, Grid * 2 - 1, 2);
        if (st <> '00') then
        begin
          with BMSBPM[j] do
          begin
            BPM := StrToInt('0x' + st);
            StandardTime := GetBMSNoteTime(StandardBPM, Beat, BeatLength, Grid);
            bBeat := Beat;
            bBeatLength := BeatLength;
            bGrid := Grid;
            { RealTime := GetBMSNoteTime(BPMNow, Beat, BeatLength, Grid) -
              LastBPMStandardTime + LastBPMRealTime;
              LastBPMRealTime := RealTime;
              LastBPMStandardTime := GetBMSNoteTime(BPM, Beat, BeatLength, Grid);
              SelfTime := GetBMSNoteTime(BPM, Beat, BeatLength, Grid);
              BPMNow := BPM; }
            { BPMGrid.RowCount := BPMGrid.RowCount + 1;
              BPMGrid.Cells[1, BPMGrid.RowCount - 1] := IntToStr(RealTime);
              BPMGrid.Cells[2, BPMGrid.RowCount - 1] := FloatToStr(BPM); }
          end;
          { CreatTapNote(LastNote, Time, Track mod 6);
            LastNote := LastNote + 1; }
          j := j + 1;
        end;
      end;
    end
    else
    begin
      for Grid := 1 to BeatLength do
      begin
        st := copy(st2, Grid * 2 - 1, 2);
        if (st <> '00') then
        begin
          with BMSBPM[j] do
          begin
            BPM := FloatBPM[StrToInt('0x' + st)];
            StandardTime := GetBMSNoteTime(StandardBPM, Beat, BeatLength, Grid);
            bBeat := Beat;
            bBeatLength := BeatLength;
            bGrid := Grid;
            { RealTime := GetBMSNoteTime(BPMNow, Beat, BeatLength, Grid) -
              LastBPMStandardTime + LastBPMRealTime;
              LastBPMRealTime := RealTime;
              LastBPMStandardTime := GetBMSNoteTime(BPM, Beat, BeatLength, Grid);
              SelfTime := GetBMSNoteTime(BPM, Beat, BeatLength, Grid);
              BPMNow := BPM; }
            { BPMGrid.RowCount := BPMGrid.RowCount + 1;
              BPMGrid.Cells[1, BPMGrid.RowCount - 1] := IntToStr(RealTime);
              BPMGrid.Cells[2, BPMGrid.RowCount - 1] := FloatToStr(BPM); }
          end;
          { CreatTapNote(LastNote, Time, Track mod 6);
            LastNote := LastNote + 1; }
          j := j + 1;
        end;
      end;
    end;
  end;
  BPMCount := j - 1;

  for i := 1 to BPMCount - 1 do
    for j := i + 1 to BPMCount do
      if BMSBPM[j].StandardTime < BMSBPM[i].StandardTime then
      begin
        t := BMSBPM[j];
        BMSBPM[j] := BMSBPM[i];
        BMSBPM[i] := t;
      end;

  BPMNow := BMSBPM[0].BPM;
  LastBPMRealTime := 0;
  LastBPMStandardTime := 0;

  for i := 1 to BPMCount do
    with BMSBPM[i] do
    begin
      RealTime := GetBMSNoteTime(BPMNow, bBeat, bBeatLength, bGrid) -
        LastBPMStandardTime + LastBPMRealTime;
      LastBPMRealTime := RealTime;
      LastBPMStandardTime := GetBMSNoteTime(BPM, bBeat, bBeatLength, bGrid);
      SelfTime := GetBMSNoteTime(BPM, bBeat, bBeatLength, bGrid);
      BPMNow := BPM;
    end;

  i := BMSInfoMemo.Lines.Count - 1;
  while (pos('#', BMSInfoMemo.Lines[i]) = 0) and (i >= 0) do
  begin
    i := i - 1;
  end;
  BeatCount := StrToInt(copy(BMSInfoMemo.Lines[i], 2, 3)) + 1;
  TimeTxt.Text := IntToStr(GetBMSNoteTime(BMSBPM[BPMCount].BPM, BeatCount, 1, 1)
    - BMSBPM[BPMCount].SelfTime + BMSBPM[BPMCount].RealTime);
  for i := 0 to BPMCount - 1 do
  begin
    AddBPM(BMSBPM[i].RealTime, BMSBPM[i + 1].RealTime, BMSBPM[i].BPM);
  end;
  AddBPM(BMSBPM[BPMCount].RealTime, StrToInt(TimeTxt.Text),
    BMSBPM[BPMCount].BPM);
  if BPMCount >= 1 then
    IsChangeBPM.Checked := True
  else
  begin
    IsChangeBPM.Checked := False;
    BPMTxt.Text := FloatToStr(BMSBPM[0].BPM)
  end;
  /// ////////////////////////////////////////////////////////////////////////////
  i := k;
  for i := i + 1 to BMSInfoMemo.Lines.Count - 1 do
  begin
    if Trim(BMSInfoMemo.Lines[i]) = '' then
      Continue;
    Beat := StrToInt(copy(BMSInfoMemo.Lines[i], 2, 3));
    NoteType := StrToInt(copy(BMSInfoMemo.Lines[i], 5, 1));
    Track := StrToInt(copy(BMSInfoMemo.Lines[i], 6, 1));
    if not(Track in [1 .. 6]) and not(NoteType in [BMSTap, BMSHold]) then
      Continue;
    st2 := copy(BMSInfoMemo.Lines[i], 8, length(BMSInfoMemo.Lines[i]) - 7);
    BeatLength := length(st2) div 2;

    if NoteType = BMSHold then
    begin
      for Grid := 1 to BeatLength do
      begin
        st := copy(st2, Grid * 2 - 1, 2);
        if (st <> '00') and (st <> WaveTrack) then
        begin
          if Stack[Track] = -1 then
          begin
            time := GetBMSNoteTime(StandardBPM, Beat, BeatLength, Grid);
            YES := False;
            for j := 0 to BPMCount - 1 do
            begin
              if time < BMSBPM[j + 1].StandardTime then
              begin
                YES := True;
                Break;
              end;
            end;
            if not YES then
              j := BPMCount;
            Stack[Track] := GetBMSNoteTime(BMSBPM[j].BPM, Beat, BeatLength,
              Grid) - BMSBPM[j].SelfTime + BMSBPM[j].RealTime;
          end
          else
          begin
            time := GetBMSNoteTime(StandardBPM, Beat, BeatLength, Grid);
            YES := False;
            for j := 0 to BPMCount - 1 do
            begin
              if time < BMSBPM[j + 1].StandardTime then
              begin
                YES := True;
                Break;
              end;
            end;
            if not YES then
              j := BPMCount;
            time := GetBMSNoteTime(BMSBPM[j].BPM, Beat, BeatLength, Grid) -
              BMSBPM[j].SelfTime + BMSBPM[j].RealTime;
            KeyGrid.Cells[0, KeyGrid.RowCount - 1] :=
              IntToStr(KeyGrid.RowCount - 1);
            KeyGrid.Cells[1, KeyGrid.RowCount - 1] := IntToStr(0);
            KeyGrid.Cells[2, KeyGrid.RowCount - 1] := IntToStr(IMDHold);
            KeyGrid.Cells[3, KeyGrid.RowCount - 1] := IntToStr(Stack[Track]);
            KeyGrid.Cells[4, KeyGrid.RowCount - 1] :=
              IntToStr(BMSTrack2IMD(Track));
            KeyGrid.Cells[5, KeyGrid.RowCount - 1] :=
              IntToStr(time - Stack[Track]);
            KeyGrid.RowCount := KeyGrid.RowCount + 1;

            { CreatHoldNote(LastNote, Stack[Track], Track mod 6,
              Time - Stack[Track]);
              LastNote := LastNote + 1; }
            Stack[Track] := -1;
          end;
        end;
      end;
    end
    else if NoteType = BMSTap then
    begin
      for Grid := 1 to BeatLength do
      begin
        st := copy(st2, Grid * 2 - 1, 2);
        if (st <> '00') and (st <> WaveTrack) then
        begin
          time := GetBMSNoteTime(StandardBPM, Beat, BeatLength, Grid);
          YES := False;
          for j := 0 to BPMCount - 1 do
          begin
            if time < BMSBPM[j + 1].StandardTime then
            begin
              YES := True;
              Break;
            end;
          end;
          if not YES then
            j := BPMCount;
          time := GetBMSNoteTime(BMSBPM[j].BPM, Beat, BeatLength, Grid) -
            BMSBPM[j].SelfTime + BMSBPM[j].RealTime;
          KeyGrid.Cells[0, KeyGrid.RowCount - 1] :=
            IntToStr(KeyGrid.RowCount - 1);
          KeyGrid.Cells[1, KeyGrid.RowCount - 1] := '0';
          KeyGrid.Cells[2, KeyGrid.RowCount - 1] := IntToStr(IMDTap);
          KeyGrid.Cells[3, KeyGrid.RowCount - 1] := IntToStr(time);
          KeyGrid.Cells[4, KeyGrid.RowCount - 1] :=
            IntToStr(BMSTrack2IMD(Track));
          KeyGrid.Cells[5, KeyGrid.RowCount - 1] := '0';
          KeyGrid.RowCount := KeyGrid.RowCount + 1;
          { CreatTapNote(LastNote, Time, Track mod 6);
            LastNote := LastNote + 1; }
        end;
      end;
    end;
  end;
end;

function TForm1.GetBMSNoteTime(BPMNow: double;
  Beat, BeatLength, Grid: integer): integer;
begin
  Result := Trunc((60000 / BPMNow * Beat + 60000 / BPMNow / BeatLength *
    (Grid - 1)) * 4);
end;

procedure TForm1.HideHintClick(Sender: TObject);
begin
  KeyGrid.ShowHint := not HideHint.Checked;
end;

function TForm1.BMSTrack2IMD(BMSTrack: integer): integer;
begin
  if BMSTrack <= 3 then
    Result := BMSTrack
  else
    case BMSTrack of
      6:
        Result := 0;
      4:
        Result := 4;
      5:
        Result := 5;
    end;
end;

procedure TForm1.BPMBeginEnter(Sender: TObject);
begin
  if BPMBegin.Text = '开始时间' then
    BPMBegin.Text := '';
end;

procedure TForm1.BPMBeginExit(Sender: TObject);
begin
  if Trim(BPMBegin.Text) = '' then
    BPMBegin.Text := '开始时间';
end;

procedure TForm1.BPMChangeBtnClick(Sender: TObject);
var
  BeginTime: integer;
  EndTime: integer;
  BPM: double;
begin
  BeginTime := 0;
  EndTime := 0;
  BPM := 0;
  try
    BeginTime := StrToInt(BPMBegin.Text);
  except
    ShakeBPMBegin.Enabled := True;
  end;
  try
    EndTime := StrToInt(BPMEnd.Text);
  except
    ShakeBPMEnd.Enabled := True;
  end;
  try
    BPM := StrToFloat(ChangedBPM.Text);
  except
    ShakeChangedBPM.Enabled := True;
  end;
  if BeginTime >= EndTime then
  begin
    ShakeBPMBegin.Enabled := True;
    ShakeBPMEnd.Enabled := True;
    Exit;
  end;
  if BPM = 0 then
  begin
    ShakeChangedBPM.Enabled := True;
    Exit;
  end;
  AddBPM(BeginTime, EndTime, BPM);
  BPMBegin.Text := '开始时间';
  BPMEnd.Text := '结束时间';
  ChangedBPM.Text := 'BPM';
end;

procedure TForm1.BPMEndEnter(Sender: TObject);
begin
  if BPMEnd.Text = '结束时间' then
    BPMEnd.Text := '';
end;

procedure TForm1.BPMEndExit(Sender: TObject);
begin
  if Trim(BPMEnd.Text) = '' then
    BPMEnd.Text := '结束时间';
end;

procedure TForm1.IMD2txtClick(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.ReturnToiMClick(Sender: TObject);
var
  i, j, k: integer;
  st: string;
begin
  try
    ExcelApp.ActiveSheet.UsedRange.copy;
    ExcelMemo.Clear;
    ExcelMemo.PasteFromClipboard;
    CleanKeyGrid;
    for i := 1 to ExcelMemo.Lines.Count - 1 do
    begin
      if Trim(ExcelMemo.Lines[i]) = '' then
        Continue;
      KeyGrid.Cells[0, i] := IntToStr(i);
      k := 1;
      st := '';
      for j := 1 to length(ExcelMemo.Lines[i]) do
      begin
        if ExcelMemo.Lines[i][j] in ['0' .. '9', '-'] then
          st := st + ExcelMemo.Lines[i][j];
        if (ExcelMemo.Lines[i][j] = #9) or
          ((j = length(ExcelMemo.Lines[i])) and (k = 5)) then
        begin
          KeyGrid.Cells[k, i] := st;
          k := k + 1;
          st := '';
        end;
      end;
      KeyGrid.RowCount := KeyGrid.RowCount + 1;
    end;
    ExcelApp.ActiveSheet.Range['Z99'].copy;
    ExcelApp.ActiveWorkBook.Saved := True;
    ExcelApp.Quit;

  finally
    EnterExcelModeProcess := 0;
    Form1.formstyle := fsNormal;
    NowPanel1Top := Panel1.Top;
    NowPanel2Top := Panel2.Top;
    PanelTopAbs := 0 - Panel1.Top;
    NowHeight := Form1.ClientHeight;
    NowWidth := Form1.ClientWidth;
    if IsChangeBPM.Checked then
      WidthAbs := Panel1.Width + Panel3.Width - NowWidth
    else
      WidthAbs := Panel1.Width - NowWidth;
    HeightAbs := Panel1.Height - NowHeight;
    IsWrite := False;
    Form1.Constraints.MaxHeight := 0;
    Form1.Constraints.MaxWidth := 0;
    EnterExcelMode.Enabled := True;
  end;
end;

procedure TForm1.OpenInExcelClick(Sender: TObject);
{ var
  st: string;
  i, j: integer; }
begin
  try
    ExcelApp := CreateOleObject('Excel.Application');
  except
    MessageBox(Self.Handle, '没装Excel你按个毛啊 (╯°Д°)╯︵ ┻━┻ ', '你在逗我？',
      mb_iconerror);
    Exit;
  end;
  EnterExcelModeProcess := 0;
  Form1.formstyle := fsStayOnTop;
  NowPanel1Top := Panel1.Top;
  NowPanel2Top := Panel2.Top;
  PanelTopAbs := 0 - Panel2.Top;
  NowHeight := Form1.ClientHeight;
  NowWidth := Form1.ClientWidth;
  WidthAbs := Panel2.Width - NowWidth;
  HeightAbs := Panel2.Height - NowHeight;
  IsWrite := True;
  Form1.Constraints.MaxHeight := 0;
  Form1.Constraints.MaxWidth := 0;
  EnterExcelMode.Enabled := True;
end;

procedure TForm1.PasteGridClick(Sender: TObject);
var
  i, j, k: integer;
  st: string;
begin
  ExcelMemo.Clear;
  ExcelMemo.PasteFromClipboard;
  CleanKeyGrid;
  for i := 0 to ExcelMemo.Lines.Count - 1 do
  begin
    if Trim(ExcelMemo.Lines[i]) = '' then
      Continue;
    KeyGrid.Cells[0, i + 1] := IntToStr(i + 1);
    k := 1;
    st := '';
    for j := 1 to length(ExcelMemo.Lines[i]) do
    begin
      if ExcelMemo.Lines[i][j] in ['0' .. '9', '-'] then
        st := st + ExcelMemo.Lines[i][j];
      if (ExcelMemo.Lines[i][j] = #9) or
        ((j = length(ExcelMemo.Lines[i])) and (k = 5)) then
      begin
        KeyGrid.Cells[k, i + 1] := st;
        k := k + 1;
        st := '';
      end;
    end;
    KeyGrid.RowCount := KeyGrid.RowCount + 1;
  end;
end;

procedure TForm1.ChangedBPMEnter(Sender: TObject);
begin
  if ChangedBPM.Text = 'BPM' then
    ChangedBPM.Text := '';
end;

procedure TForm1.ChangedBPMExit(Sender: TObject);
begin
  if Trim(ChangedBPM.Text) = '' then
    ChangedBPM.Text := 'BPM';
end;

var
  ChangeFormSizeCount: integer;

procedure TForm1.ChangeFormSizeTimer(Sender: TObject);
begin
  ChangeFormSizeCount := ChangeFormSizeCount + 4;
  Form1.ClientHeight := NowHeight +
    Trunc(HeightAbs * sin(pi * ChangeFormSizeCount / 200));
  Form1.ClientWidth := NowWidth +
    Trunc(WidthAbs * sin(pi * ChangeFormSizeCount / 200));
  if ChangeFormSizeCount >= 100 then
  begin
    ChangeFormSize.Enabled := False;
    Form1.Constraints.MaxWidth := Form1.Width;
    Form1.Constraints.MaxHeight := Form1.Height;

  end;
end;

procedure TForm1.CleanBPMClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 1 to BPMGrid.RowCount - 1 do
    for j := 0 to 2 do
      BPMGrid.Cells[j, i] := '';
  BPMGrid.RowCount := 2;
end;

procedure TForm1.IsChangeBPMClick(Sender: TObject);
begin
  NowWidth := Form1.ClientWidth;
  NowHeight := Form1.ClientHeight;
  ChangeFormSizeCount := 0;
  Form1.Constraints.MaxHeight := 0;
  Form1.Constraints.MaxWidth := 0;
  if IsChangeBPM.Checked then
  begin
    WidthAbs := Panel1.Width + Panel3.Width - Form1.ClientWidth;
    HeightAbs := Panel1.Height - Form1.ClientHeight;
    BPMTxt.Enabled := False;
    BPMTxt.Text := '变速BPM';
  end
  else
  begin
    WidthAbs := Panel1.Width - Form1.ClientWidth;
    HeightAbs := Panel1.Height - Form1.ClientHeight;
    BPMTxt.Enabled := True;
    BPMTxt.Text := '';
  end;
  ChangeFormSize.Enabled := True;
end;

procedure TForm1.SaveAsBtnClick(Sender: TObject);
var
  i: integer;
  m: Short;
  // IsNoodle: Short;
  NoteCount: integer;
  // NoteType: Short;
  NoteTime: integer;
  NoteTrack: byte;
  NoteParameter: integer;
  IsEmpty, IsBreak: Boolean;
begin
  IsBreak := False;
  if not TryStrToInt(Trim(TimeTxt.Text), i) then
  begin
    ShakeTimeTxt.Enabled := True;
    IsBreak := True;
  end;
  if (Trim(BPMTxt.Text) = '') or (not TryStrToInt(Trim(BPMTxt.Text), i) and
    not(BPMTxt.Text = '变速BPM')) or (TryStrToInt(Trim(BPMTxt.Text), i) and
    (i = 0)) then
  begin
    ShakeBPMTxt.Enabled := True;
    IsBreak := True;
  end;
  if IsBreak then
    Exit;
  if (SaveDialog.Execute) then
  begin
    if (SaveDialog.FileName <> '') then
    begin
      if LowerCase(ExtractFileExt(SaveDialog.FileName)) <> '.imd' then
        SaveDialog.FileName := SaveDialog.FileName + '.imd';
      if FileExists(SaveDialog.FileName) then
        if MessageBox(Form1.Handle,
          PWideChar('“' + SaveDialog.FileName + '”已存在，是否覆盖？'), '不要在意标题',
          MB_YesNo + MB_iconQuestion) = idNo then
          Exit;

      IMDGT := StrToInt(TimeTxt.Text);
      AssignFile(IMDF, SaveDialog.FileName);
      Rewrite(IMDF);
      SaveInf;
      SortNote;
      IsEmpty := False;
      for i := 1 to KeyGrid.RowCount - 1 do
        if (Trim(KeyGrid.Cells[1, i]) = '') or (Trim(KeyGrid.Cells[2, i]) = '')
          or (Trim(KeyGrid.Cells[3, i]) = '') or
          (Trim(KeyGrid.Cells[4, i]) = '') or (Trim(KeyGrid.Cells[5, i]) = '')
        then
        begin
          IsEmpty := True;
          Break;
        end;
      if IsEmpty then
        NoteCount := i - 1
      else
        NoteCount := KeyGrid.RowCount - 1;
      WriteByte4(Byte4(NoteCount));
      for i := 1 to NoteCount do
      begin
        if (Trim(KeyGrid.Cells[1, i]) = '') or (Trim(KeyGrid.Cells[2, i]) = '')
          or (Trim(KeyGrid.Cells[3, i]) = '') or
          (Trim(KeyGrid.Cells[4, i]) = '') or (Trim(KeyGrid.Cells[5, i]) = '')
        then
          Break;
        m := StrToInt(Trim(KeyGrid.Cells[1, i])) * 16 +
          StrToInt(Trim(KeyGrid.Cells[2, i]));
        NoteTime := StrToInt(Trim(KeyGrid.Cells[3, i]));
        NoteTrack := StrToInt(Trim(KeyGrid.Cells[4, i]));
        NoteParameter := StrToInt(Trim(KeyGrid.Cells[5, i]));
        WriteByte2(Byte2(m));
        WriteByte4(Byte4(NoteTime));
        WriteByte1(NoteTrack);
        WriteByte4(Byte4(NoteParameter));
      end;
      CloseFile(IMDF);
    end;
  end;
end;

procedure TForm1.TimeTxtChange(Sender: TObject);
var
  n, k: integer;
begin
  if TryStrToInt(TimeTxt.Text, n) then
  begin
    k := Form2.TimeLine.Max - Form2.TimeLine.Position;
    Form2.TimeLine.Max := n;
    Form2.TimeLine.Position := Form2.TimeLine.Max - k;
    // ShowMessage(IntToStr(Form2.timeline.Max));
  end;
end;

end.
