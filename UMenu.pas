unit UMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls;

type
  TMenu = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Cadastros: TMenuItem;
    Pedido: TMenuItem;
    procedure PedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Menu: TMenu;

implementation

{$R *.dfm}

uses UCadPedido;

procedure TMenu.PedidoClick(Sender: TObject);
begin
  CadPedido := TCadPedido.Create(Self);
  try
    CadPedido.showmodal;
  finally
    FreeAndNil(CadPedido)
  end;
end;

end.
