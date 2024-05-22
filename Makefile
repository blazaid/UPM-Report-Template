MAIN_TEX=report
REF_BIB=references
BUILD_DIR=build

all:
	$(info Ejecuta make con el target 'unix' o 'win' según tu sistema operativo.)

unix:
	mkdir -p $(BUILD_DIR)
	cp -rv $$(ls -A | grep -vwE "build|.git") build
	-cd $(BUILD_DIR) && xelatex $(MAIN_TEX).tex
	-cd $(BUILD_DIR) && biber $(MAIN_TEX)
	-cd $(BUILD_DIR) && makeglossaries $(MAIN_TEX)
	cd $(BUILD_DIR) && xelatex $(MAIN_TEX).tex
	
win:
	@echo off
	powershell -Command "& {\
	$$BuildDir = '$(BUILD_DIR)'; \
	$$MainTex = '$(MAIN_TEX)'; \
	If (-Not (Test-Path -Path $$BuildDir)) { New-Item -ItemType Directory -Path $$BuildDir }; \
	Get-ChildItem -Path . -Exclude $$BuildDir, '.git' | Copy-Item -Destination $$BuildDir -Recurse -Force; \
	Set-Location -Path $$BuildDir; \
	xelatex \"$$MainTex.tex\"; \
	biber $$MainTex; \
	makeglossaries $$MainTex; \
	xelatex \"$$MainTex.tex\"; \
	}"
	
clean:
	$(info Ejecuta make con el target 'clean-unix' o 'clean-win' según tu sustema operativo.)
	
clean-unix:
	rm -rf $(BUILD_DIR)
	
clean-win:
	cmd /c rd /s /q $(BUILD_DIR)