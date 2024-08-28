//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse código foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto não me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, XMLDoc, XMLIntf;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    procedure LerDadosXML(const FileName: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  //carrega o arquivo cliente.xml que está na pasta raiz do executável
  LerDadosXML(ExtractFilePath(Application.ExeName)+'cliente.xml');
end;

procedure TForm1.LerDadosXML(const FileName: string);
var
  XMLDoc: IXMLDocument;
  RootNode, ClienteNode: IXMLNode;
  i: Integer;

begin
  XMLDoc := TXMLDocument.Create(nil);
  try

    // Define o nome do arquivo a ser carregado
    XMLDoc.LoadFromFile(FileName);

    // Define que o XML não pode ser modificado
    XMLDoc.Options := XMLDoc.Options + [doNodeAutoCreate, doNodeAutoIndent];

    // Carrega o documento XML
    XMLDoc.Active := True;

    // Obtém o nó raiz
    RootNode := XMLDoc.DocumentElement;

    Memo1.Clear;

    // Itera pelos nós de cliente
    for i := 0 to RootNode.ChildNodes.Count - 1 do
    begin
      ClienteNode := RootNode.ChildNodes[i];

      // Exibe o nome e e-mail do cliente
      Memo1.Lines.Add('Nome: '+ ClienteNode.ChildNodes['nome'].Text);
      Memo1.Lines.Add('Email: '+ ClienteNode.ChildNodes['email'].Text);
    end;
  finally
    XMLDoc := nil;
  end;
end;

end.
