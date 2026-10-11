# -*- coding: utf-8 -*-
"""Lançador do Simulador de Sólitons de Falaco (para virar .exe).

Sem argumentos: abre a janela com controles deslizantes (modo --gui).
Com argumentos: funciona como o falaco_sim.py normal.
Se der erro, mostra uma caixa de mensagem em vez de fechar em silêncio.
"""
import os
import sys
import traceback

import falaco_sim


def _mostrar_erro(texto):
    try:
        import tkinter
        from tkinter import messagebox
        raiz = tkinter.Tk()
        raiz.withdraw()
        messagebox.showerror("Simulador de Falaco - erro", texto)
        raiz.destroy()
    except Exception:
        print(texto)


def main():
    argv = sys.argv[1:]
    if not argv:
        # a imagem de saída vai para a pasta do usuário (sempre gravável)
        saida = os.path.join(os.path.expanduser("~"), "falaco_resultado.png")
        argv = ["--gui", "--saida", saida]
    return falaco_sim.principal(argv)


if __name__ == "__main__":
    try:
        sys.exit(main())
    except SystemExit:
        raise
    except Exception:
        _mostrar_erro(traceback.format_exc())
        sys.exit(1)
