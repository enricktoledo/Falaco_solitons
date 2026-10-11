@echo off
chcp 65001 >nul
title Gerando FalacoSim.exe
echo ============================================================
echo  Gerador do executavel do Simulador de Solitons de Falaco
echo ============================================================
echo.
echo Requisito: Python 3.9 ou mais novo instalado, com "Add python.exe to PATH".
echo Este processo baixa bibliotecas da internet (uma vez) e leva alguns minutos.
echo.

where python >nul 2>nul
if errorlevel 1 (
  echo [ERRO] Python nao encontrado. Instale em https://www.python.org/downloads/
  echo        e marque "Add python.exe to PATH" no instalador.
  pause
  exit /b 1
)

echo [1/4] Criando ambiente isolado...
python -m venv .venv_falaco
if errorlevel 1 goto erro

echo [2/4] Instalando numpy, matplotlib e pyinstaller...
call .venv_falaco\Scripts\python.exe -m pip install --upgrade pip
call .venv_falaco\Scripts\python.exe -m pip install numpy matplotlib pyinstaller
if errorlevel 1 goto erro

echo [3/4] Gerando o executavel...
call .venv_falaco\Scripts\python.exe -m PyInstaller --noconfirm --clean --onefile --windowed ^
  --name FalacoSim ^
  --hidden-import matplotlib.backends.backend_tkagg ^
  falaco_app.py
if errorlevel 1 goto erro

echo [4/4] Copiando para esta pasta...
copy /y dist\FalacoSim.exe FalacoSim.exe >nul

echo.
echo ============================================================
echo  PRONTO!  O arquivo FalacoSim.exe esta nesta pasta.
echo  Duplo clique nele abre a janela com os controles.
echo ============================================================
pause
exit /b 0

:erro
echo.
echo [ERRO] Algo falhou. Copie a mensagem acima e me mande para eu ajustar.
pause
exit /b 1
