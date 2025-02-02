﻿unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdCustomTCPServer,
  IdTCPServer, IdContext, Vcl.ComCtrls, IdGlobal, strutils, IdSocketHandle;

type
TByteArr = array of byte;

  TPosConnect = class(TForm)
    Text_Monto: TEdit;
    Label1: TLabel;
    Bot_Pagar: TButton;
    ClienteECR: TIdTCPClient;
    Check_Impuesto: TCheckBox;
    ServerECR: TIdTCPServer;
    Text_ReferenciaN: TEdit;
    Label2: TLabel;
    RadBot_Venta: TRadioButton;
    RadBot_Devolucion: TRadioButton;
    RadBot_Anular: TRadioButton;
    Label3: TLabel;
    Text_HostN: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    TextLog: TRichEdit;
    RadBot_Venta_Lealtad: TRadioButton;
    RadBot_Venta_cuotas: TRadioButton;
    RadBot_checkIn: TRadioButton;
    RadBot_CheckIn_Increment: TRadioButton;
    RadBot_CheckOut: TRadioButton;
    Label6: TLabel;
    Label7: TLabel;
    Bot_Cierre: TButton;
    Bot_Log: TButton;
    Text_Cuotas: TEdit;
   // procedure Button1Click(Sender: TObject);
    procedure ServerECRExecute(AContext: TIdContext);
    procedure Bot_PagarClick(Sender: TObject);
    procedure Bot_LogClick(Sender: TObject);
    procedure RadBot_VentaClick(Sender: TObject);
    procedure RadBot_DevolucionClick(Sender: TObject);
    procedure RadBot_Venta_LealtadClick(Sender: TObject);
    procedure RadBot_Venta_cuotasClick(Sender: TObject);
    procedure RadBot_AnularClick(Sender: TObject);
    procedure Bot_CierreClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    function Enquire(): String;
    function Syschronous() : String;
    function Mi_trama() : string;
    function Tipo_transacion() : string;
    procedure ConnectToPOS();
    procedure Configurando();
    procedure AnalisisRespuesta();
end;

const
ENQ : String = '';
SYN : String = '';
ACK : String = '';
EOM : String = '';
EOT : String = '♦ ';
FS : String = '';

var
PosConnect : TPosConnect;
Trama : String;
Contenedor : String;
Datos : array of string;
Impuesto : Double;
Respuesta : TArray<string>;
CadenaDat : string;

implementation

{$R *.dfm}

// ====>>>> Funciones -- Programa Modo Cliente -- <<<<====
// ====>>>> Escribiendo ENQ y SYNC para Establecer Conexion con POS <<<<====

Function TPosConnect.Enquire() : String;
var
buffer : String;
begin
 ClienteECR.Connect();
 ClienteECR.Socket.Write(ENQ);
 buffer := ClienteECR.Socket.ReadChar();
 if buffer = ACK then
 begin
  ClienteECR.Disconnect();
  result := buffer;
 end
 else
 ShowMessage('Error Al resibir ACK');
end;

Function TPosConnect.Syschronous() : String;
var
buffer : String;
begin
ClienteECR.Connect;
ClienteECR.Socket.Write(SYN);
buffer := ClienteECR.Socket.ReadChar();
if buffer = EOM then
begin
  ClienteECR.Disconnect;
  result := buffer
end
else
  ShowMessage('Error Al resibir EOM');
end;

// ====>>>> Programa Modo Servidor Escribiendo y leyendo datos del POS <<<<====


procedure TPosConnect.ServerECRExecute(AContext: TIdContext);
var
I : integer;
begin
  //Escribiendo la trama y leyendo la respuesta
  AContext.Connection.Create;
  Contenedor := Acontext.Connection.Socket.readChar;
  if Contenedor = ENQ then
  begin
    Acontext.Connection.Socket.Write(Trama);
     Contenedor := AContext.Connection.Socket.ReadChar;

     if contenedor = ACK then
     begin
        try
          while Contenedor <> EOT  do
          begin
          //Contenedor := AContext.Connection.Socket.ReadChar;
          Contenedor := AContext.Connection.Socket.ReadLn();
          Acontext.Connection.Socket.Write(ACK);
          //Textlog.lines.Add(Contenedor)
          end;
          ShowMessage('Ya Salio!');
        finally
          AnalisisRespuesta();
        end;
     end;
  end;
end;

// ====>>>> Formando la respuesta del POS <<<<====

procedure TPosConnect.AnalisisRespuesta();
var
I : integer;
begin
  //Codigo Auxiliar para imprimir las pocisiones De los valores
  { for I := 0 to length(Respuesta)-1 do
  begin
  TextLog.Lines.Add('Pos:' + inttostr(I) + ' : '+ Respuesta[I]);
  end; }

  // Separando los valores de la respuesta
  Respuesta := Contenedor.split(FS);

  // Mostrando los valores de la respuesta del POS
  IF Trama = 'CN01' then
  begin
    if Respuesta[0] = '00' then
    begin
      Textlog.lines.Add('Cierre de : ' + Respuesta[1]);
      Textlog.lines.Add('Fecha : ' + Respuesta[4]);
      Textlog.lines.Add('Hora : ' + Respuesta[5]);
      Textlog.lines.Add('Cantidad Devoluciones : ' + Respuesta[6]);
      Textlog.lines.Add('Total Devoluciones : ' + floattostr(strtofloat(Respuesta[7]) / 100));
      Textlog.lines.Add('ITBIS Devoluciones : ' + floattostr(strtofloat(Respuesta[8]) / 100));
      Textlog.lines.Add('Cantidad Ventas : ' + Respuesta[9]);
      Textlog.lines.Add('Total Ventas : ' + floattostr(strtofloat(Respuesta[10]) / 100));
      Textlog.lines.Add('ITBIS Ventas : ' + floattostr(strtofloat(Respuesta[11]) / 100));
      Textlog.lines.Add('Otros ITBIS : ' + floattostr(strtofloat(Respuesta[12]) / 100));
    end
    else
    begin
      ShowMessage('Error Al momento del cierre.');
    end;
  end
  else
  begin
    IF tipo_transacion() = 'CN02' then
    begin
      if contenedor = '00' then
      ShowMessage('Anulaccion correcta')
      else
      ShowMessage('Error al Anular : ' + contenedor);
    end
    else
    begin
      Textlog.lines.Add('Tipo de tarjeta : ' + Respuesta[0]);
      Textlog.lines.Add('Marca Tarjeta : ' + Respuesta[1]);
      Textlog.lines.Add('No Tarjeta : ' + Respuesta[3]);
      Textlog.lines.Add('Fecha : ' + Respuesta[5]);
      Textlog.lines.Add('Hora : ' + Respuesta[6]);
      Textlog.lines.Add('Nombre Titular : ' + Respuesta[7]);
      Textlog.lines.Add('No de transacion : ' + Respuesta[10]);
    end;
  end;
end;

// ====>>>> Boton Pagar <<<<====

procedure TPosConnect.Bot_PagarClick(Sender: TObject);
begin
   Trama := Mi_trama();
   //TextLog.Lines.Add(Trama);
   ConnectToPOS();
end;

// ====>>>> Creacion de la Trama  <<<<====

Function TPosConnect.Mi_trama() : string;
var
Ceros : Integer;
Cadena : string;
Impuesto : double;
I: Integer;
begin
   setlength(Datos,6);
   Datos[0] := Tipo_transacion();

   // Numeros de Cuotas
   if RadBot_venta_cuotas.Checked = true then
   begin
     {Cantidad de cuotas} Datos[5] := Text_Cuotas.Text;
   end;

   // Caso Anulacion
   if RadBot_anular.Checked = true then
   begin
     {Tipo de Host} Datos[1] := Text_HostN.Text;
     {No Referencia} Datos[2] := Text_ReferenciaN.Text;
   end
   // Asignando valores a trama Normales
   else
   begin
     // Calculando impuesto
        // Nota aqui no redondeo el monto de ITBIS
        // Limita solo los dos primeros decimales
     if Check_impuesto.Checked = false then
     begin
        {Monto} Datos[1] := floattostr((strtofloat(Text_monto.Text) * 1.18 ) * 100);
        Impuesto := strtofloat(Text_monto.Text) * 0.18;
        Datos[2] := FormatFloat('0.00',impuesto);
        Impuesto := strtofloat(Datos[2]) * 100;
        Datos[2] := floattostr(Impuesto);
     end
     else
     begin
        {Monto} Datos[1] := floattostr(strtofloat(Text_monto.Text) * 100);
        Impuesto := strtofloat(Text_monto.Text) - (strtofloat(Text_monto.Text) / 1.18);
        Datos[2] := FormatFloat('0.00',impuesto);
        Impuesto := strtofloat(Datos[2]) * 100;
        Datos[2] := floattostr(Impuesto);
     end;

     {Otro Impuestos} Datos[3] := Stringofchar('0',12);
     {Numero de la factura en NemeSys} Datos[4] := '000100';

     //Agregando Ceros a la izquierda Monto y al ITBIS
     Ceros := 12 - Datos[1].Length;
     Datos[1] := stringofchar('0',Ceros) + Datos[1];
     Ceros := 12 - Datos[2].Length;
     Datos[2] := stringofchar('0',Ceros) + Datos[2];
   end;

   Cadena := '';

   //Dando Forma a la trama

   if RadBot_anular.Checked = true then
   begin
     for I := 0 to 2 do
     begin
     Cadena := Cadena + Datos[I] + FS;
     end;
   end;

   if NOT RadBot_venta_cuotas.Checked and NOT RadBot_anular.Checked then
   begin
     for I := 0 to 4 do
     begin
     Cadena := Cadena + Datos[I] + FS;
     end;
   end;

   if RadBot_venta_cuotas.Checked then
   begin
     for I := 0 to 5 do
     begin
     Cadena := Cadena + Datos[I] + FS;
     end;
   end;

   // Eliminando el ultimo Espacio
   cadena := copy(cadena,1,length(cadena) - 1);
   Result := Cadena;
end;

function TPosConnect.Tipo_transacion() : string;
begin
     if RadBot_Venta.Checked then
     result := 'CN00';
     if RadBot_Devolucion.Checked then
     result := 'CN03';
     if RadBot_Venta_cuotas.Checked then
     result := 'CU00';
     if RadBot_Venta_lealtad.Checked then
     result := 'PU00';
     if RadBot_Anular.Checked then
     result := 'CN02';
end;


// ====>>>> Controles de activaciones de campos <<<<====

procedure TPosConnect.RadBot_AnularClick(Sender: TObject);
begin
Text_HostN.Enabled := true;
Text_ReferenciaN.Enabled := true;
Text_Monto.Enabled := False;
Check_Impuesto.Enabled := False;
Text_Cuotas.Enabled := False;
Bot_pagar.Enabled := true;
end;

procedure TPosConnect.RadBot_DevolucionClick(Sender: TObject);
begin
Text_Monto.Enabled := true;
Check_Impuesto.Enabled := true;
Text_HostN.Enabled := False;
Text_ReferenciaN.Enabled := False;
Text_Cuotas.Enabled := False;
Bot_pagar.Enabled := true;
end;

procedure TPosConnect.RadBot_VentaClick(Sender: TObject);
begin
Text_Monto.Enabled := true;
Check_Impuesto.Enabled := true;
Text_HostN.Enabled := False;
Text_ReferenciaN.Enabled := False;
Text_Cuotas.Enabled := False;
Bot_pagar.Enabled := true;
end;

procedure TPosConnect.RadBot_Venta_cuotasClick(Sender: TObject);
begin
Text_Monto.Enabled := true;
Check_Impuesto.Enabled := true;
Text_Cuotas.Enabled := true;
Text_HostN.Enabled := False;
Text_ReferenciaN.Enabled := False;
Bot_pagar.Enabled := true;
end;

procedure TPosConnect.RadBot_Venta_LealtadClick(Sender: TObject);
begin
Text_Monto.Enabled := true;
Check_Impuesto.Enabled := true;
Text_HostN.Enabled := False;
Text_ReferenciaN.Enabled := False;
Text_Cuotas.Enabled := False;
Bot_pagar.Enabled := true;
end;

// ====>>>> Guardando Log Revisar <<<<====


procedure TPosConnect.Bot_LogClick(Sender: TObject);
begin
Textlog.Lines.SaveToFile('C:\LogCardNet\log.txt');
ShowMessage('Log Guardado de manera correcta');
end;


// ====>>>> Funcion para Iniciar la Comunicacion con el POS  <<<<====

procedure TPosConnect.ConnectToPOS();
begin

    if Enquire = ACK then
      if Syschronous = EOM then
      begin
        ServerECR.StartListening;
        ServerECR.Active := true;
      end;
end;

// ====>>>> Configurando mi Sockect del Lado cliente y servidor <<<<====
// ====>>>> Nota no llamo a este procedimiento ya que tengo los valores por default <<<<====

procedure TPosConnect.Configurando();
begin
  // TCPCliente
  ClienteECR.ConnectTimeout := 90000;
  ClienteECR.ReadTimeout := -1;
  ClienteECR.port := 7060; // puerto default
  ClienteECR.Host := '10.0.0.100';  // IP del POS
  // TCPServidor
  ServerECR.DefaultPort  := 0;
  ServerECR.Bindings.Add.IP := '10.0.0.101'; // IP de la CAJA o ECR Debe estar Fijo
  ServerECR.Bindings.Add.Port := 2018;  // puerto default
end;

// ====>>>> Boton del cierre  <<<<====

procedure TPosConnect.Bot_CierreClick(Sender: TObject);
begin
  Trama := 'CN01';
  ConnectToPOS();
end;

end.
