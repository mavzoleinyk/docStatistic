unit fMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lines: TLabel;
    spaces: TLabel;
    symbols: TLabel;
    words: TLabel;
    Open1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  //Обзор текущей папки
  Open1.InitialDir := GetCurrentDir;
  if Open1.Execute then
    Edit1.Text := Open1.FileName
  else
    ShowMessage('Файл не выбран!');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  f: file of byte;
  str: byte;
  oldstr, symbol, word, line, space: integer;
begin
  symbol := 0;
  word := 0;
  space := 0;
  line := 0;
  if FileExists(Edit1.Text) then
    begin
      AssignFile(f, Edit1.Text);
      Reset(f);
      while not EOF(f) do
        begin
          oldstr := str;
          Read(f, str);
          if ((str <> 32) and (str <> 13) and (str <> 10)) then
            symbol := symbol + 1;
          if str = 32 then space := space + 1;
          if str = 13 then line := line + 1;
          if ((str = 32) or (str = 13) or (str = 10)) then
            if ((oldstr <> 32) and (oldstr <> 10 ) and (oldstr <> 13)) then
              word := word + 1;
        end;
        CloseFile(f);
    end
    else
      ShowMessage('Ошибка: Файл не найден');
    symbols.Caption := IntToStr(symbol);
    spaces.Caption := IntToStr(space);
    lines.Caption := IntToStr(line);
    words.Caption := IntToStr(word);
end;

end.

