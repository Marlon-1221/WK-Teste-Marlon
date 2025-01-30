unit UCadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,UPedido,UProduto,UItemPedido;

type
  TCadPedido = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    LbProduto: TLabel;
    Label2: TLabel;
    BtnFechar: TButton;
    EdtCodCliente: TEdit;
    EdtProduto: TEdit;
    EdtPrecoVenda: TEdit;
    EdtDesProduto: TEdit;
    EdtQuantidadePedido: TEdit;
    Label3: TLabel;
    BtnGrava: TButton;
    BtnCancelarPedido: TButton;
    BtnCarregarPedido: TButton;
    LbValorPedido: TLabel;
    LbResultValorPedido: TLabel;
    procedure EdtCodClienteExit(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure EdtProdutoExit(Sender: TObject);
    procedure EdtQuantidadePedidoExit(Sender: TObject);
    procedure BtnGravaClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure EdtCodClienteChange(Sender: TObject);
    procedure BtnCarregarPedidoClick(Sender: TObject);
    procedure BtnCancelarPedidoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    VInAlterando : Boolean;
    { Private declarations}
    function ApenasNumeros(const Texto: string): string;
  public

  Procedure CarregaDados;
  Procedure LimpaCamposProdutos;
  Procedure RecarregaDados;
  Procedure RecarregaDadosProdutos;
  Procedure BuscaTotalPedido;
    { Public declarations }
  end;

var
  CadPedido: TCadPedido;

implementation

uses UDamPedido, USelCarregaPedido,UGeral;

{$R *.dfm}

{ TCadPedido }

procedure TCadPedido.BtnCancelarPedidoClick(Sender: TObject);
begin
  SelCarregaPedido := TSelCarregaPedido.Create(Self);
  try
    SelCarregaPedido.VInDelete := true;
    if SelCarregaPedido.ShowModal = mrOk then
      ShowMessage('Atenção! Pedido Excluido com sucesso.')
    else
      ShowMessage('Atenção! Pedido não encontrado.');
  finally
    FreeAndNil(SelCarregaPedido)
  end;
end;

procedure TCadPedido.BtnCarregarPedidoClick(Sender: TObject);
begin
  SelCarregaPedido := TSelCarregaPedido.Create(Self);
  try
    if SelCarregaPedido.ShowModal = mrOk then
    begin
      DMPedido.PreparaItemPedido;
      RecarregaDados;
    end
    else
      ShowMessage('Atenção! Pedido não encontrado.');
  finally
    FreeAndNil(SelCarregaPedido)
  end;
end;

procedure TCadPedido.BtnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TCadPedido.EdtQuantidadePedidoExit(Sender: TObject);
var
  Value: Integer;
begin
  if not TryStrToInt(EdtQuantidadePedido.Text, Value) then
  begin
    ShowMessage('Por favor, insira apenas números.');
    EdtQuantidadePedido.Clear;
    EdtQuantidadePedido.SetFocus;
  end;
end;

procedure TCadPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DMPedido.Free;
end;

procedure TCadPedido.FormCreate(Sender: TObject);
begin
  InicializarInstancias;
  DMPedido   := TDMPedido.Create(self);
end;

procedure TCadPedido.BtnGravaClick(Sender: TObject);
begin
  if (EdtQuantidadePedido.text = '') or (EdtProduto.text = '') or (EdtCodCliente.Text = '') then
  begin
    ShowMessage('Por favor, Preencha todos os campos.');
    exit;
  end;

  CarregaDados; // Carrega dados Pedido

  if not VInAlterando then
    UGeral.ItemPedido.Inserir(DMPedido.FDConnection1)
  else
    UGeral.ItemPedido.Alterar(DMPedido.FDConnection1);
  VInAlterando := false;

  //Limpa componentes e totaliza Pedido
  DMPedido.PreparaItemPedido;
  DMPedido.TotalizaPedido;
  LimpaCamposProdutos;
  BuscaTotalPedido;
end;

Procedure TCadPedido.LimpaCamposProdutos;
begin
  //Procedure criada apenas para limpar os campos de produtos
  EdtProduto.Clear;
  EdtPrecoVenda.Clear;
  EdtDesProduto.Clear;
  EdtQuantidadePedido.Clear;
end;

procedure TCadPedido.RecarregaDados;
begin
  EdtCodCliente.Text    := IntToStr(uGeral.Pedido.CodCli);
  EdtCodCliente.Enabled := false;
end;

Procedure TCadPedido.BuscaTotalPedido;
begin
  with DMPedido do
  begin
    with Qaux.SQL do
    begin
      clear;
      Qaux.close;
      Add('SELECT VlrTot');
      Add('FROM Pedidos');
      Add('WHERE CodPed = :CodPed ');
      Qaux.ParamByName('CodPed').Value := uGeral.Pedido.CodPed;
      Qaux.open;

      if not Qaux.IsEmpty then
        LbResultValorPedido.Caption := FormatCurr('R$ #,##0.00', Qaux.FieldByName('VlrTot').Value);
    end;
  end;
end;


Procedure TCadPedido.RecarregaDadosProdutos;
begin
  UGeral.ItemPedido.CodPro := DBGrid1.DataSource.DataSet.FieldByName('CodPro').AsInteger;
  UGeral.ItemPedido.CdItem := DBGrid1.DataSource.DataSet.FieldByName('CdItem').AsInteger;
  UGeral.ItemPedido.VlrUni := DBGrid1.DataSource.DataSet.FieldByName('VlrUni').AsFloat;
  UGeral.ItemPedido.QtdPed := DBGrid1.DataSource.DataSet.FieldByName('QtdPed').AsInteger;

  EdtProduto.Text          := IntToStr(UGeral.ItemPedido.CodPro);
  EdtQuantidadePedido.Text := FloatToStr(UGeral.ItemPedido.QtdPed);
  EdtPrecoVenda.Text       := FormatCurr('R$ #,##0.00', UGeral.ItemPedido.VlrUni)
end;

procedure TCadPedido.CarregaDados;
begin
  UGeral.ItemPedido.CodPro := UGeral.Produto.CodPro;
  UGeral.ItemPedido.CodPed := UGeral.Pedido.CodPed;
  if not VInAlterando then
    UGeral.ItemPedido.CdItem := 0;
  UGeral.ItemPedido.VlrPro := (StrToCurr(ApenasNumeros(EdtPrecoVenda.Text),TFormatSettings.Create('en-US')) * StrToInt(EdtQuantidadePedido.Text));
  UGeral.ItemPedido.VlrUni := StrToCurr(ApenasNumeros(EdtPrecoVenda.Text),TFormatSettings.Create('en-US'));
  UGeral.ItemPedido.QtdPed := StrToInt(EdtQuantidadePedido.Text);
end;

procedure TCadPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Resposta: Integer;
begin
  with DMPedido do
  begin
    if key = VK_DELETE then
    begin
      if MessageDlg('Você deseja continuar?', mtConfirmation, [mbyes, mbNo], 0) = 6 then
        DeletaProduto(DBGrid1.DataSource.DataSet.FieldByName('CodPed').AsInteger,DBGrid1.DataSource.DataSet.FieldByName('CdItem').AsInteger)
    end;

    if key = VK_RETURN then
    begin
      if MessageDlg('Você deseja alterar esse produto ?', mtConfirmation, [mbyes, mbNo], 0) = 6 then
      begin
        VInAlterando := true;
        RecarregaDadosProdutos;
      end;
    end;
  end;
end;

procedure TCadPedido.EdtCodClienteChange(Sender: TObject);
begin
  BtnCarregarPedido.Enabled := EdtCodCliente.Text = '';
  BtnCancelarPedido.Enabled := EdtCodCliente.Text = '';
end;

procedure TCadPedido.EdtCodClienteExit(Sender: TObject);
var
  Value: Integer;
begin
  if not (EdtCodCliente.Text <> '') then
    exit;

  if not TryStrToInt(EdtCodCliente.Text, Value) then
  begin
    ShowMessage('Por favor, insira apenas números.');
    EdtCodCliente.clear;
    EdtCodCliente.SetFocus;
    exit;
  end;

  with DMPedido do
  begin
   if not ValidaCliente(strtoint(EdtCodCliente.Text)) then
   begin
     ShowMessage('Atenção! Cliente não cadastrato.');
     EdtCodCliente.clear;
     EdtCodCliente.SetFocus;
     exit;
   end;

   //INSERI PEDIDO NA TABELA PARA PODER INSERIR PRODUTOS
   GravaPedido(strtoint(EdtCodCliente.Text));
   EdtCodCliente.Enabled := false;
  end;
end;

procedure TCadPedido.EdtProdutoExit(Sender: TObject);
begin
  if not (EdtProduto.Text <> '') then
    exit;

  with DMPedido do
  begin
   if not (ValidaProduto(strtoint(EdtProduto.Text))) then
   begin
     ShowMessage('Atenção! Produto não cadastrato.');
     EdtProduto.clear;
     EdtProduto.SetFocus;
     exit;
   end
   else
   begin
     EdtDesProduto.Text := UGeral.Produto.DesPro;
     EdtPrecoVenda.Text := FormatCurr('R$ #,##0.00', UGeral.Produto.PreVen); //FloatToStr(UGeral.Produto.PreVen);
   end;
  end;
end;

function TCadPedido.ApenasNumeros(const Texto: string): string;
begin
  Result := Texto;
  Result := Result.Replace('R$', '', [rfReplaceAll]) // Remove "R$"
                  .Replace('.', '', [rfReplaceAll])   // Remove separador de milhar
                  .Replace(',', '.', [rfReplaceAll])  // Troca vírgula por ponto decimal
                  .Trim;
end;
end.
