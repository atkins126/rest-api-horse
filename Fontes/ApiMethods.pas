unit ApiMethods;

interface

uses
  Horse, System.SysUtils, System.JSON, Horse.Commons;

procedure Default(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Eco(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Soma(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure UsuarioGet(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure UsuarioPost(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure UsuarioPut(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure UsuarioDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Default(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    Res.Send(
      '<!DOCTYPE html>' +
      '<html>' +
        '<head>' +
          '<meta charset="UTF-8" />' +
          '<title>Horse</title>' +
        '</head>' +
        '<body>' +
          '<h1>Horse</h1>' +
          '<h2>Server Status - Online</h2>' +
        '</body>' +
      '</html>').Status(THTTPStatus.OK);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure Eco(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  value: string;
  objeto: TJSONObject;
begin
  try
    value := '';
    if (Req.Query.ContainsKey('value')) then
      value := Req.Query.Items['value'];

    objeto := TJSONObject.Create;
    objeto.AddPair(TJSONPair.Create('result', value));
    Res.Send<TJSONObject>(objeto).Status(THTTPStatus.OK);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure Soma(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  value01: Integer;
  value02: Integer;
  objeto: TJSONObject;
begin
  try
    value01 := 0;
    if (Req.Query.ContainsKey('value01')) then
      value01 := StrToInt(Req.Query.Items['value01']);

    value02 := 0;
    if (Req.Query.ContainsKey('value02')) then
      value02 := StrToInt(Req.Query.Items['value02']);

    objeto := TJSONObject.Create;
    objeto.AddPair(TJSONPair.Create('result', IntToStr((value01 + value02))));
    Res.Send<TJSONObject>(objeto).Status(THTTPStatus.OK);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure UsuarioGet(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lista: TJSONArray;
  objeto01: TJSONObject;
  objeto02: TJSONObject;
  objeto03: TJSONObject;
begin
  try
    lista := TJSONArray.Create;

    objeto01 := TJSONObject.Create;
    objeto01.AddPair(TJSONPair.Create('nome', 'Snoopy'));
    objeto01.AddPair(TJSONPair.Create('senha', '123465'));
    lista.AddElement(objeto01);

    objeto02 := TJSONObject.Create;
    objeto02.AddPair(TJSONPair.Create('nome', 'Lola'));
    objeto02.AddPair(TJSONPair.Create('senha', '654321'));
    lista.AddElement(objeto02);

    objeto03 := TJSONObject.Create;
    objeto03.AddPair(TJSONPair.Create('nome', 'Tobias'));
    objeto03.AddPair(TJSONPair.Create('senha', '456123'));
    lista.AddElement(objeto03);

    Res.Send<TJSONArray>(lista).Status(THTTPStatus.OK);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure UsuarioPost(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  senha: string;
  usuario: string;
  dados: TJSONObject;
  objeto: TJSONObject;
begin
  try
    dados := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    objeto := TJSONObject.Create;

    usuario := '';
    if (not dados.GetValue('nome').Null) then
      usuario := dados.GetValue('nome').value;

    senha := '';
    if (not dados.GetValue('senha').Null) then
      senha := dados.GetValue('senha').value;

    objeto.AddPair(TJSONPair.Create('mensagem', 'Usu�rio ' + usuario + ' com a senha ' + senha + ', foi criado com sucesso'));
    Res.Send<TJSONObject>(objeto).Status(THTTPStatus.OK);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure UsuarioPut(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  senha: string;
  usuario: string;
  dados: TJSONObject;
  objeto: TJSONObject;
begin
  try
    dados := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    objeto := TJSONObject.Create;

    usuario := '';
    if (not dados.GetValue('nome').Null) then
      usuario := dados.GetValue('nome').value;

    senha := '';
    if (not dados.GetValue('senha').Null) then
      senha := dados.GetValue('senha').value;

    objeto.AddPair(TJSONPair.Create('mensagem', 'Usu�rio ' + usuario + ' com a senha ' + senha + ', foi atualizado com sucesso'));
    Res.Send<TJSONObject>(objeto).Status(THTTPStatus.OK);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure UsuarioDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  value: string;
  objeto: TJSONObject;
begin
  try
    value := '';
    if (Req.Query.ContainsKey('nome')) then
      value := Req.Query.Items['nome'];

    objeto := TJSONObject.Create;
    objeto.AddPair(TJSONPair.Create('mensagem', 'Usu�rio ' + value + ' exclu�do com sucesso'));
    Res.Send<TJSONObject>(objeto).Status(THTTPStatus.OK);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
