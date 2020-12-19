unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  i:integer;
begin
  if opendialog1.Execute(self.Handle) then
  begin
    for i := 0 to opendialog1.Files.Count-1 do
      listbox1.items.Add(opendialog1.Files.Strings[i]);
  end;
end;

end.
