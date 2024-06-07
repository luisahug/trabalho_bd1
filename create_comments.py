requirements = """B. Gerar uma consulta que envolva uma tabela;
C. Gerar uma consulta que envolva duas tabelas usando equi-join;
D. Gerar uma consulta que envolva duas tabelas usando inner-join;
E. Gerar uma consulta que envolva três tabelas usando equi-join;
F. Gerar uma consulta que envolva três tabelas usando inner-join;
G. Gerar uma consulta que envolva mais de três tabelas;
H. Implementar uma consulta usando NULL ou NOT NULL, envolvendo no mínimo 2 tabelas;
I. Implementar uma consulta usando a cláusula like e o argumento %, envolvendo no mínimo 2
tabelas;
J. Implementar uma consulta usando a cláusula like e o argumento _, envolvendo no mínimo 2
tabelas;
K. Implementar uma consulta com subconsulta, usando a cláusula IN, envolvendo no mínimo 2
tabelas;
L. Implementar uma consulta com subconsulta, usando a cláusula ANY ou ALL, envolvendo no
mínimo 2 tabelas;
M. Implementar uma consulta com subconsulta, usando a cláusula EXISTS, envolvendo no mínimo 2
tabelas;
N. Implementar uma consulta usando a cláusula UNION, envolvendo no mínimo 2 tabelas;
O. Implementar uma consulta usando a cláusula GROUP BY e pelo menos uma função agregada,
envolvendo no mínimo 2 tabelas;
P. Implementar uma consulta usando a cláusula GROUP BY e HAVING, envolvendo no mínimo 2
tabelas;
Q. Implementar uma consulta usando a cláusula DELETE;
R. Implementar uma consulta usando a cláusula UPDATE, atualizando mais de dois atributos;
S. Implementar uma consulta usando a cláusula DROP;
T. Implementar uma visão que inclua no mínimo 3 tabelas"""

requirements = requirements.replace("\n", "").split(';')


line_pref = "-- | ";
line_sep_hyphen_count = 36;
line_separator = "-- +" + "-" * line_sep_hyphen_count;

comment_header = lambda letter: "-- ["+letter+"]" + '-' * (line_sep_hyphen_count - 2)
comment_line = lambda c="": line_pref + c
    
comment_max_words_per_line = 7


lines = []
for req in requirements:
    [l, c] = req.split(". ")
    
    lines.append( comment_header( l ) )

    line = ""
    spl = c.split(" ")
    for idx, word in enumerate(spl): 
        line += word + " "
        if (idx+1) % comment_max_words_per_line == 0 or idx == len(spl)-1:
            lines.append(comment_line(line))
            line = ""

    lines.append( line_separator )
    lines.append(comment_line())
    lines.append(comment_line("// Insira comentário aqui."))
    lines.append(comment_line())
   
    lines.append("");
    lines.append("-- Código SQL aqui")
    lines.append("");
    
    lines.append(comment_line())
    lines.append( line_separator )
    
    lines.append("")
    lines.append("")
print("\n".join(lines))






