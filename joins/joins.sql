-- Listar o nome, email e telefone do usuarios 
-- que pegaram emprestado algum livro do setor id 2 

select 
    u.nome,
    u.email,
    u.telefone
from emprestimos as e
inner join usuarios as u on (e.id_usuario = u.id)
inner join emprestimo_livros as el on (e.id = el.id_emprestimo)
inner join livros as l on (el.id_livro = l.id)
where l.id_sessao = 2

--Listar título, nome da sessão e nome do autor dos 
--livros que o usuário id 5 pegou emprestado 
select
    l.titulo,
    s.nome,
    l.nome_autor
    
from emprestimos as e
inner join emprestimo_livros as el on (e.id = el.id_emprestimo)
inner join livros as l on (el.id_livro = l.id)
inner join sessoes as s on (l.id_sessao = s.id)
where e.id_usuario = 1

--Listar o título e data de publicação dos livros 
--emprestados para usuarios com DDD (55)
select
    l.titulo,
    to_char(l.publicacao, 'DD/MM/YYYY') as publicacao
from emprestimos as e
inner join usuarios as u on (e.id_usuario = u.id)
inner join emprestimo_livros as el on (e.id = el.id_emprestimo)
inner join livros as l on (el.id_livro = l.id)
where u.telefone like ('(49)%')


select
    u.nome,
    s.nome
from emprestimos as e
inner join usuarios as u on (e.id_usuario = u.id)
inner join emprestimo_livros as el on (e.id = el.id_emprestimo)
inner join livros as l on (el.id_livro = l.id)
inner join sessoes as s on (l.id_sessao = s.id)