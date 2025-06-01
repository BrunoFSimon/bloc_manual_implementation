## Padrões de BLoC

Neste projeto, seguimos padrões específicos para a implementação de BLoCs para garantir consistência e clareza.

### Nomenclatura de Arquivos do BLoC

Para manter a organização, os arquivos relacionados a um BLoC específico seguem o padrão:
*   **BLoC Principal:** `nome_do_bloc.dart` (ex: `input_bloc.dart`) - Contém a classe principal do BLoC.
*   **Eventos:** `nome_do_bloc_event.dart` (ex: `input_bloc_event.dart`) - Define a `sealed class` base para eventos e suas classes concretas.
*   **Estados:** `nome_do_bloc_state.dart` (ex: `input_bloc_state.dart`) - Define a `sealed class` base para estados e suas classes concretas.


### Eventos do BLoC (`BlocEvent`)

Os eventos representam ações do usuário ou ocorrências do sistema que o BLoC precisa processar.

1.  **Classe Base Selada (`sealed class`):**
    *   Cada BLoC terá um arquivo `_event.dart` (ex: `input_bloc_event.dart`) que define uma `sealed class` como base para todos os seus eventos.
    *   Exemplo: `sealed class InputBlocEvent {}`
    *   Isso permite que o Dart verifique em tempo de compilação se todos os tipos de eventos estão sendo tratados no BLoC.

2.  **Classes de Evento Concretas:**
    *   Cada ação específica é uma classe que estende a classe base selada.
    *   Exemplo: `class SetWeightInputEvent extends InputBlocEvent {}`

3.  **Imutabilidade:**
    *   Todas as propriedades dentro das classes de evento devem ser declaradas como `final`.
    *   Os construtores devem ser `const` sempre que possível.
    *   Exemplo:
        ```dart
        class SetWeightInputEvent extends InputBlocEvent {
          final String weight;
          const SetWeightInputEvent(this.weight);
        }
        ```

4.  **Nomenclatura:**
    *   Para eventos que representam a alteração de um campo de entrada, usamos o padrão: `Set<NomeDoCampo>InputEvent` (ex: `SetWeightInputEvent`).
    *   Para outros tipos de eventos, buscamos nomes descritivos que indiquem a ação (ex: `LoadDataEvent`, `SubmitFormEvent`).

5.  **Payloads:**
    *   As classes de evento carregam os dados (payload) necessários para o BLoC processar o evento. Esses dados são passados como parâmetros no construtor e armazenados em propriedades `final`.

### Estados do BLoC (`BlocState`)

Os estados representam a condição ou os dados atuais do BLoC, que a UI (Interface do Usuário) ou outros componentes podem observar e reagir. Para o `InputBloc`, os seguintes padrões são aplicados:

1.  **Classe Base Selada (`sealed class`):**
    *   É definida uma classe base selada, `InputBlocState`, no arquivo `input_bloc_state.dart`.
    *   Exemplo: `sealed class InputBlocState { const InputBlocState(); }`
    *   O uso de `sealed` permite que o compilador Dart verifique se todos os subtipos de estado estão sendo tratados em estruturas como `switch` ou nos `listeners/builders` de widgets do Flutter, garantindo um tratamento exaustivo dos estados.

2.  **Classes de Estado Concretas:**
    *   Cada estado específico do BLoC é uma classe que estende `InputBlocState`.
    *   Para o `InputBloc`, temos:
        *   `InitialInputBlocState`: Representa o estado inicial do BLoC, definindo valores padrão para `weight` e `height`.
        *   `SuccessInputBlocState`: Representa um estado de sucesso ou um estado onde os dados (`weight` e `height`) são válidos e estão prontos para serem usados.
        *   `ErrorInputBlocState`: Representa um estado de erro, contendo informações sobre os erros ocorridos para `weight` e/ou `height`, além dos valores atuais desses campos.

3.  **Imutabilidade:**
    *   Todas as propriedades dentro das classes de estado são declaradas como `final`.
    *   Os construtores são `const` para garantir que as instâncias de estado sejam imutáveis e possam ser otimizadas pelo compilador.
    *   Exemplo (`SuccessInputBlocState`):
        ```dart
        class SuccessInputBlocState extends InputBlocState {
          final double weight;
          final double height;

          const SuccessInputBlocState({required this.weight, required this.height});
        }
        ```

4.  **Nomenclatura:**
    *   Estado inicial: `Initial<NomeDoBloco>State` (ex: `InitialInputBlocState`).
    *   Estado de sucesso/dados válidos: `Success<NomeDoBloco>State` (ex: `SuccessInputBlocState`).
    *   Estado de erro: `Error<NomeDoBloco>State` (ex: `ErrorInputBlocState`).

5.  **Payloads (Dados do Estado):**
    *   As classes de estado carregam os dados necessários para a UI se reconstruir ou para lógica de negócios.
    *   `InitialInputBlocState`: Define valores iniciais para os campos gerenciados.
        ```dart
        class InitialInputBlocState extends InputBlocState {
          final double weight = 0.0; // Valor padrão
          final double height = 0.0; // Valor padrão
          const InitialInputBlocState();
        }
        ```
    *   `SuccessInputBlocState`: Carrega os dados validados ou processados.
        ```dart
        class SuccessInputBlocState extends InputBlocState {
          final double weight; // Dado validado
          final double height; // Dado validado
          // ...
        }
        ```
    *   `ErrorInputBlocState`: Carrega os valores atuais de `weight` e `height` (que podem ser os últimos válidos ou os que causaram o erro) e as mensagens de erro. Os campos de erro (`weightError`, `heightError`) são anuláveis (`String?`) pois um erro para um campo específico pode ou não estar presente.
        ```dart
        class ErrorInputBlocState extends InputBlocState {
          final double weight;
          final double height;
          final String? weightError; // Mensagem de erro para o peso, opcional
          final String? heightError; // Mensagem de erro para a altura, opcional
          const ErrorInputBlocState({
            required this.height,
            required this.weight,
            required this.weightError, // Mesmo sendo String?, é required no construtor para passar null explicitamente se for o caso
            required this.heightError, // Mesmo sendo String?, é required no construtor para passar null explicitamente se for o caso
          });
        }
        ```
