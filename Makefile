MAIN_TEX=report
REF_BIB=references
BUILD_DIR=build

all:
	$(info Ejecuta make con el target 'unix' o 'win' según tu sistema operativo.)


# If your document contains references, or ToC, LoT, LoF material, at least three times. The reasoning is pretty simple:
# First pass creates the labels and ToC, LoT, LoF material. Second pass has everything, but due to changes in layout and
# the additional material that wasn't available during first pass, the page numbers might change.
# Third pass is the first one that might be correct, but there could still be some changes affecting cross-referencing,
# so you might need more than three. -- [Skillmon](https://tex.stackexchange.com/users/117050/skillmon) 


unix:
	mkdir -p $(BUILD_DIR)
	cp -rv $$(ls -A | grep -vwE "build|.git") build
	-cd $(BUILD_DIR) && xelatex -interaction nonstopmode -file-line-error $(MAIN_TEX).tex
	-cd $(BUILD_DIR) && xelatex -interaction nonstopmode -file-line-error $(MAIN_TEX).tex
	cd $(BUILD_DIR) && xelatex -interaction nonstopmode -file-line-error $(MAIN_TEX).tex
	
win:
	@echo off
	powershell -Command "& {\
	$$BuildDir = '$(BUILD_DIR)'; \
	$$MainTex = '$(MAIN_TEX)'; \
	If (-Not (Test-Path -Path $$BuildDir)) { New-Item -ItemType Directory -Path $$BuildDir }; \
	Get-ChildItem -Path . -Exclude $$BuildDir, '.git' | Copy-Item -Destination $$BuildDir -Recurse -Force; \
	Set-Location -Path $$BuildDir; \
	xelatex -interaction nonstopmode -file-line-error \"$$MainTex.tex\"; \
	xelatex -interaction nonstopmode -file-line-error \"$$MainTex.tex\"; \
	xelatex -interaction nonstopmode -file-line-error \"$$MainTex.tex\"; \
	}"
	
clean:
	$(info Ejecuta make con el target 'clean-unix' o 'clean-win' según tu sustema operativo.)
	
clean-unix:
	rm -rf $(BUILD_DIR)
	
clean-win:
	cmd /c rd /s /q $(BUILD_DIR)