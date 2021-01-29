////////// 1. INSERIR INFORMACOES GERAIS. //////////////

// Informações dos cursos
LOAD CSV WITH HEADERS FROM 'file:///MEI/cursos.csv' AS row
CREATE (curso:Curso {idCurso: row.CODIGO}) 
SET curso.descricao= row.DESCRICAO, 
	curso.codUniversidade = row.COD_UNIVERSIDADE,
    curso.descUniversidade= row.DES_UNIVERSIDADE, 
	curso.anoInicio = row.ANO_INICIO,
    curso.anoFim = row.ANO_CONCLUSAO
RETURN curso;

// Informações dos anos
LOAD CSV WITH HEADERS FROM 'file:///MEI/anos.csv' AS row
CREATE (ano:AnoEscolar {anoEscolar: row.ANO}) 
SET ano.codCurso = row.COD_CURSO
RETURN ano;

// Informações dos semestres
LOAD CSV WITH HEADERS FROM 'file:///MEI/anos.csv' AS row
CREATE (ano:AnoEscolar {anoEscolar: row.ANO}) 
SET ano.codCurso = row.COD_CURSO
RETURN ano;

// Informações das UC's
LOAD CSV WITH HEADERS FROM 'file:///MEI/unidadesCurriculares.csv' AS row
CREATE (uc:UC{codeUC: row.CODE_UC}) 
SET uc.descriptionUC = row.DESCRIPTION_UC,
    uc.perfil = row.PERFIL,
    uc.descriptionPerfil = row.DESCRIPTION_PERFIL,
    uc.startDate = row.START_DATE,
    uc.endDate = row.END_DATE,
    uc.note = row.NOTE
RETURN uc;



////////// 2. INSERIR RELAÇÕES ENTRE NODOS. //////////////

// Relação cursos -> anos
LOAD CSV WITH HEADERS FROM 'file:///MEI/anos.csv' AS row
MATCH (ano:AnoEscolar {anoEscolar: row.ANO})
MATCH (curso:Curso {idCurso: row.COD_CURSO})
MERGE (ano)-[p:PERTENCE_AO]->(curso)
ON CREATE SET p.startDate = row.ANO_INICIO,
              p.endDate = row.ANO_FIM;