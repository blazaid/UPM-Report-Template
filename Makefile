MAIN_TEX=report
REF_BIB=references
BUILD_DIR=build

# Detect the operating system
ifeq ($(OS),Windows_NT)
    DETECTED_OS := win
else
    DETECTED_OS := unix
endif

all:
ifeq ($(DETECTED_OS),win)
	$(MAKE) win
else
	$(MAKE) unix
endif

# If your document contains references, or ToC, LoT, LoF material, at least three times. The reasoning is pretty simple:
# First pass creates the labels and ToC, LoT, LoF material. Second pass has everything, but due to changes in layout and
# the additional material that wasn't available during first pass, the page numbers might change.
# Third pass is the first one that might be correct, but there could still be some changes affecting cross-referencing,
# so you might need more than three. -- [Skillmon](https://tex.stackexchange.com/users/117050/skillmon) 

unix:
	mkdir -p $(BUILD_DIR)
	cp -rv $$(ls -A | grep -vwE "build|.git") build
	-cd $(BUILD_DIR) && xelatex -interaction nonstopmode -file-line-error $(MAIN_TEX).tex
	-cd $(BUILD_DIR) && makeglossaries $(MAIN_TEX)
	-cd $(BUILD_DIR) && biber $(MAIN_TEX)
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
	makeglossaries $(MAIN_TEX)
	biber $(MAIN_TEX)
	xelatex -interaction nonstopmode -file-line-error \"$$MainTex.tex\"; \
	xelatex -interaction nonstopmode -file-line-error \"$$MainTex.tex\"; \
	}
	
clean:
ifeq ($(DETECTED_OS),win)
	$(MAKE) clean-win
else
	$(MAKE) clean-unix
endif
	
clean-unix:
	rm -rf $(BUILD_DIR)
	
clean-win:
	cmd /c rd /s /q $(BUILD_DIR)