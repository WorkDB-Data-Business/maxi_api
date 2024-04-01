from fastapi import FastAPI
from fastapi import Request
from src.error import register_error_handlers
from src.views import (
    ApontamentosView, AtributosView, EstoqueView,
    EstruturaProdutoView, GrupoRecursoView, ItemView,
    ListaMateriaisView, ManutencaoView, OrdemCompraView,
    RecursoView, RoteiroFabricacaoView, UnidadeFabrilView,
    ExportacaoERPView
)
from src.connectors import OracleConnector
from src.helpers import define_resource

app = FastAPI()
register_error_handlers(app)


@app.on_event("startup")
def connect_mysql():
    OracleConnector()

define_resource(app, '/apontamentos', ApontamentosView)
define_resource(app, '/atributos', AtributosView)
define_resource(app, '/estoque', EstoqueView)
define_resource(app, '/estrutura_produto', EstruturaProdutoView)
define_resource(app, '/grupo_recurso', GrupoRecursoView)
define_resource(app, '/item', ItemView)
define_resource(app, '/lista_materiais', ListaMateriaisView)
define_resource(app, '/manutencao', ManutencaoView)
define_resource(app, '/ordem_compra', OrdemCompraView)
define_resource(app, '/recurso', RecursoView)
define_resource(app, '/roteiro_fabricacao', RoteiroFabricacaoView)
define_resource(app, '/unidade_fabril', UnidadeFabrilView)

@app.post("/exportacao_erp")
def insert_table(request: Request, values: dict):
    return ExportacaoERPView(request).POST(values)
