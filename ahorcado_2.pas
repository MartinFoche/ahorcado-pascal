Program ahorcado_prueba;      //mejora3
uses crt;
var
palabra_base,palabra,intento_palabra,letras_usadas:string;
longitud_palabra,intentos_fallidos,rec,termino,contador_prueba:integer;
all_in,le_pego:boolean;
int_all,intento_letra:char;

function poner_guiones(palabra: string):string;
var
   i: integer;
   resultado: string;
begin
     resultado:='';
     for i:= 1 to length(palabra) do
     begin
     if (palabra[i]=' ') or (palabra[i] = '') then
        resultado:= resultado+'_ '
     else
         resultado:= resultado+palabra[i]+' ';
     end;
     poner_guiones:=resultado;
end;

function palabra_a_adivinar(palabra_base:string;intento_letra:char;VAR palabra:string):boolean;
var
rec:integer;
le_pego: boolean;
length_palabra:integer;
begin
     le_pego:= False;
     length_palabra:= length(palabra_base);
     for rec:= 1 to length_palabra do
         begin
              if palabra_base[rec] = intento_letra then
                 begin
                 palabra[rec]:= intento_letra;
                 le_pego:= True;
                 end;
      end;
      palabra_a_adivinar:= le_pego;
end;

procedure dibujar_muneco(fallidos: integer);
begin
     gotoxy(1,10);
     writeln('_________');
     writeln('    |    ');
     writeln('    |    ');
     writeln('    J    ');
     if(fallidos > 0) then
     begin
          gotoxy(1,13);
          writeln('    O    ');
          gotoxy(1,18);
          writeln('=========');
          writeln('|       |');
     end;
     if(fallidos>1) then
     begin
          gotoxy(1,14);
          writeln('    I    ');
          writeln('    I    ');
     end;
     if(fallidos>2) then
     begin
          gotoxy(1,14);
          writeln('   /I     ');
     end;
     if(fallidos>3) then
     begin
          gotoxy(1,14);
          writeln('   /I\    ');
     end;
     if(fallidos>4) then
     begin
          gotoxy(1,16);
          writeln('   /      ');
          writeln('  /       ');
     end;
     if (fallidos>5) then
     begin
          gotoxy(1,16);
          writeln('   / \     ');
          writeln('  /   \    ');
     end;
     if (fallidos = 7) then
     begin
          gotoxy(1,14);
          writeln('   |I|    ');
          gotoxy(1,16);
          writeln('   | |    ');
          writeln('   | |    ');
          writeln('         =========');
          writeln('         |       |');
     end;
     if  (fallidos = 8) then
     begin
          gotoxy(1,10);
          writeln('         ');
          writeln('         ');
          writeln('         ');
          writeln('   \O/   ');
          writeln('    I    ');
     end;
end;

begin
     letras_usadas:='';
     intentos_fallidos:=0;
     longitud_palabra:=0;
     writeln('Ingrese una palabra para jugar al ahorcado');
     readln(palabra_base);
     longitud_palabra:= Length(palabra_base);
     clrscr;
     palabra := '';
     FillChar (palabra,length(palabra_base)+1,' ');
     all_in:= False;
     repeat
          termino:=0;
          le_pego:= False;
          clrscr;
          writeln('Vamos a jugar al ahorcado, si quiere intentar ingresar una letra presione 1');
          writeln('Si quiere intentar con una palabra presione 2[Si erra la palabra perdera]');
          writeln('Presione esc para cerrar el juego');
          gotoxy(1,23);
          writeln('Letras usadas:',upcase(letras_usadas));
          gotoxy(1,25);
          writeln(poner_guiones(palabra));
          dibujar_muneco(intentos_fallidos);
          gotoxy(1,4);
          int_all:= Readkey;
               if (int_all = '1') then
               begin
                    writeln('Ingrese la letra que quiere intentar');
                    intento_letra:=readkey;
                    le_pego:=palabra_a_adivinar(palabra_base,intento_letra,palabra);
                    writeln(palabra);
                    if not le_pego then
                       inc(intentos_fallidos);
                    letras_usadas:= letras_usadas +' ' + intento_letra;
               end
               else if int_all = '2' then
                   begin
                        all_in:=True;
                        writeln('Ingrese la palabra que desea probar:');
                        readln(intento_palabra);
                        if(palabra_base <> intento_palabra) then
                            intentos_fallidos := 7;
                   end;
               contador_prueba:=0;
               for rec:= 1 to (longitud_palabra) do
               begin
                    if palabra_base[rec] = palabra[rec] then
                       inc(contador_prueba);
               end;
               writeln(contador_prueba, longitud_palabra);
               if contador_prueba = longitud_palabra then
                  inc(termino);
               writeln(termino);
     until (intentos_fallidos > 6) or (all_in = true) or (int_all = #27) or (termino <> 0);
     clrscr;
     if(int_all <> #27) then
     begin
          gotoxy(1,21);
          if (intentos_fallidos > 6) then
             writeln(' Perdiste, la palabra era: ',palabra_base)
          else
          begin
               intentos_fallidos := 8;
               writeln(' ',palabra_base);
               writeln(' Ganaste');
          end;
          dibujar_muneco(intentos_fallidos);
          readkey;
     end;
end.
