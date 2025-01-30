object CadPedido: TCadPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'CadPedido'
  ClientHeight = 552
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    726
    552)
  TextHeight = 15
  object LbValorPedido: TLabel
    Left = 222
    Top = 527
    Width = 72
    Height = 15
    Caption = 'Valor Pedido :'
  end
  object LbResultValorPedido: TLabel
    Left = 302
    Top = 527
    Width = 3
    Height = 15
  end
  object Panel1: TPanel
    Left = -1
    Top = 4
    Width = 720
    Height = 517
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 14803425
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      720
      517)
    object Label1: TLabel
      Left = 21
      Top = 155
      Width = 55
      Height = 15
      Anchors = []
      Caption = 'V. Unitario'
    end
    object LbProduto: TLabel
      Left = 7
      Top = 127
      Width = 68
      Height = 15
      Anchors = []
      Caption = 'Cod.Produto'
    end
    object Label2: TLabel
      Left = 13
      Top = 102
      Width = 62
      Height = 15
      Anchors = []
      Caption = 'Cod.Cliente'
    end
    object Label3: TLabel
      Left = 16
      Top = 180
      Width = 60
      Height = 15
      Anchors = []
      Caption = 'Qtd.Pedido'
    end
    object EdtCodCliente: TEdit
      Left = 81
      Top = 99
      Width = 139
      Height = 23
      Anchors = []
      TabOrder = 0
      OnChange = EdtCodClienteChange
      OnExit = EdtCodClienteExit
    end
    object EdtProduto: TEdit
      Left = 83
      Top = 125
      Width = 70
      Height = 23
      Anchors = []
      TabOrder = 1
      OnExit = EdtProdutoExit
    end
    object EdtPrecoVenda: TEdit
      Left = 83
      Top = 151
      Width = 139
      Height = 23
      Anchors = []
      TabOrder = 2
    end
    object EdtDesProduto: TEdit
      Left = 156
      Top = 125
      Width = 189
      Height = 23
      Anchors = []
      Enabled = False
      TabOrder = 3
    end
    object EdtQuantidadePedido: TEdit
      Left = 83
      Top = 177
      Width = 139
      Height = 23
      Anchors = []
      TabOrder = 4
      OnExit = EdtQuantidadePedidoExit
    end
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 210
    Width = 704
    Height = 301
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DMPedido.DsItemPedido
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
  end
  object BtnFechar: TButton
    Left = 637
    Top = 524
    Width = 75
    Height = 25
    Caption = '&Fechar'
    TabOrder = 2
    OnClick = BtnFecharClick
  end
  object BtnGrava: TButton
    Left = 552
    Top = 524
    Width = 79
    Height = 25
    Caption = '&Gravar Pedido'
    TabOrder = 3
    OnClick = BtnGravaClick
  end
  object BtnCancelarPedido: TButton
    Left = 8
    Top = 524
    Width = 98
    Height = 25
    Caption = '&Cancelar Pedido'
    TabOrder = 4
    OnClick = BtnCancelarPedidoClick
  end
  object BtnCarregarPedido: TButton
    Left = 112
    Top = 524
    Width = 96
    Height = 25
    Caption = '&Carregar Pedido'
    TabOrder = 5
    OnClick = BtnCarregarPedidoClick
  end
end
