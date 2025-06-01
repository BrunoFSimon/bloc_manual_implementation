## Padrões de BLoC

Neste projeto, seguimos padrões específicos para a implementação de BLoCs para garantir consistência e clareza.

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
