# 🚀 Instalação do Laracol

**Português BR:** Guia completo para instalar e configurar o Laracol Framework em sua máquina local.

**English:** Complete guide to install and set up the Laracol Framework on your local machine.

---

## 📋 Pré-requisitos | Prerequisites

### Português BR

Antes de começar, você precisa ter:

1. **GnuCOBOL 2.2+** - Compilador COBOL
2. **Make** - Gerenciador de build
3. **Git** (opcional) - Para controle de versão
4. **Servidor Web** - Apache ou Nginx (para produção)

**Sistema Operacional Suportado:**

- Linux (Ubuntu, Debian, CentOS)
- macOS (Intel ou Apple Silicon)
- Windows (com WSL2 ou Cygwin)

### English

Before you start, you need to have:

1. **GnuCOBOL 2.2+** - COBOL Compiler
2. **Make** - Build manager
3. **Git** (optional) - For version control
4. **Web Server** - Apache or Nginx (for production)

**Supported Operating Systems:**

- Linux (Ubuntu, Debian, CentOS)
- macOS (Intel or Apple Silicon)
- Windows (with WSL2 or Cygwin)

---

## 🔧 Instalação do Compilador | Installing the Compiler

### Ubuntu/Debian

```bash
# Atualizar repositórios | Update repositories
sudo apt update

# Instalar GnuCOBOL | Install GnuCOBOL
sudo apt install gnucobol

# Instalar Make | Install Make
sudo apt install make

# Verificar instalação | Verify installation
cobc --version
make --version
```

### macOS

```bash
# Instalar Homebrew (se não tiver) | Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar GnuCOBOL | Install GnuCOBOL
brew install gnucobol

# Instalar Make | Install Make
brew install make

# Verificar | Verify
cobc --version
make --version
```

### macOS com Apple Silicon (M1/M2)

```bash
# Adicionar arquitetura Intel (se necessário) | Add Intel architecture
arch -x86_64 brew install gnucobol
```

### Windows (WSL2)

```bash
# Abrir WSL2 e executar comandos Ubuntu | Open WSL2 and run Ubuntu commands
wsl --install -d Ubuntu-22.04

# Dentro do WSL | Inside WSL
sudo apt update
sudo apt install gnucobol make git
```

### CentOS/RHEL

```bash
# Instalar GnuCOBOL | Install GnuCOBOL
sudo dnf install gnucobol

# Instalar Make | Install Make
sudo dnf install make

# Verificar | Verify
cobc --version
```

---

## 📥 Clonar ou Baixar Laracol | Clone or Download Laracol

### Opção 1: Git Clone

```bash
# Português BR - Clonar repositório
git clone https://github.com/seu-usuario/laracol.git
cd laracol

# English - Clone repository
git clone https://github.com/your-username/laracol.git
cd laracol
```

### Opção 2: Download Manual

```bash
# Baixar arquivo | Download file
wget https://github.com/seu-usuario/laracol/archive/main.zip
unzip main.zip
cd laracol-main
```

---

## ⚙️ Configuração Inicial | Initial Setup

### 1. Verificar Pré-requisitos | Verify Requirements

```bash
# Verificar COBOL | Check COBOL
cobc --version

# Verificar Make | Check Make
make --version

# Verificar Git | Check Git
git --version
```

### 2. Setup do Projeto | Project Setup

```bash
# Executar setup | Run setup
make setup

# Saída esperada | Expected output
# mkdir -p bin
# mkdir -p storage/logs
# ✓ Aplicação pronta | ✓ Application ready
```

### 3. Compilar Aplicação | Compile Application

```bash
# Compilar | Compile
make build

# Saída esperada | Expected output
# Compilando aplicação COBOL...
# Linking...
# ✓ Build concluído | ✓ Build completed
```

### 4. Executar Aplicação | Run Application

```bash
# Executar | Run
make run

# Saída esperada | Expected output
# ╔═══════════════════════════════════╗
# ║         LARACOL FRAMEWORK         ║
# ╚═══════════════════════════════════╝
# ✓ Servidor iniciado em localhost:8080
# ✓ Server started on localhost:8080
```

---

## 🧪 Testar Instalação | Test Installation

### Teste 1: Health Check

```bash
# Em outro terminal | In another terminal
curl http://localhost:8080/api/welcome

# Resposta esperada | Expected response
{
  "message": "Bem-vindo ao Laracol | Welcome to Laracol",
  "framework": "Laravel-like em COBOL | Laravel-like in COBOL",
  "status": "running"
}
```

### Teste 2: Verificar Estrutura | Check Structure

```bash
# Copromete estrutura de diretórios | Verify directory structure
ls -la

# Saída esperada | Expected output
# app/
# bin/
# bootstrap/
# config/
# database/
# docs/
# public/
# resources/
# routes/
# storage/
# tests/
# Makefile
# README.md
```

---

## 📁 Configurar Ambiente | Configure Environment

### 1. Editar Configurações | Edit Configuration

```bash
# Abrir arquivo de config | Open config file
nano config/app.conf

# ou | or
vim config/app.conf
```

### Configurações Principais | Main Settings

```cobol
       *> Português BR
       01 APP-CONFIG.
           05 APP-NAME PIC X(50) VALUE "Laracol".
           05 APP-ENV PIC X(20) VALUE "development".
           05 HTTP-PORT PIC 9(4) VALUE 8080.
           05 APP-DEBUG PIC X VALUE 'Y'.

       *> English
       01 APP-CONFIG.
           05 APP-NAME PIC X(50) VALUE "Laracol".
           05 APP-ENV PIC X(20) VALUE "development".
           05 HTTP-PORT PIC 9(4) VALUE 8080.
           05 APP-DEBUG PIC X VALUE 'Y'.
```

### 2. Configurar Banco de Dados | Configure Database

```bash
# Editar banco de dados | Edit database config
nano config/database.conf
```

```cobol
       *> Português BR - SQLite (padrão)
       01 DATABASE-CONFIG.
           05 DB-DEFAULT PIC X(20) VALUE "sqlite".
           05 SQLITE-PATH PIC X(100) VALUE "database/app.db".

       *> English - SQLite (default)
       01 DATABASE-CONFIG.
           05 DB-DEFAULT PIC X(20) VALUE "sqlite".
           05 SQLITE-PATH PIC X(100) VALUE "database/app.db".
```

---

## 🚀 Iniciar Desenvolvimento | Start Development

### Estrutura Recomendada | Recommended Structure

```bash
# Terminal 1: Servidor rodando | Terminal 1: Server running
make run

# Terminal 2: Desenvolvimento | Terminal 2: Development
# Edite e compile conforme necessário | Edit and compile as needed
make build

# Terminal 3: Testar | Terminal 3: Test
curl -X GET http://localhost:8080/api/welcome
```

### Alias Úteis | Useful Aliases

```bash
# Adicionar ao ~/.bashrc ou ~/.zshrc | Add to ~/.bashrc or ~/.zshrc

# Português BR
alias laracol-dev="cd ~/laracol && make clean && make build && make run"
alias laracol-test="make test"
alias laracol-clean="make clean"

# English
alias laracol-dev="cd ~/laracol && make clean && make build && make run"
alias laracol-test="make test"
alias laracol-clean="make clean"
```

---

## 🐛 Troubleshooting

### Erro: Compilador não encontrado | Compiler not found

```bash
# Solução | Solution
which cobc

# Se não encontrar | If not found
# Ubuntu/Debian
sudo apt install gnucobol

# macOS
brew install gnucobol
```

### Erro: Port já em uso | Port already in use

```bash
# Encontrar processo usando porta | Find process using port
lsof -i :8080

# Mudar porta em config/app.conf | Change port in config/app.conf
# ou | or
HTTP-PORT PIC 9(4) VALUE 8081.

# Compilar novamente | Recompile
make clean && make build && make run
```

### Erro: Permissão negada | Permission denied

```bash
# Dar permissão de execução | Grant execute permission
chmod +x bin/api

# ou | or
chmod +x Makefile
make setup
make build
```

### Erro: Arquivo não encontrado | File not found

```bash
# Verificar sintaxe | Check syntax
cobc -fsyntax-only app/Http/Kernel.cbl

# Reconstruir tudo | Rebuild everything
make clean
make setup
make build
```

---

## ✅ Instalação Completa | Installation Complete

Se chegou aqui, você tem:

✅ GnuCOBOL instalado | GnuCOBOL installed  
✅ Laracol clonado/baixado | Laracol cloned/downloaded  
✅ Projeto compilado | Project compiled  
✅ Servidor rodando | Server running  
✅ Testes passando | Tests passing

### Próximos Passos | Next Steps

1. **Leia [FRAMEWORK.md](FRAMEWORK.md)** - Entenda a arquitetura
   **Read [FRAMEWORK.md](FRAMEWORK.md)** - Understand the architecture

2. **Siga [CRUD.md](CRUD.md)** - Crie seu primeiro CRUD Rest
   **Follow [CRUD.md](CRUD.md)** - Create your first REST CRUD

3. **Explore [../README.md](../README.md)** - Guia completo do projeto
   **Explore [../README.md](../README.md)** - Complete project guide

---

## 📞 Suporte | Support

Se tiver problemas:

- 📖 Verifique os logs em `storage/logs/`
- 🔍 Rode `make clean && make build`
- 💬 Consulte documentação em cada pasta

If you have issues:

- 📖 Check logs in `storage/logs/`
- 🔍 Run `make clean && make build`
- 💬 Check documentation in each folder

---

**Laracol está pronto para usar! | Laracol is ready to use!** 🎉
