# SACE

[![SACE](https://www.sgb.gov.br/documents/20119/489133/Capturar.png/ad5955af-0229-08f7-e31d-ce83d997c675?t=1716386946274)](https://www.sgb.gov.br/sace/)

Este chart implementa o aplicativo SACE em sistemas baseados em Kubernetes

## Pré-requisitos

Liste quaisquer pré-requisitos que precisam ser atendidos antes de instalar este Chart Helm. Isso pode incluir:

* Helm instalado (versão 3 ou superior recomendada)
* Kubernetes cluster em execução (testado em OpenShift local e OCP)
* `kubectl` configurado para interagir com o seu cluster (`oc`, no caso de OpenShift)

## Instalando o Chart

Para instalar o chart com um nome de release de `sace`:

```bash
helm repo add <nome-do-repositorio> https://sgb-cprm.github.io/sace-helm/
helm repo update

helm install <nome-da-release> <nome-do-chart>
# ou
helm install <nome-da-release> <nome-do-repositorio>/<nome-do-chart>
# ou para instalar de um caminho local
helm install <nome-da-release> ./<caminho-para-o-chart>
```

## Desinstalando o Chart

Para desinstalar a release `sace`:

```bash
helm uninstall sace
```

## Configuração

A tabela abaixo lista os parâmetros configuráveis do chart e seus valores padrão. Você pode sobrescrever esses valores durante a instalação ou em um arquivo `values.yaml` personalizado.

## Configurações Gerais

| Chave                 | Valor Padrão | Descrição                                      |
| --------------------- | ------------ | ---------------------------------------------- |
| `replicaCount`        | `1`          | Número de réplicas do pod.                     |
| `nameOverride`        | `""`         | Sobrescreve o `name` do chart.                  |
| `fullnameOverride`    | `""`         | Sobrescreve o nome completo dos recursos.     |

## Configurações da Imagem

| Chave             | Valor Padrão             | Descrição                                               |
| ----------------- | ------------------------ | ------------------------------------------------------- |
| `image.repository`| `docker.io/edneyego/sace` | Repositório da imagem Docker.                           |
| `image.pullPolicy`| `IfNotPresent`           | Política de pull da imagem Docker.                      |
| `image.tag`       | `""`                     | Tag da imagem Docker (sobrescreve a appVersion).        |
| `imagePullSecrets`| `[]`                     | Segredos para pull de imagens de repositórios privados. |

## Configurações da Conta de Serviço

| Chave                     | Valor Padrão | Descrição                                                                                                |
| ------------------------- | ------------ | -------------------------------------------------------------------------------------------------------- |
| `serviceAccount.create`   | `false`      | Especifica se uma conta de serviço deve ser criada.                                                      |
| `serviceAccount.annotations`| `{}`         | Anotações a serem adicionadas à conta de serviço.                                                      |
| `serviceAccount.name`     | `""`         | Nome da conta de serviço a ser usada (se `create` for true e não definido, um nome é gerado).            |

## Configurações do Pod

| Chave                 | Valor Padrão             | Descrição                                          |
| --------------------- | ------------------------ | ---------------------------------------------------- |
| `podAnnotations`      | `{}`                     | Anotações a serem adicionadas aos pods.              |
| `podSecurityContext`  | `{}` (`# fsGroup: 2000`) | Contexto de segurança do pod.                        |
| `securityContext`     | `{}` (`# capabilities: ...`, `# readOnlyRootFilesystem: ...`, `# runAsNonRoot: ...`, `# runAsUser: ...`) | Contexto de segurança dos containers.                    |
| `nodeSelector`        | `{}`                     | Seletor de nós para agendamento de pods.             |
| `tolerations`         | `[]`                     | Tolerâncias para taint nodes.                         |
| `affinity`            | `{}`                     | Regras de afinidade e anti-afinidade para pods.       |

## Configurações do Serviço

| Chave         | Valor Padrão | Descrição                         |
| ------------- | ------------ | --------------------------------- |
| `service.type`| `ClusterIP`  | Tipo do serviço Kubernetes.       |
| `service.port`| `8082`       | Porta do serviço Kubernetes.      |

## Configurações de Recursos e Auto Scaling

| Chave                                    | Valor Padrão             | Descrição                                                                 |
| ---------------------------------------- | ------------------------ | ------------------------------------------------------------------------- |
| `resources`                              | `{}` (`# limits: ...`, `# requests: ...`) | Solicitações e limites de recursos para os containers.            |
| `autoscaling.enabled`                    | `false`                  | Habilita o auto scaling horizontal.                                         |
| `autoscaling.minReplicas`                | `1`                      | Número mínimo de réplicas para o auto scaling.                             |
| `autoscaling.maxReplicas`                | `5`                      | Número máximo de réplicas para o auto scaling.                             |
| `autoscaling.targetCPUUtilizationPercentage` | `80`                     | Percentual alvo de utilização da CPU para o auto scaling.              |
| `autoscaling.targetMemoryUtilizationPercentage` | `# 80`                   | Percentual alvo de utilização da memória (atualmente comentado). |

## Configurações do Volume Persistente (PVC)

| Chave                   | Valor Padrão      | Descrição                                                                 |
| ----------------------- | ----------------- | ------------------------------------------------------------------------- |
| `pvc.enabled`           | `true`            | Habilita o Volume Persistente.                                            |
| `pvc.keep`              | `true`            | Mantém o PVC ao deletar o Helm release.                                   |
| `pvc.storage.className` | `""`              | Classe de armazenamento para o PVC.                                       |
| `pvc.storage.size`      | `5Gi`             | Tamanho do Volume Persistente.                                            |
| `pvc.storage.accessModes`| `- ReadWriteOnce` | Modos de acesso do Volume Persistente.                                   |

## Configurações da Aplicação (`config`)

| Chave                             | Valor Padrão                                             | Descrição                                                                                                                               |
| --------------------------------- | -------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `config.default.name`             | `default`                                                | Nome da configuração padrão do SACE.                                                                                                      |
| `config.default.title`            | `SACE Web`                                               | Título da interface web do SACE.                                                                                                        |
| `config.default.url`              | `""`                                                     | URL base da aplicação SACE.                                                                                                             |
| `config.default.imageDir`         | `/mnt/sace/data`                                         | Diretório para imagens dentro do container SACE.                                                                                          |
| `config.default.bounds.minX`      | `-75`                                                    | Limite mínimo da coordenada X, em graus decimais.                                                                                                            |
| `config.default.bounds.minY`      | `-35`                                                    | Limite mínimo da coordenada Y, em graus decimais.                                                                                                            |
| `config.default.bounds.maxX`      | `-35`                                                    | Limite máximo da coordenada X, em graus decimais.                                                                                                            |
| `config.default.bounds.maxY`      | `6`                                                      | Limite máximo da coordenada Y, em graus decimais.                                                                                                             |
| `config.default.enableScheduling`  | `false`                                                  | Habilita o agendamento de tarefas no SACE.                                                                                                |
| `config.default.enableRetrieve`    | `false`                                                  | Habilita a função de recuperação de dados no SACE.                                                                                          |
| `config.default.jvm.xmx`           | `3096`                                                   | Tamanho máximo de memória para a JVM do SACE (em MB).                                                                                      |
| `config.default.jvm.xms`           | `2098`                                                   | Tamanho inicial de memória para a JVM do SACE (em MB).                                                                                      |
| `config.default.db.url`            | `jdbc:postgresql://postgresdb:5432/sace`                 | URL de conexão com o banco de dados PostgreSQL do SACE.                                                                     |
| `config.default.db.user`           | `postgres`                                               | Usuário do banco de dados PostgreSQL do SACE.                                                                                              |
| `config.default.db.pass`           | `postgres`                                               | Senha do banco de dados PostgreSQL do SACE.                                                                                              |
| `config.default.geoserver.workspace`| `main`                                                   | Workspace padrão do GeoServer.                                                                                                            |
| `config.default.geoserver.url`    | `/geoserver`                                           | URL do GeoServer.                                                                                                     |



## Configurações por Bacia (`config`)

| Chave                             | Valor Padrão       | Descrição                                                |
| --------------------------------- | ------------------ | -------------------------------------------------------- |
| `config.basins`                   | `[]`               | Configurações de bacias. Essas comfigurações sobrepõem as configurações `default`, os parâmetros são os mesmos de `default`.                                 |
| `config.selectedBasins`           | `[]`               | Bacias selecionadas, a partir do parâmetro `name`. As bacias selecionadas serão expostas no Nginx, via proxy reverso.                                    |

## Configurações do Nginx (proxy reverso)

| Chave                                  | Valor Padrão                | Descrição                                                                                                                                  |
| -------------------------------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `nginx.ingress.enabled`                | `true`                      | Habilita o Ingress do Nginx.                                                                                                               |
| `nginx.ingress.annotations`            | `{}`                        | Anotações para o Ingress do Nginx.                                                                                                         |
| `nginx.ingress.hosts[0].host`           | `sace.apps-crc.testing`     | Hostname para o Ingress do Nginx.                                                                                                        |
| `nginx.ingress.hosts[0].paths[0].path`  | `/`                         | Caminho para o Ingress do Nginx.                                                                                                           |
| `nginx.ingress.hosts[0].paths[0].pathType`| `ImplementationSpecific`    | Tipo de caminho para o Ingress do Nginx.                                                                                                  |
| `nginx.ingress.tls`                    | `[]`                        | Configurações de TLS para o Ingress do Nginx.                                                                                              |
| `nginx.overrides.default.type`         | `configMap`                 | Tipo de override padrão do Nginx (ConfigMap).                                                                                              |
| `nginx.overrides.default.name`         | `sace-nginx-default-conf`   | Nome do ConfigMap de override padrão do Nginx.                                                                                            |
| `nginx.overrides.default.enabled`      | `true`                      | Habilita o override padrão do Nginx.                                                                                                       |
| `nginx.overrides.html.type`            | `configMap`                 | Tipo de override HTML do Nginx (ConfigMap).                                                                                                |
| `nginx.overrides.html.name`            | `sace-nginx-html`           | Nome do ConfigMap de override HTML do Nginx.                                                                                              |
| `nginx.overrides.html.enabled`         | `true`                      | Habilita o override HTML do Nginx.                                                                                                          |

Mais detalhes sobre as configurações do chart do Geoserver estão disponíveis em https://github.com/nds-cprm/helm-charts/tree/main/charts/nginx

## Configurações do GeoServer

| Chave             | Valor Padrão | Descrição                               |
| ----------------- | ------------ | --------------------------------------- |
| `geoserver.enabled`| `false`      | Indica se o GeoServer está habilitado. |

Mais detalhes sobre as configurações do chart do `Geoserver` estão disponíveis em https://github.com/nds-cprm/helm-charts/tree/main/charts/geoserver

## Configurações do PostgreSQL

| Chave                | Valor Padrão | Descrição                                  |
| -------------------- | ------------ | ------------------------------------------ |
| `postgresql.enabled` | `false`      | Indica se o PostgreSQL está habilitado.   |
| `postgresql.image.tag`| `14.11.0`    | Tag da imagem do PostgreSQL.              |

Mais detalhes sobre as configurações do chart do `PostgreSQL` estão disponíveis em https://artifacthub.io/packages/helm/bitnami/postgresql

## Configurações Globais

| Chave                       | Valor Padrão | Descrição                                                |
| --------------------------- | ------------ | -------------------------------------------------------- |
| `global.postgresql.postgresqlPassword`| `postgres`   | Senha padrão global para o PostgreSQL (se habilitado). |                                                                                  |

Você pode referenciar o arquivo [values.yaml](https://github.com/sgb-cprm/sace-helm/blob/main/charts/sace/values.yaml) para obter a lista completa de parâmetros.

## Uso

Após a instalação, você pode acessar o Nginx através do serviço Kubernetes exposto na porta `8080` dentro do cluster. Se o Ingress estiver habilitado e configurado, você poderá acessar o Nginx através do hostname definido em `ingress.hosts`.

## Configuração Avançada

Você pode personalizar ainda mais a implantação do `SACE` criando um arquivo `values.yaml` personalizado e fornecendo-o durante a instalação ou atualização do chart:

```bash
helm install -f my-values.yaml sace .
# ou
helm upgrade -f my-values.yaml sace .
```

## Contribuições
Sinta-se à vontade para contribuir com este chart através de pull requests no repositório.