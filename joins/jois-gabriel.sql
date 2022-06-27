-- JOINS

-- Inner Join

-- Left Join
-- Right Join
-- Union All

-- Join ele faz a uniao de duas tabelas
-- por meio das chaves estrangeiras e primarias das tabelas 
-- envonvidas no Join.

-- Exemplo: Ligação da Tabela Sessões com a tabela de Livros
-- Queremos listar o código do livro, o título e o nome da sessão
-- em que ele se encontra.

select
    l.id,
    l.titulo,
    l.id_sessao,
    s.nome
from livros as l
inner join sessoes as s on (l.id_sessao = s.id)

select
    e.id as id_emprestimo,
    e.data_inicio,
    u.nome,
    u.telefone,
    l.titulo,
    l.nome_autor,
    to_char(l.publicacao, 'DD/MM/YYYY') as data_publicacao,
    s.nome as nome_sessao
from emprestimos as e
inner join usuarios as u on (e.id_usuario = u.id)
inner join emprestimo_livros as el on (e.id = el.id_emprestimo)
inner join livros as l on (el.id_livro = l.id)
inner join sessoes as s on (l.id_sessao = s.id)
where e.id_usuario = 3