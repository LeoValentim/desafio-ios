# Desafio Tembici

### Detalhes e requisitos:
-  Xcode 10.2.1
-  Swift 5
-  CocoaPods 1.6.1

---
### Bibliotecas utilizadas:
- `Alamofire` Requisições HTTP
- `Realm` Banco de Dados Local
- `JGProgressHUD` Indicador de loading

---
### Arquitetura:
O projeto foi feito em VIPER, a estrutura de arquivos é baseada em três camadas principais:
- *Modules*: Contém as cenas separadas por modulos. Cada cena tem seu Presenter, Interector, Router e View.
- *Entities:* Foi separada da camada *Modules* por ter modelos e casos de uso comuns em todos os Modulos.
- *Services:* Contém as classes de Network, APILayer, DatabaseManager...

