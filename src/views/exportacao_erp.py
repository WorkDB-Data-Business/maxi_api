from fastapi.responses import JSONResponse
from .base_view import BaseView



class ExportacaoERPView(BaseView):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.columns = ('USU_UNIFAB', 'USU_NUMOCP', 'USU_SEQROT', 'USU_INISET', 'USU_INIPRO', 'USU_FIMPRO', 'USU_CODCRE', 'USU_LIQSET', 'USU_LIQPRO')

    def GET(self):
        raise NotImplemented('GET method not implemented')

    def POST(self, values: dict):
        sql_insert = f"INSERT INTO USU_TNEOPRG {self.columns} VALUES ("
        try:
            sql_insert += "('{valor_USU_UNIFAB}', '{valor_USU_NUMOCP}', '{valor_USU_SEQROT}', '{valor_USU_INISET}', '{valor_USU_INIPRO}', '{valor_USU_FIMPRO}', '{valor_USU_CODCRE}', '{valor_USU_LIQSET}', '{valor_USU_LIQPRO}'".format(**values)
        except KeyError as e:
            return JSONResponse(status_code=400, content={"message": f"Required key {e} not found in values"})
        sql_insert += ");"
        return self.db.execute(sql_insert)
