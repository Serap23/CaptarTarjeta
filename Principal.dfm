object PosConnect: TPosConnect
  Left = 0
  Top = 0
  Caption = 'PosConnect'
  ClientHeight = 472
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 102
    Width = 186
    Height = 25
    Caption = 'Ventas y devolucion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 232
    Width = 104
    Height = 19
    Caption = 'Referencia No:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 265
    Width = 85
    Height = 19
    Caption = 'Tipo HOST:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 196
    Width = 140
    Height = 25
    Caption = 'Para Anulacion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 10
    Width = 183
    Height = 25
    Caption = 'Tipo de transaccion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 446
    Width = 233
    Height = 14
    Caption = 'Sistema no Compatible con multi-Merchant'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 24
    Top = 133
    Width = 36
    Height = 19
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Text_Monto: TEdit
    Left = 72
    Top = 133
    Width = 121
    Height = 21
    Enabled = False
    NumbersOnly = True
    TabOrder = 0
  end
  object Bot_Pagar: TButton
    Left = 24
    Top = 328
    Width = 113
    Height = 57
    Caption = 'Ejecutar'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Bot_PagarClick
  end
  object Check_Impuesto: TCheckBox
    Left = 72
    Top = 160
    Width = 121
    Height = 17
    Caption = 'Impuestos incluido'
    Enabled = False
    TabOrder = 2
  end
  object TextLog: TRichEdit
    Left = 262
    Top = 109
    Width = 339
    Height = 316
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    Zoom = 100
  end
  object Text_ReferenciaN: TEdit
    Left = 134
    Top = 227
    Width = 73
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 3
    NumbersOnly = True
    ParentFont = False
    TabOrder = 4
  end
  object RadBot_Venta: TRadioButton
    Left = 24
    Top = 41
    Width = 113
    Height = 17
    Caption = 'Venta'
    TabOrder = 5
    OnClick = RadBot_VentaClick
  end
  object RadBot_Devolucion: TRadioButton
    Left = 143
    Top = 41
    Width = 113
    Height = 17
    Caption = 'Devolucion'
    TabOrder = 6
    OnClick = RadBot_DevolucionClick
  end
  object RadBot_Anular: TRadioButton
    Left = 262
    Top = 41
    Width = 113
    Height = 17
    Caption = 'Anular'
    TabOrder = 7
    OnClick = RadBot_AnularClick
  end
  object Text_HostN: TEdit
    Left = 134
    Top = 260
    Width = 73
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    NumbersOnly = True
    ParentFont = False
    TabOrder = 8
  end
  object RadBot_Venta_Lealtad: TRadioButton
    Left = 24
    Top = 64
    Width = 113
    Height = 17
    Caption = 'Venta Lealtad'
    TabOrder = 9
    OnClick = RadBot_Venta_LealtadClick
  end
  object RadBot_Venta_cuotas: TRadioButton
    Left = 143
    Top = 64
    Width = 113
    Height = 17
    Caption = 'Venta Cuotas'
    TabOrder = 10
    OnClick = RadBot_Venta_cuotasClick
  end
  object RadBot_checkIn: TRadioButton
    Left = 262
    Top = 64
    Width = 113
    Height = 17
    Caption = 'CheckIn'
    Enabled = False
    TabOrder = 11
  end
  object RadBot_CheckIn_Increment: TRadioButton
    Left = 381
    Top = 41
    Width = 113
    Height = 17
    Caption = 'CheckIn Increment'
    Enabled = False
    TabOrder = 12
  end
  object RadBot_CheckOut: TRadioButton
    Left = 381
    Top = 64
    Width = 113
    Height = 17
    Caption = 'CheckOut'
    Enabled = False
    TabOrder = 13
  end
  object Bot_Cierre: TButton
    Left = 143
    Top = 328
    Width = 113
    Height = 57
    Caption = 'Cierre'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    OnClick = Bot_CierreClick
  end
  object Bot_Log: TButton
    Left = 498
    Top = 435
    Width = 103
    Height = 29
    Caption = 'Gaurdar Log'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    OnClick = Bot_LogClick
  end
  object Text_Cuotas: TEdit
    Left = 199
    Top = 133
    Width = 55
    Height = 21
    Enabled = False
    MaxLength = 2
    NumbersOnly = True
    TabOrder = 16
    TextHint = 'Cuotas'
  end
  object ClienteECR: TIdTCPClient
    ConnectTimeout = 90000
    Host = '10.0.0.100'
    Port = 7060
    ReadTimeout = -1
    Left = 520
    Top = 8
  end
  object ServerECR: TIdTCPServer
    Bindings = <
      item
        IP = '10.0.0.103'
        Port = 2018
      end>
    DefaultPort = 0
    OnExecute = ServerECRExecute
    Left = 576
    Top = 8
  end
end
