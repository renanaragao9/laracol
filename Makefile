.PHONY: build run clean setup help

COMPILER = cobc
COMPILER_FLAGS = -x -free
BUILD_DIR = bin
MAIN_PROGRAM = bootstrap/app.cbl

help:
	@echo "Laracol Framework - Comandos disponíveis:"
	@echo "  make setup   - Configuração inicial"
	@echo "  make build   - Compilar aplicação"
	@echo "  make run     - Compilar e executar"
	@echo "  make clean   - Limpar arquivos compilados"

setup:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p storage/logs
	@echo "✓ Aplicação pronta"

build: setup
	@echo "Compilando aplicação COBOL..."
	@$(COMPILER) $(COMPILER_FLAGS) -o $(BUILD_DIR)/api \
		$(MAIN_PROGRAM) \
		app/Http/Kernel.cbl \
		app/Http/Controllers/WelcomeController.cbl \
		app/Models/BaseModel.cbl \
		routes/api.cbl
	@echo "✓ Build concluído"

run: build
	@./$(BUILD_DIR)/api

clean:
	@rm -f $(BUILD_DIR)/api
	@echo "✓ Arquivos compilados removidos"
