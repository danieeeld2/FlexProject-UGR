%{

#include <iostream>
#include <vector>
#include <string>

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
int cont = 0;

%}

digito      [0-9]
mayus       [A-Z]
letra       [a-z]
tilde       [&]
numero      ({digito}+)
lugar       ({mayus}+{letra}*{tilde}*{letra}*)
simbolo     [\<\>\/]
salto       [\t\n]+
exclusion   [^ \t\n]+
TarLug      ("em">")
TarNum1     ("<td nowrap class="cell-odd selectable" val="")
TarNum2     ("<td nowrap class="cell-even selectable" val="")
comilla     (""")


%%

{TarLug}{salto}{lugar}{salto} {
                                    cadena = yytext;
                                    eliminar_tag1(cadena);
                                    Lugar.push_back(cadena);
}

{TarNum1|TarNum2}{numero}{comilla} {
                                    cont++;
                                    cadena = yytext;
                                    eliminar_tag2(cadena);

                                    switch (cont){
                                        case '1':
                                            Poblacion.push_back(stoi(cadena));
                                        break;

                                        case '2':
                                            Confirmados_PDIA.push_back(stoi(cadena));
                                        breal;

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

int main(int argc, char *argv[]){

    char eleccion = '0';;

    while(yyin == NULL){
        yyin = fopen("data.html", "rt");
        if(yyin != NULL){
            cout << endl << "Fichero data.html encontrado" << endl;
        }else{
            char opcion = '0';
            cout << endl << "Fichero data.html NO encontrado" << endl;
            cout << endl << "¿Desea descargar el archivo(s/n)?" << endl;

            while(opcion=='0'){
                cin >> opcion;
                if(opcion == 's' || opcion == 'S'){
                    system("curl --data 'codConsulta=42798' https://www.juntadeandalucia.es/institutodeestadisticaycartografia/badea/stpivot/stpivot/STPivot.jsp -o data.html");
                    cout << endl << "Descarga realizada" << endl;
                }else if(opcion == 'n' || opcion == 'N'){
                    cout << endl << "El fichero data.html es necesario para el funcionamiento" << endl;
                    exit(-1);
                }else{
                    opcion = '0';
                }
            }
        }
    }

    yylex();

    do{
        print_menu();
        cin >> eleccion;

        switch(eleccion){
            case '1':
                cout << "=================== Lista de distritos sanitarios ===================" << endl;
                for(int i=0; i<Lugar.lenght(); i++)
                    cout << Lugar[i] << endl;
                cout << endl;
            break;

            case '2':
                string distrito;
                cout << endl << "Introduce un distrito: ";
                cin >> distrito;
                int posicon = Lugar.find(distrito);
                if(posicon==Lugar.lenght()){
                    cout << endl << "Distrito no encontrado " << endl;
                }else{
                    cout << "=================== Datos Distrito " << distrito << " ===================" << endl;
                    cout << Lugar[posicon]
                }
            break;

            case '3':
                system("rm data.html");
                cout << endl << "Fichero html de datos borrado" << endl;
            break;

            default:
            break;                
        }

    }while(eleccion != '4')

    return 0;
}

void print_menu(){
    cout << endl << "================================================================================" << endl;
    cout << "Seleccione una de las siguientes opciones: " << endl;
    cout << "1) Mostrar lista de distritos sanitarios" << endl;
    cout << "2) Mostrar datos de un distrito sanitario" << endl;
    cout << "3) Eliminar fichero de datos" << endl;
    cout << "4) Salir" << endl << endl;
}

void eliminar_tag1(){

}

void eliminar_tag2(){
    
}