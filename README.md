
![Template rluipdev](rluispdev(2).png)


# 📸 ImageStream App – Documentação Técnica

## 🧾 Visão Geral

O **ImageStream** é um app desenvolvido com SwiftUI que consome imagens da API do [Pexels](https://www.pexels.com/).  
Ele utiliza o framework `Combine` para reatividade e gerenciamento de estado com `ObservableObject`.

---

## 🧱 Estrutura do Projeto

### 🎯 App Principal

#### `ImagemStreamApp`

```swift
@main @MainActor
struct ImagemStreamApp: App
```

- **Descrição:** Ponto de entrada da aplicação.
- **Propriedades:**
  - `body`: Define a cena principal do app.
- **Conforma aos protocolos:**
  - `App`
  - `Sendable`
  - `BitwiseCopyable`

---

### 🧠 Serviço de Imagem

#### `class PexelsImageService: ObservableObject`

```swift
class PexelsImageService: ObservableObject
```

- **Descrição:** Responsável por buscar imagens da API do Pexels e gerenciar a lógica de carregamento.
- **Propriedades:**
  - `photo: PhotoModel?` – Imagem atual selecionada.
- **Métodos:**
  - `init()` – Inicializador padrão.
  - `func checkAndLoadMoreImagesIfNeeded()` – Verifica e carrega mais imagens, se necessário.
  - `func pickRandomPhoto()` – Escolhe uma foto aleatória para exibir.
- **Conforma ao protocolo:**
  - `ObservableObject`

---

### 🖼️ Modelo de Foto

#### `struct PhotoModel: Identifiable, Sendable`

```swift
struct PhotoModel: Identifiable, Sendable
```

- **Descrição:** Modelo que representa uma imagem retornada pela API do Pexels.
- **Inicializador:**
  - `init(from: PSPhoto)` – Cria um modelo a partir de uma estrutura `PSPhoto` da API.
- **Propriedades:**
  - `id: Int` – Identificador único da foto.
  - `imageUrl: String` – URL da imagem.
  - `photographer: String` – Nome do fotógrafo.
  - `photographerURL: String` – URL do perfil do fotógrafo.
  - `url: String` – URL da página da foto no Pexels.
- **Conforma aos protocolos:**
  - `Identifiable`
  - `Sendable`

---

## 🖥️ View Principal

#### `ContentView`

```swift
struct ContentView: View
```

- **Descrição:** View principal da aplicação, responsável por exibir a imagem selecionada e interagir com o usuário.
- **Integrações:**
  - Observa `PexelsImageService` via `@StateObject`.
  - Exibe `PhotoModel` usando componentes SwiftUI.

---

## 🔗 Relações Entre Componentes

- `ImagemStreamApp` é o ponto de entrada e instancia a `ContentView`.
- `ContentView` observa uma instância de `PexelsImageService`.
- `PexelsImageService` fornece a imagem atual como `PhotoModel`.
- `PhotoModel` é preenchido com dados vindos da API externa.

---

## 🚀 Tecnologias Utilizadas

- **Linguagem:** Swift 5+
- **UI:** SwiftUI
- **Reatividade:** Combine
- **API:** Pexels
- **Gerenciador de Pacotes:** Swift Package Manager (SPM)

---

## 📂 Organização do Código

```
├── ImageStreamApp.swift
├── Models
│   └── PhotoModel.swift
├── Services
│   └── PexelsImageService.swift
├── Views
│   └── ContentView.swift
└── Resources
    └── Assets.xcassets / Info.plist
```

---

## 📦 Instalação e Execução

1. Clone o repositório:
   ```bash
   git clone https://github.com/seuusuario/ImageStream.git
   ```

2. Abra o projeto no Xcode:
   ```bash
   open ImageStream.xcodeproj
   ```

3. Execute o app no simulador ou dispositivo real.


## 👨‍💻 Student
<p>
    <img 
      align=left 
      margin=10 
      width=80 
      src="https://avatars.githubusercontent.com/u/128305083?s=96&v=4"
    />
    <p>&nbsp&nbsp&nbsprluispdev<br>
    &nbsp&nbsp&nbsp
     <a href="https://rluispdev.github.io/portifolio/" target="_blank"> Portifólio</a>
&nbsp;|&nbsp;
    <a href="https://github.com/rluispdev" target="_blank">
    GitHub</a>&nbsp;|&nbsp;
     <a href="https://cursos.alura.com.br/user/rluisp" target="_blank"> Alura Profile</a>
&nbsp;|&nbsp;
       <a href="https://www.dio.me/users/rluispdev" target="_blank">DIO</a>
&nbsp;|&nbsp;      
    <a href="https://www.linkedin.com/in/rafael-luis-gonzaga-b11634186/" target="_blank">LinkedIn</a>
&nbsp;|&nbsp;
    <a href="https://www.instagram.com/rluispdevs?igsh=cnoxenpmaHY1amE0&utm_source=qr" target="_blank">
    Instagram</a>
&nbsp;|&nbsp;</p>
</p>
<br/><br/>
<p>






---


## 🪪 Licença

Este projeto está licenciado sob a **MIT License**.  
Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
