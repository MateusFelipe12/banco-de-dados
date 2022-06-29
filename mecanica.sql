
CREATE TABLE IF NOT EXISTS public.contatos
(
    id integer NOT NULL DEFAULT nextval('contatos_id_seq'::regclass),
    telefone character varying(16) COLLATE pg_catalog."default" NOT NULL,
    celular character varying(16) COLLATE pg_catalog."default",
    email character varying(200) COLLATE pg_catalog."default",
    situacao boolean NOT NULL DEFAULT true,
    CONSTRAINT contatos_pkey PRIMARY KEY (id),
    CONSTRAINT contatos_celular_key UNIQUE (celular),
    CONSTRAINT contatos_telefone_key UNIQUE (telefone)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contatos
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.enderecos
(
    id integer NOT NULL DEFAULT nextval('enderecos_id_seq'::regclass),
    cidade character varying(100) COLLATE pg_catalog."default" NOT NULL,
    cep character varying(10) COLLATE pg_catalog."default" NOT NULL,
    bairro character varying(100) COLLATE pg_catalog."default" NOT NULL,
    rua character varying(100) COLLATE pg_catalog."default" NOT NULL,
    complemento character varying(100) COLLATE pg_catalog."default" NOT NULL,
    numero character varying(10) COLLATE pg_catalog."default" NOT NULL,
    situacao boolean NOT NULL DEFAULT true,
    CONSTRAINT enderecos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.enderecos
    OWNER to postgres;

create table fornecedores (
    id serial primary key,
    nome varchar(100) not null,
    razao_social varchar(100) not null,
    cnpj varchar(19) not null unique,
    inscricao_estadual varchar(20) not null unique,
    id_endereco integer not null,
    id_contato integer not null,
    constraint fk_enderecos_to_fornecedores foreign key (id_endereco) references enderecos (id),
    constraint fk_contatos_to_fornecedores foreign key (id_contato) references contatos (id)
);

create table enderecos_clientes (
    id serial primary key,
    id_enderecos integer not null,
    constraint fk_enderecos_to_enderecos_clientes foreign key (id_enderecos) references enderecos (id)
)

create table clientes (
    id serial primary key,
    cpf varchar(14) not null unique,
    rg varchar (10) not null unique,
    nome varchar (100) not null,
    data_nascimento date not null,
    id_contato integer not null,
    id_endereco integer not null,
    constraint fk_contatos_to_clientes foreign key (id_contato) references contatos(id),
    constraint fk_enderecos_to_clientes foreign key (id_endereco) references enderecos(id)
);

create table pecas (
    id serial primary key,
    descricao varchar(50) not null,
    valor_custo numeric(15,2) not null,
    margem_solicitada numeric(15,2) not null, 
    valor_venda numeric(15,2) not null,
    estoque integer,
    situcao boolean not null default false,
    id_fornecedor integer not null,
    constraint fk_fornecedores_to_pecas foreign key (id_fornecedor) references fornecedores (id)
);

create table veiculos (
    id serial primary key,
    placa varchar(8) not null unique,
    marca varchar(20) not null,
    modelo varchar(30) not null,
    ano integer not null,
    id_proprietario integer not null,
    constraint fk_clientes_to_veiculos foreign key (id_proprietario) references clientes (id)
);

create table  servicos_itens (
    id serial primary key,
    valor_total numeric(15,2),
    id_veiculo integer not null,
    constraint fk_veiculos_to_servico_itens foreign key (id_veiculo) references veiculos (id)
)

create table servico (
    id serial primary key,
    descricao varchar(200) not null,
    valor numeric(15,2) not null,
    data date not null,
    id_servicos_itens integer not null,
    constraint fk_servicos_itens_to_servico foreign key (id_servicos_itens) references servicos_itens (id)
);

create table pecas_servicos (
    id serial primary key,
    id_servico integer not null,
    id_pecas integer not null,
    constraint fk_servico_to_pecas_servicos foreign key (id_servico) references servico (id),
    constraint fk_pecas_to_pecas_servicos foreign key (id_pecas) references pecas (id)
);

alter table fornecedores
    add column situacao boolean not null default true;

alter table enderecos
    add column situacao boolean not null default true;

alter table contatos
    add column situacao boolean not null default true;

alter table clientes
    add column situacao boolean not null default true;

alter table pecas
    add column situacao boolean not null default true;

alter table servico
    add column pago boolean not null default false;

alter table veiculos
    add column situacao boolean not null default true;