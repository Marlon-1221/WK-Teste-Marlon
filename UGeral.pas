unit UGeral;

interface

uses
  UProduto, UPedido, UItemPedido;

var
  Pedido: TPedido;
  Produto: TProduto;
  ItemPedido: TItemPedido;

procedure InicializarInstancias;

implementation

procedure InicializarInstancias;
begin
  Pedido     := TPedido.Create;
  Produto    := TProduto.Create(0,'',0,0);
  ItemPedido := TItemPedido.Create;
end;

end.

