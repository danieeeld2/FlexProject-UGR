%option noyywrap

%{

#include <iostream>
#include <vector>
#include <string>
#include <stdio.h>
#include <cstdlib>
#include <fstream>

using namespace std;

vector<string> Lugar;
vector<int> Poblacion;
vector<int> Confirmados_PDIA;
vector<int> Confirmados_PDIA_14dias;
vector<int> Tasa_PDIA_14dias;
vector<int> Confirmados_PDIA_7dias;
vector<int> Tasa_PDIA_7dias;
vector<int> Total_Confirmados;
vector<int> Curados;
vector<int> Fallecidos;

string cadena;
ifstream yyin;
int cont = 0;
int aux = 0;

void eliminar_tag1(string a){

}

void eliminar_tag2(string b){
    
}


%}

digito      [0-9]
mayus       [A-Z]
letra       [a-z]
tilde       .
numero      ({digito}+)
lugar       ({mayus}+{letra}*{tilde}*{letra}*)
lugarespa   ({lugar}\b{lugar})
sitio       ({lugar}|{lugarespa}+)
simbolo     [\<\>\/]
salto       [\t\n]+
exclusion   [^ \t\n]+
TarLug      ("<caption caption=")
TarFin      ("/>")
TarNum      ("val=")
TarNFin     (".0")
comilla     ("\"")


%%

{TarLug}{comilla}{sitio}{comilla}{TarFin} {
                                    if(aux>=13){    
                                        cadena = string(YYText());
                                        eliminar_tag1(cadena);
                                        Lugar.push_back(cadena);
                                    }
                                    aux++;
}

{TarNum}{comilla}{numero}{TarNFin} {
                                    cont++;
                                    cadena = yytext;
                                    eliminar_tag2(cadena);

                                    switch (cont){
                                        case '1':
                                            Poblacion.push_back(stoi(cadena));
                                        break;

                                        case '2':
                                            Confirmados_PDIA.push_back(stoi(cadena));
                                        break;

                                        case '3':
                                        break;

                                        case '4':
                                            Confirmados_PDIA_14dias.push_back(stoi(cadena));
                                        break;

                                        case '5':
                                            Tasa_PDIA_14dias.push_back(stoi(cadena));
                                        break;

                                        case '6':
                                            Confirmados_PDIA_7dias.push_back(stoi(cadena));
                                        break;

                                        case '7':
                                            Tasa_PDIA_7dias.push_back(stoi(cadena));
                                        break;

                                        case '8':
                                            Total_Confirmados.push_back(stoi(cadena));
                                        break;

                                        case '9':
                                        break;

                                        case '10':
                                            Curados.push_back(stoi(cadena));
                                        break;

                                        case '11':
                                            Fallecidos.push_back(stoi(cadena));
                                            cont=0;
                                        break;
                                    }
}

%%


void print_menu(){
    cout << endl << "================================================================================" << endl;
    cout << "Seleccione una de las siguientes opciones: " << endl;
    cout << "1) Mostrar lista de distritos sanitarios" << endl;
    cout << "2) Mostrar datos de un distrito sanitario" << endl;
    cout << "3) Eliminar fichero de datos" << endl;
    cout << "4) Salir" << endl << endl;
}

int main(int argc, char *argv[]){
    char eleccion = '0';
    string distrito;
    int posicion = 0;
    bool encontrado = false;

    yyin.open("data.html");
    if(!yyin){
        char opcion = '0';
        cout << endl << "Fichero data.html NO encontrado" << endl;
        cout << endl << "¿Desea descargar el archivo(s/n)?" << endl;

        while(opcion=='0'){
            cin >> opcion;
            if(opcion == 's' || opcion == 'S'){
                system("curl --data 'codConsulta=42798' https://www.juntadeandalucia.es/institutodeestadisticaycartografia/badea/stpivot/stpivot/STPivot.jsp -o data.html");
                cout << endl << "Descarga realizada" << endl;
                yyin.open("data.html");
            }else if(opcion == 'n' || opcion == 'N'){
                cout << endl << "El fichero data.html es necesario para el funcionamiento" << endl;
                exit(-1);
            }else{
                opcion = '0';
            }
        }
    }else{
        cout << endl << "Fichero data.html encontrado" << endl;
    }

    yyFlexLexer flujo(&yyin,0);
    flujo.yylex();
    system("clear");

    do{
        print_menu();
        cin >> eleccion;

        switch(eleccion){
            case '1':
                cout << "=================== Lista de distritos sanitarios ===================" << endl;
                for(int i=0; i<Lugar.size(); i++)
                    cout << Lugar[i] << endl;
                cout << endl;
            break;

            case '2':
                cout << endl << "Introduce un distrito: ";
                cin >> distrito;
                posicion = Lugar.size();
                for(int i=0; i<Lugar.size() && !encontrado;i++){
                    if(Lugar[i] == distrito){
                        posicion = i;
                        encontrado = true;
                    }
                }
                if(posicion==Lugar.size()){
                    cout << endl << "Distrito no encontrado " << endl;
                    cout << "Poblacion:\t" << Poblacion[0] << endl;
                }else{
                    cout << "=================== Datos Distrito " << distrito << " ===================" << endl;
                    cout << "Poblacion:\t" << Poblacion[posicion] << endl;
                    cout << "Confirmados PDIA:\t" << Confirmados_PDIA[posicion] << endl;
                    cout << "Confirmados PDIA 14 días:\t" << Confirmados_PDIA_14dias[posicion] << endl;
                    cout << "Tasa PDIA 14 días:\t" << Tasa_PDIA_14dias[posicion] << endl;
                    cout << "Confimados PDIA 7 días:\t" << Confirmados_PDIA_7dias[posicion] << endl;
                    cout << "Tasa PDIA 7 días:\t" << Tasa_PDIA_7dias[posicion] << endl;
                    cout << "Total Confirmados:\t" << Total_Confirmados[posicion] << endl;
                    cout << "Curados:\t" << Curados[posicion] << endl;
                    cout << "Fallecidos:\t" << Fallecidos[posicion] << endl;
                }
                encontrado = false;
            break;

            case '3':
                system("rm data.html");
                cout << endl << "Fichero html de datos borrado" << endl;
            break;

            default:
            break;                
        }

    }while(eleccion != '4');

    return 0;
}
