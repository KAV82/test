/*результат выполнения:
select * from test.t_schet;
select * from test.t_sl;
select * from test.t_usl;
*/
CREATE SCHEMA test
    AUTHORIZATION postgres;

COMMENT ON SCHEMA test
    IS 'схема для выполнения тестового задания №1';



--создание специально буферной таблицы 
create table IF NOT EXISTS test.input_xml (txt text);

/*так как в условии задачи необходимо создать три таблицы, то такие сущности как ERROR, PD, DISP и другие будем
помещать в родительские сущности, приняв допущение, что в каждой записи они встречаются максимум один раз
(если это ошибочное допущение, то при необходимости готов доработать: создать отдельные таблицы ERROR, PD, DISP и т.д., связанные один-ко-многим)*/

--создание таблицы "общие сведения о счёте"
CREATE TABLE IF NOT EXISTS test.t_schet
(
	CODE_MO varchar(6) NOT NULL,
	YEAR numeric(4) NOT NULL,
	MONTH numeric(2) NOT NULL,
	PLAT varchar(5),
	COMENTS varchar(250),
    OSHIB numeric(3),
    IM_POL varchar(20),	
    CONSTRAINT t_schet_pk PRIMARY KEY (CODE_MO)
);

--создание таблицы сведения о случаях оказания пациентам амбулаторной медпомощи
CREATE TABLE IF NOT EXISTS test.t_SL (
                        ID_SLUCH varchar(36) NOT NULL, 
                        CODE_MO varchar(6) NOT NULL REFERENCES test.t_schet (CODE_MO) ON DELETE CASCADE ON UPDATE CASCADE,
					    PR_NOV  numeric(1) NOT NULL,
					    VIDPOM numeric(2) NOT NULL,
					   	MODDATE timestamp,
					    BEGDATE timestamp NOT NULL,
					    ENDDATE timestamp NOT NULL,
					    MO_CUSTOM varchar(6) NOT NULL,
					   	LPUBASE numeric(7),
					    ID_STAT numeric(1) NOT NULL,
					    SMO varchar(5),
					    SMO_OK varchar(5),
					    NOVOR varchar(9),
						--PD
				   PDT numeric(1) NOT NULL,
                   ENP varchar(16),
                   W numeric(1) NOT NULL,
                   DR date NOT NULL,
                   VPOLIS numeric(1) NOT NULL,
                   SPOLIS varchar(10),
                   NPOLIS varchar(20) NOT NULL,
                   FAM varchar(40) NOT NULL,
                   IM varchar(40) NOT NULL,
                   OT varchar(40) NOT NULL,
                   MR varchar(100),
                   DOCTYPE varchar(2),
                   DOCSER varchar(10),
                   DOCNUM varchar(20),
                   SNILS varchar(14),
                   OKATOG varchar(12),
                   OKATOP varchar(12),
                   STREET_F numeric(6),
                   HOUSE_F numeric(4),
                   HOUSELITER_F varchar(1),
                   CORPUS_F numeric(2),
                   FLAT_F numeric(4),
                   FLATLITER_F varchar(1),
					    LPUCODE numeric(7) NOT NULL,
					    NPR_MO varchar(6),
					    NPR_TYPE numeric(2),
					    NPR_MDCODE varchar(8),
					    EXTR numeric(2) NOT NULL,
					    NHISTORY varchar(50) NOT NULL,
					    --DS
				   DS_WAY varchar(10),
				   DS_IN varchar(10),
				   DS_MAIN varchar(10) NOT NULL,
				   DS_DIFF varchar(10),
				   DS_SEC1 varchar(10),
				   DS_SEC2 varchar(10),
				   DS_DEAD varchar(10),
				   DS_IL varchar(10),
				   DS_DPA varchar(10),						
					   	CODE_MES1  varchar(16),
					    CODE_MES2  varchar(16),
					    APP_GOAL numeric(1),
					    RSLT numeric(3) NOT NULL,
					    ISHOD numeric(3) NOT NULL,
					    VID_HMP  varchar(12),
					    METOD_HMP numeric(3),
					    PRVS_SL numeric(9) NOT NULL,
					    PROFIL varchar(11) NOT NULL,
					    DET numeric(1) NOT NULL,
					    IDDOKT varchar(8) NOT NULL,
					    POVOD numeric(4,2),
					    OS_SLUCH numeric(1),
					    --DISP
				   DISPTYPE numeric(1),
				   DISPSTAGE numeric(1),
				   DISPGROUP varchar(2),
				   DISPPDSTAT numeric(1),
				   DISPFORM numeric(1),
				   NAZR numeric(2),
				   NAZ_SP numeric(4),
				   NAZ_V numeric(1),
				   NAZ_PMP numeric(3),
				   NAZ_PK numeric(3),
				   PR_D_N numeric(1),
				   VBR numeric(1),
				   P_OTK numeric(1),						
					    SIGNPAY  numeric(1) NOT NULL,
					    IDSP  numeric(2) NOT NULL,
					    GRP_SK  numeric(3),
					    OPLATA  numeric(1),
					    ED_COL  numeric(5,2),
					    KOEFFCUR  numeric(5,2),
					    IDSL  numeric(4),
					    KOL_MAT  numeric(5,2),
					    INV  numeric(1),
					    VNOV  numeric(4),
					    P_PER  numeric(1),
					    PODR  numeric(8) NOT NULL,
					    TAL_D date,
					    TAL_P date,
					    NPR_DATE date,
					    SCH_CODE varchar(10),
					    IT_TYPE varchar(10),
					    SRM_MARK varchar(10),
					    MSE  numeric(1),
					    USL_OK  numeric(2) NOT NULL,
					    --SUMSLUCH
				   SUMV numeric(15,2),
				   SUMP numeric(15,2),
				   SUMB numeric(15,2),
				   SUMB_S numeric(15,2),						
					    --EXPERT xml  path 'EXPERT',
				   TYPE_EXP numeric(1),
				   ORG_EXP varchar(6),
				   CODE_EXP varchar(8),
				   DATE_EXP date,
				   SANK numeric(15,2),
				   S_OSN numeric(3),
					    COMENTSL  varchar(250),
					    --ERROR_SL
				   OSHIB numeric(3),
                   IM_POL varchar(20),
				   CONSTRAINT t_sl_pk PRIMARY KEY (ID_SLUCH));	

--список услуг, оказанных пациенту в рамках конкретного случая
CREATE TABLE IF NOT EXISTS test.t_USL (                       
                        ID_USL varchar(36) NOT NULL,
						ID_SLUCH varchar(36) NOT NULL REFERENCES test.t_sl (ID_SLUCH) ON DELETE CASCADE ON UPDATE CASCADE, 
					    CODE_USL varchar(16) NOT NULL,
					    PRVS_USL numeric(9) NOT NULL,
					    DATEUSL date NOT NULL,
					    CODE_MD varchar(8) NOT NULL,
					    SKIND numeric(2) NOT NULL,
					    TYPEOPER numeric(3),
					    INTOX varchar(15),
					    DS_DENT varchar(10),
					    PODR_USL numeric(8) NOT NULL,
					    PROFIL_USL varchar(11) NOT NULL,
					    DET_USL numeric(1) NOT NULL,
					    BEDPROF numeric(3),
					    KOL_USL numeric(6,2) NOT NULL,
					    VID_VME varchar(15),
					    NPL numeric(1),
					    --SUMUSL
					TARIF numeric(15,2),	
					    COMENTU varchar(250),
					    --ERROR_USL
                   OSHIB numeric(3),
                   IM_POL varchar(20),
						CONSTRAINT t_usl_pk PRIMARY KEY (ID_USL));

--создание проседуры парсинга
CREATE OR REPLACE PROCEDURE test."P_INS_XML"(
	)
LANGUAGE 'sql'
AS $BODY$
--вставка данных в таблицу T_SCHET
insert into test.T_SCHET (CODE_MO,YEAR,MONTH,PLAT,COMENTS,OSHIB,IM_POL) 
--на первой итерации преобразуем text в xml. Проверку корректности не осуществляем (is document), полагая, что документ корректный
with VT_input_xml as (select txt::xml as xml from test.input_xml),
VT_SCHET  as (
--вторая итерация - забираем из /ZL_LIST/SCHET значения полей
select CODE_MO,YEAR,MONTH,PLAT,COMENTS,ERROR
from  VT_input_xml
  cross join xmltable ('/ZL_LIST/SCHET'
                       passing XML
                       columns 
					    CODE_MO varchar(6) path 'CODE_MO',
					    YEAR numeric(4) path 'YEAR',
					    MONTH numeric(2) path 'MONTH',
					    PLAT varchar(5) path 'PLAT',
					    COMENTS varchar(250) path 'COMENTS',
					    ERROR xml path 'ERROR'				   
						)), VT_ERR_SCHET as(
--третья итерация - разбор /ZL_LIST/SCHET/ERROR 							
select CODE_MO,OSHIB,IM_POL from VT_SCHET
cross join xmltable ('/ERROR' passing ERROR
				   columns
				   OSHIB numeric(3) path 'OSHIB',
                   IM_POL varchar(20) path 'IM_POL')) 
--результат третьей итерации присоединяем ко второй				   
select a.CODE_MO,a.YEAR,a.MONTH, a.PLAT, a.COMENTS, b.OSHIB ,b.IM_POL from VT_SCHET a left outer join VT_ERR_SCHET b on a.CODE_MO=b.CODE_MO;

--вставка данных в таблицу T_SL
insert into test.T_SL (Code_mo,ID_SLUCH,PR_NOV,VIDPOM,MODDATE,BEGDATE,ENDDATE,MO_CUSTOM,LPUBASE,ID_STAT,SMO,SMO_OK,NOVOR,LPUCODE,NPR_MO,NPR_TYPE,
	   NPR_MDCODE,EXTR,NHISTORY,CODE_MES1,CODE_MES2,APP_GOAL,RSLT,ISHOD,VID_HMP,METOD_HMP,PRVS_SL,PROFIL,DET,IDDOKT,POVOD,
	   OS_SLUCH,SIGNPAY,IDSP,GRP_SK,OPLATA,ED_COL,KOEFFCUR,IDSL,KOL_MAT,INV,VNOV,P_PER,PODR,TAL_D,TAL_P,NPR_DATE,SCH_CODE,
	   IT_TYPE,SRM_MARK,MSE,USL_OK,COMENTSL,PDT,ENP,W,DR,VPOLIS,SPOLIS,NPOLIS,FAM,IM,OT,MR,DOCTYPE,DOCSER,DOCNUM,
	   SNILS,OKATOG,OKATOP,STREET_F,HOUSE_F,HOUSELITER_F,CORPUS_F,FLAT_F,FLATLITER_F,
       DS_WAY,DS_IN,DS_MAIN,DS_DIFF,DS_SEC1,DS_SEC2,DS_DEAD,DS_IL,DS_DPA,
       DISPTYPE,DISPSTAGE,DISPGROUP,DISPPDSTAT,DISPFORM,NAZR,NAZ_SP,NAZ_V,NAZ_PMP,NAZ_PK,PR_D_N,VBR,P_OTK,
       SUMV,SUMP,SUMB,SUMB_S, TYPE_EXP,ORG_EXP,CODE_EXP,DATE_EXP,SANK,S_OSN,OSHIB, IM_POL) 
with VT_input_xml as (select txt::xml as xml from test.input_xml),--на первой итерации преобразуем text в xml
VT_SL  as (
--вторая итерация - забираем из /ZL_LIST/SCHET/SLUCH  значения полей, не забрать данные для внешнего ключа "CODE_MO"	
select code_mo,ID_SLUCH,PR_NOV,VIDPOM,MODDATE,BEGDATE,ENDDATE,MO_CUSTOM,LPUBASE,ID_STAT,SMO,SMO_OK,NOVOR,PD,LPUCODE,NPR_MO,NPR_TYPE,
	   NPR_MDCODE,EXTR,NHISTORY,DS,CODE_MES1,CODE_MES2,APP_GOAL,RSLT,ISHOD,VID_HMP,METOD_HMP,PRVS_SL,PROFIL,DET,IDDOKT,POVOD,
	   OS_SLUCH,DISP,SIGNPAY,IDSP,GRP_SK,OPLATA,ED_COL,KOEFFCUR,IDSL,KOL_MAT,INV,VNOV,P_PER,PODR,TAL_D,TAL_P,NPR_DATE,SCH_CODE,
	   IT_TYPE,SRM_MARK,MSE,USL_OK,SUMSLUCH,EXPERT,COMENTSL,ERROR_SL
from  VT_input_xml
  cross join xmltable ('/ZL_LIST/SCHET/SLUCH'
                       passing XML
                       columns 
					    CODE_MO varchar(6) path '../CODE_MO',
					    ID_SLUCH varchar(36) path 'ID_SLUCH',
					    PR_NOV  numeric(1) path 'PR_NOV',
					    VIDPOM numeric(2) path 'VIDPOM',
					   	MODDATE timestamp path 'MODDATE',
					    BEGDATE timestamp path 'BEGDATE',
					    ENDDATE timestamp path 'ENDDATE',
					    MO_CUSTOM varchar(6) path 'MO_CUSTOM',
					   	LPUBASE numeric(7) path 'LPUBASE',
					    ID_STAT numeric(1) path 'ID_STAT',
					    SMO varchar(5) path 'SMO',
					    SMO_OK varchar(5) path 'SMO_OK',
					    NOVOR varchar(9) path 'NOVOR',
						PD xml path 'PD',
					    LPUCODE numeric(7) path 'LPUCODE',
					    NPR_MO varchar(6) path 'NPR_MO',
					    NPR_TYPE  numeric(2) path 'NPR_TYPE',
					    NPR_MDCODE varchar(8) path 'NPR_MDCODE',
					    EXTR  numeric(2) path 'EXTR',
					    NHISTORY varchar(50) path 'NHISTORY',
					    DS xml path 'DS',
					   	CODE_MES1  varchar(16) path 'CODE_MES1',
					    CODE_MES2  varchar(16) path 'CODE_MES2',
					    APP_GOAL numeric(1) path 'APP_GOAL',
					    RSLT numeric(3) path 'RSLT',
					    ISHOD numeric(3) path 'ISHOD',
					    VID_HMP  varchar(12) path 'VID_HMP',
					    METOD_HMP numeric(3) path 'METOD_HMP',
					    PRVS_SL numeric(9) path 'PRVS',
					    PROFIL varchar(11) path 'PROFIL',
					    DET numeric(1) path 'DET',
					    IDDOKT varchar(8) path 'IDDOKT',
					    POVOD numeric(4,2) path 'POVOD',
					    OS_SLUCH numeric(1) path 'OS_SLUCH',
					    DISP xml path 'DISP',
					    SIGNPAY  numeric(1) path 'SIGNPAY',
					    IDSP  numeric(2) path 'IDSP',
					    GRP_SK  numeric(3) path 'GRP_SK',
					    OPLATA  numeric(1) path 'OPLATA',
					    ED_COL  numeric(5,2) path 'ED_COL',
					    KOEFFCUR  numeric(5,2) path 'KOEFFCUR',
					    IDSL  numeric(4) path 'IDSL',
					    KOL_MAT  numeric(5,2) path 'KOL_MAT',
					    INV  numeric(1) path 'INV',
					    VNOV  numeric(4) path 'VNOV',
					    P_PER  numeric(1) path 'P_PER',
					    PODR  numeric(8) path 'PODR',
					    TAL_D date path 'TAL_D',
					    TAL_P date path 'TAL_P',
					    NPR_DATE date path 'NPR_DATE',
					    SCH_CODE varchar(10) path 'SCH_CODE',
					    IT_TYPE varchar(10) path 'IT_TYPE',
					    SRM_MARK varchar(10) path 'SRM_MARK',
					    MSE  numeric(1) path 'MSE',
					    USL_OK  numeric(2) path 'USL_OK',
					    SUMSLUCH xml  path 'SUMSLUCH',	
					    EXPERT xml  path 'EXPERT',
					    COMENTSL  varchar(250) path 'COMENTSL',
					    ERROR_SL xml  path 'ERROR_SL'
						)), 
VT_PD as (
-- на третьей и последующей итерациях разбираем вложенные xml конструкции, в данном случае PD
select VT_SL.ID_SLUCH,PDT,ENP,W,DR,VPOLIS,SPOLIS,NPOLIS,FAM,IM,OT,MR,DOCTYPE,DOCSER,DOCNUM,SNILS,OKATOG,OKATOP,
STREET_F,HOUSE_F,HOUSELITER_F,CORPUS_F,FLAT_F,FLATLITER_F from VT_SL
cross join xmltable ('/PD' passing PD
				   columns
				   ID_SLUCH varchar(36) path '../ID_SLUCH',
                   PDT numeric(1) path 'PDT',
                   ENP varchar(16) path 'ENP',
                   W numeric(1) path 'W',
                   DR date path 'DR',
                   VPOLIS numeric(1) path 'VPOLIS',
                   SPOLIS varchar(10) path 'SPOLIS',
                   NPOLIS varchar(20) path 'NPOLIS',
                   FAM varchar(40) path 'FAM',
                   IM varchar(40) path 'IM',
                   OT varchar(40) path 'OT',
                   MR varchar(100) path 'MR',
                   DOCTYPE varchar(2) path 'DOCTYPE',
                   DOCSER varchar(10) path 'DOCSER',
                   DOCNUM varchar(20) path 'DOCNUM',
                   SNILS varchar(14) path 'SNILS',
                   OKATOG varchar(12) path 'OKATOG',
                   OKATOP varchar(12) path 'OKATOP',
                   STREET_F numeric(6) path 'STREET_F',
                   HOUSE_F numeric(4) path 'HOUSE_F',
                   HOUSELITER_F varchar(1) path 'HOUSELITER_F',
                   CORPUS_F numeric(2) path 'CORPUS_F',
                   FLAT_F numeric(4) path 'FLAT_F',
                   FLATLITER_F varchar(1) path 'FLATLITER_F')),
VT_DS as(
-- cледующая итерация - разбираем DS
select VT_SL.ID_SLUCH,DS_WAY,DS_IN,DS_MAIN,DS_DIFF,DS_SEC1,DS_SEC2,DS_DEAD,DS_IL,DS_DPA
from VT_SL
cross join xmltable ('/DS' passing DS
				   columns
				   ID_SLUCH varchar(36) path '../ID_SLUCH',
				   DS_WAY varchar(10) path 'DS_WAY',
				   DS_IN varchar(10) path 'DS_IN',
				   DS_MAIN varchar(10) path 'DS_MAIN',
				   DS_DIFF varchar(10) path 'DS_DIFF',
				   DS_SEC1 varchar(10) path 'DS_SEC1',
				   DS_SEC2 varchar(10) path 'DS_SEC2',
				   DS_DEAD varchar(10) path 'DS_DEAD',
				   DS_IL varchar(10) path 'DS_IL',
				   DS_DPA varchar(10) path 'DS_DPA')),
VT_DISP as(
-- cледующая итерация - разбираем DISP	
select VT_SL.ID_SLUCH,DISPTYPE,DISPSTAGE,DISPGROUP,DISPPDSTAT,DISPFORM,NAZR,NAZ_SP,NAZ_V,NAZ_PMP,NAZ_PK,PR_D_N,VBR,P_OTK from VT_SL
cross join xmltable ('/DISP' passing DISP
				   columns
				   ID_SLUCH varchar(36) path '../ID_SLUCH',
				   DISPTYPE numeric(1) path 'DISPTYPE',
				   DISPSTAGE numeric(1) path 'DISPSTAGE',
				   DISPGROUP varchar(2) path 'DISPGROUP',
				   DISPPDSTAT numeric(1) path 'DISPPDSTAT',
				   DISPFORM numeric(1) path 'DISPFORM',
				   NAZR numeric(2) path 'NAZR',
				   NAZ_SP numeric(4) path 'NAZ_SP',
				   NAZ_V numeric(1) path 'NAZ_V',
				   NAZ_PMP numeric(3) path 'NAZ_PMP',
				   NAZ_PK numeric(3) path 'NAZ_PK',
				   PR_D_N numeric(1) path 'PR_D_N',
				   VBR numeric(1) path 'VBR',
				   P_OTK numeric(1) path 'P_OTK')),
VT_SUMSLUCH as(
-- cледующая итерация - разбираем SUMSLUCH
select VT_SL.ID_SLUCH,SUMV,SUMP,SUMB,SUMB_S from VT_SL
cross join xmltable ('/SUMSLUCH' passing SUMSLUCH
				   columns
				   ID_SLUCH varchar(36) path '../ID_SLUCH',		
				   SUMV numeric(15,2) path 'SUMV',
				   SUMP numeric(15,2) path 'SUMP',
				   SUMB numeric(15,2) path 'SUMB',
				   SUMB_S numeric(15,2) path 'SUMB_S')),
VT_EXPERT as(
-- cледующая итерация - разбираем EXPERT	
select VT_SL.ID_SLUCH,TYPE_EXP,ORG_EXP,CODE_EXP,DATE_EXP,SANK,S_OSN from VT_SL
cross join xmltable ('/EXPERT' passing EXPERT
				   columns
				   ID_SLUCH varchar(36) path '../ID_SLUCH',	
				   TYPE_EXP numeric(1) path 'TYPE_EXP',
				   ORG_EXP varchar(6) path 'ORG_EXP',
				   CODE_EXP varchar(8) path 'CODE_EXP',
				   DATE_EXP date path 'DATE_EXP',
				   SANK numeric(15,2) path 'SANK',
				   S_OSN numeric(3) path 'S_OSN')),	 
VT_ERR_SL as(
-- cледующая итерация - разбираем ERROR
select VT_SL.ID_SLUCH,OSHIB,IM_POL from VT_SL
cross join xmltable ('/ERROR' passing ERROR_SL
				   columns
				   ID_SLUCH varchar(36) path '../ID_SLUCH',
				   OSHIB numeric(3) path 'OSHIB',
                   IM_POL varchar(20) path 'IM_POL')) 
--результат - выборка ворой итерации и присоединение всех разобранных вложенных фрагмнтов				   
select 
a.Code_mo,a.ID_SLUCH,a.PR_NOV,a.VIDPOM,a.MODDATE,a.BEGDATE,a.ENDDATE,a.MO_CUSTOM,a.LPUBASE,a.ID_STAT,a.SMO,a.SMO_OK,a.NOVOR,a.LPUCODE,
a.NPR_MO,a.NPR_TYPE,a.NPR_MDCODE,a.EXTR,a.NHISTORY,a.CODE_MES1,a.CODE_MES2,a.APP_GOAL,a.RSLT,ISHOD,a.VID_HMP,a.METOD_HMP,a.PRVS_SL,a.PROFIL,
a.DET,a.IDDOKT,a.POVOD,a.OS_SLUCH,a.SIGNPAY,a.IDSP,a.GRP_SK,a.OPLATA,a.ED_COL,a.KOEFFCUR,a.IDSL,a.KOL_MAT,a.INV,a.VNOV,a.P_PER,
a.PODR,a.TAL_D,a.TAL_P,a.NPR_DATE,a.SCH_CODE,a.IT_TYPE,a.SRM_MARK,a.MSE,a.USL_OK,a.COMENTSL,
b.PDT,b.ENP,b.W,b.DR,b.VPOLIS,b.SPOLIS,b.NPOLIS,b.FAM,b.IM,b.OT,b.MR,b.DOCTYPE,b.DOCSER,b.DOCNUM,b.SNILS,b.OKATOG,b.OKATOP,
b.STREET_F,b.HOUSE_F,b.HOUSELITER_F,b.CORPUS_F,b.FLAT_F,b.FLATLITER_F,	
c.DS_WAY,c.DS_IN,c.DS_MAIN,c.DS_DIFF,c.DS_SEC1,c.DS_SEC2,c.DS_DEAD,c.DS_IL,c.DS_DPA,
d.DISPTYPE,d.DISPSTAGE,d.DISPGROUP,d.DISPPDSTAT,d.DISPFORM,d.NAZR,d.NAZ_SP,d.NAZ_V,d.NAZ_PMP,d.NAZ_PK,d.PR_D_N,d.VBR,d.P_OTK,
e.SUMV,e.SUMP,e.SUMB,e.SUMB_S,
f.TYPE_EXP,f.ORG_EXP,f.CODE_EXP,f.DATE_EXP,f.SANK,f.S_OSN,			 
g.OSHIB ,g.IM_POL from VT_SL a 
	left outer join VT_PD b on a.ID_SLUCH=b.ID_SLUCH
	left outer join VT_DS c on a.ID_SLUCH=c.ID_SLUCH	
	left outer join VT_DISP d on a.ID_SLUCH=d.ID_SLUCH
    left outer join VT_SUMSLUCH e on a.ID_SLUCH=e.ID_SLUCH
    left outer join VT_EXPERT f on a.ID_SLUCH=f.ID_SLUCH	 
	left outer join VT_ERR_SL g on a.ID_SLUCH=g.ID_SLUCH; 
	

--вставка данных в таблицу T_USL
insert into test.T_USL(ID_SLUCH,ID_USL,CODE_USL,PRVS_USL,DATEUSL,CODE_MD,SKIND,TYPEOPER,INTOX,DS_DENT,PODR_USL,PROFIL_USL,DET_USL,BEDPROF,
				       KOL_USL,VID_VME,NPL,COMENTU,TARIF,OSHIB ,IM_POL)
with VT_input_xml as (select txt::xml as xml from test.input_xml), --на первой итерации преобразуем text в xml
--вторая итерация - забираем из /ZL_LIST/SCHET/SLUCH/USL  значения полей, не забрать данные для внешнего ключа "ID_SLUCH"
VT_USL  as (select ID_SLUCH,ID_USL,CODE_USL,PRVS_USL,DATEUSL,CODE_MD,SKIND,TYPEOPER,INTOX,DS_DENT,PODR_USL,PROFIL_USL,DET_USL,BEDPROF,
				       KOL_USL,VID_VME,NPL,SUMUSL,COMENTU,ERROR_USL 
from  VT_input_xml
  cross join xmltable ('/ZL_LIST/SCHET/SLUCH/USL'
                       passing XML
                       columns 
					    ID_SLUCH varchar(36) path '../ID_SLUCH',			
                        ID_USL varchar(36) path 'ID_USL',
					    CODE_USL varchar(16) path 'CODE_USL',
					    PRVS_USL numeric(9) path 'PRVS',
					    DATEUSL date path 'DATEUSL',
					    CODE_MD varchar(8) path 'CODE_MD',
					    SKIND numeric(2) path 'SKIND',
					    TYPEOPER numeric(3) path 'TYPEOPER',
					    INTOX varchar(15) path 'INTOX',
					    DS_DENT varchar(10) path 'DS_DENT',
					    PODR_USL numeric(8) path 'PODR',
					    PROFIL_USL varchar(11) path 'PROFIL',
					    DET_USL numeric(1) path 'DET',
					    BEDPROF numeric(3) path 'BEDPROF',
					    KOL_USL numeric(6,2) path 'KOL_USL',
					    VID_VME varchar(15) path 'VID_VME',
					    NPL numeric(1) path 'NPL',
					    SUMUSL xml path 'SUMUSL',
					    COMENTU varchar(250) path 'COMENTU',
					    ERROR_USL xml path 'ERROR_USL')),
VT_SUMUSL as(
-- cледующая итерация - разбираем SUMUSL	
select VT_USL.ID_USL,TARIF from VT_USL
cross join xmltable ('/SUMUSL' passing SUMUSL
				   columns
				   ID_USL varchar(36) path '../ID_USL',		
				   TARIF numeric(15,2) path 'TARIF')),
VT_ERR_USL as(
-- cледующая итерация - разбираем ERROR
select VT_USL.ID_USL,OSHIB,IM_POL from VT_USL
cross join xmltable ('/ERROR' passing ERROR_USL
				   columns
				   ID_USL varchar(36) path '../ID_USL',	
				   OSHIB numeric(3) path 'OSHIB',
                   IM_POL varchar(20) path 'IM_POL')) 
--результат - выборка ворой итерации и присоединение двух разобранных вложенных фрагмнтов						   
select 
a.ID_SLUCH,a.ID_USL,a.CODE_USL,a.PRVS_USL,a.DATEUSL,a.CODE_MD,a.SKIND,a.TYPEOPER,a.INTOX,a.DS_DENT,a.PODR_USL,a.PROFIL_USL,a.DET_USL,a.BEDPROF,
a.KOL_USL,a.VID_VME,a.NPL,a.COMENTU,b.TARIF,c.OSHIB ,c.IM_POL from VT_USL a 
	left outer join VT_SUMUSL b on a.ID_USL=b.ID_USL
	left outer join VT_ERR_USL c on a.ID_USL=c.ID_USL; 
$BODY$;


insert into test.input_xml values (
'<?xml version="1.0" encoding="WINDOWS-1251"?>
<!--version 1.6 created by TFOMS Samara (OVE24*SSS27)) 01.10.2016-->
<ZL_LIST xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="schet.xsd">
  <ZGLV>
    <VERSION>1.6</VERSION>
    <DATA>2018-02-01</DATA>
    <FROM_SUBJ>63</FROM_SUBJ>
    <TO_SUBJ>63001</TO_SUBJ>
    <TYPEMESS>11</TYPEMESS>
    <FNAME>740A8BA3-1550-4D27-ACF6-197FA273EBE4</FNAME>
    <CRC32>01234567</CRC32>
  </ZGLV>
  <SCHET>
    <CODE_MO>630177</CODE_MO>
    <YEAR>2018</YEAR>
    <MONTH>1</MONTH>
    <PLAT>63001</PLAT>
    <COMENTS>&lt;TO_PLAT&gt;</COMENTS>
    <SLUCH>
      <ID_SLUCH>032916C1-6D4B-4032-9FB7-435A373D4FDB</ID_SLUCH>
      <PR_NOV>0</PR_NOV>
      <VIDPOM>31</VIDPOM>
      <MODDATE>2018-02-01T09:52:08</MODDATE>
      <BEGDATE>2018-01-02T00:00:00</BEGDATE>
      <ENDDATE>2018-01-30T00:00:00</ENDDATE>
      <MO_CUSTOM>630061</MO_CUSTOM>
      <LPUBASE>4098</LPUBASE>
      <ID_STAT>1</ID_STAT>
      <SMO>63001</SMO>
      <SMO_OK>36000</SMO_OK>
      <PD>
        <PDT>1</PDT>
        <ENP>6368636863686368</ENP>
        <W>1</W>
        <DR>1948-01-01</DR>
        <VPOLIS>3</VPOLIS>
        <NPOLIS>6368636863686368</NPOLIS>
        <FAM>ИВАНОВ</FAM>
        <IM>ИВАН</IM>
        <OT>ИВАНОВИЧ</OT>
        <DOCTYPE>14</DOCTYPE>
        <DOCSER>36 36</DOCSER>
        <DOCNUM>363636</DOCNUM>
        <OKATOG>364403680001</OKATOG>
      </PD>
      <LPUCODE>10772</LPUCODE>
      <NPR_MO>630061</NPR_MO>
      <NPR_TYPE>1</NPR_TYPE>
      <NPR_MDCODE>П302125</NPR_MDCODE>
      <EXTR>1</EXTR>
      <NHISTORY>115/18</NHISTORY>
      <DS>
        <DS_WAY>N18.5</DS_WAY>
        <DS_IN>N18.5</DS_IN>
        <DS_MAIN>N18.5</DS_MAIN>
      </DS>
      <RSLT>201</RSLT>
      <ISHOD>203</ISHOD>
      <PRVS>261</PRVS>
      <PROFIL>56</PROFIL>
      <DET>0</DET>
      <IDDOKT>В530071</IDDOKT>
      <DISP/>
      <SIGNPAY>1</SIGNPAY>
      <IDSP>43</IDSP>
      <GRP_SK>65</GRP_SK>
      <OPLATA>0</OPLATA>
      <ED_COL>1</ED_COL>
      <P_PER>1</P_PER>
      <PODR>10772001</PODR>
      <NPR_DATE>2018-01-01</NPR_DATE>
      <USL_OK>2</USL_OK>
      <SUMSLUCH>
        <SUMV>83720</SUMV>
      </SUMSLUCH>
      <COMENTSL>&lt;2&gt;01.02.18&lt;INSURER&gt;</COMENTSL>
      <USL>
        <ID_USL>102157F5-6D3F-4341-85CF-B49E7C793CF6</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-09</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>2B3AB183-9D16-4FE8-8595-F66E9E7C5EE2</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-20</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>315D2962-6587-4EE2-9E7C-2D6EB4C6E6E3</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-02</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>428716DA-D6A4-48E8-A316-FA074602863D</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-27</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>51F0612B-C8C2-4EB9-9B20-FC9AB37582E0</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-23</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>678CD1D6-5F7D-47E3-BC60-6FA8E3C9D806</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-30</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>6C998351-C2BC-4FDC-AB62-2862FECE260E</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-13</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>757BA9F6-BA1B-4BD7-8E40-FCDF94C801B2</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-18</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>9DEB0F51-C2E3-4706-B822-19C89B561777</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-04</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>E1BBC39E-EB56-49B8-BC56-194589448603</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-06</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>E1CE4C84-5622-4417-A62C-A1CEF469DAE8</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-11</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>EFD0BE46-5457-4ABE-B48C-3F7679628A54</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-16</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>F010B1BE-0586-4404-8519-9BF92A4B3809</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-25</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
    </SLUCH>
    <SLUCH>
      <ID_SLUCH>C7D97747-719C-41B3-98CF-23D8F6ABC1F8</ID_SLUCH>
      <PR_NOV>0</PR_NOV>
      <VIDPOM>31</VIDPOM>
      <MODDATE>2018-02-01T09:52:09</MODDATE>
      <BEGDATE>2018-01-01T00:00:00</BEGDATE>
      <ENDDATE>2018-01-31T00:00:00</ENDDATE>
      <MO_CUSTOM>630052</MO_CUSTOM>
      <LPUBASE>4043</LPUBASE>
      <ID_STAT>1</ID_STAT>
      <SMO>63018</SMO>
      <SMO_OK>36000</SMO_OK>
      <PD>
        <PDT>1</PDT>
        <ENP>6350635063506350</ENP>
        <W>1</W>
        <DR>1951-01-01</DR>
        <VPOLIS>3</VPOLIS>
        <NPOLIS>6350635063506350</NPOLIS>
        <FAM>ТЕСТОВ</FAM>
        <IM>ТЕСТ</IM>
        <OT>ТЕСТОВИЧ</OT>
        <DOCTYPE>14</DOCTYPE>
        <DOCSER>36 36</DOCSER>
        <DOCNUM>777777</DOCNUM>
        <OKATOG>364403630001</OKATOG>
      </PD>
      <LPUCODE>10772</LPUCODE>
      <NPR_MO>630052</NPR_MO>
      <NPR_TYPE>1</NPR_TYPE>
      <NPR_MDCODE>Х555862</NPR_MDCODE>
      <EXTR>1</EXTR>
      <NHISTORY>2/18</NHISTORY>
      <DS>
        <DS_WAY>N18.5</DS_WAY>
        <DS_IN>N18.5</DS_IN>
        <DS_MAIN>N18.5</DS_MAIN>
      </DS>
      <RSLT>201</RSLT>
      <ISHOD>203</ISHOD>
      <PRVS>261</PRVS>
      <PROFIL>56</PROFIL>
      <DET>0</DET>
      <IDDOKT>В530071</IDDOKT>
      <DISP/>
      <SIGNPAY>1</SIGNPAY>
      <IDSP>43</IDSP>
      <GRP_SK>65</GRP_SK>
      <OPLATA>0</OPLATA>
      <ED_COL>1</ED_COL>
      <P_PER>1</P_PER>
      <PODR>10772001</PODR>
      <NPR_DATE>2018-01-01</NPR_DATE>
      <USL_OK>2</USL_OK>
      <SUMSLUCH>
        <SUMV>109480</SUMV>
      </SUMSLUCH>
      <COMENTSL>&lt;2&gt;01.02.18&lt;INSURER&gt;</COMENTSL>
      <USL>
        <ID_USL>1B381E1F-6587-4502-9AF8-2FA8A08684E3</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-20</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>24C9C79D-9876-409F-B3CB-C0E5C5FB2C60</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-12</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>26344CFB-9FAF-42BB-94F0-205098CB1125</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-19</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>26F604E6-4C95-47BA-90BD-971BC1C138B3</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-22</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>4787BF05-0F7A-47A3-8C8D-E76B288F8AE8</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-05</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>4A9F4BBD-F2D6-402C-9F3D-CEDF19189E05</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-08</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>54440776-C20A-421F-AD55-1BF86B48B11F</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-17</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>5C4B892F-5EA0-4081-897A-6E8F821824CD</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-10</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>7F8A5B70-AEC1-4587-B1B3-7A67257B1D8E</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-31</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>9AEAA7CD-09DB-453B-AA0A-9147BCCF5739</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-15</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>B8618335-56CD-49CD-A94D-655E01C1B6C7</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-24</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>BC9DD611-505A-428B-8003-E740DA138EBD</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-03</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>DC3FEB35-F25B-4694-B36A-861052EBB607</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-06</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>E0DB71A7-8F20-440A-BF0C-69C172C2D420</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-29</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>E6D61600-9EAB-4534-B80D-8A72938AF5CC</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-26</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>EC7A952F-086C-40D5-9BC2-1B0F70EE3084</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-27</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>F32AA9D7-69A6-43E6-B9ED-66ADB5CEE42B</ID_USL>
        <CODE_USL>700301</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-01</DATEUSL>
        <CODE_MD>В530071</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6440</TARIF>
        </SUMUSL>
      </USL>
    </SLUCH>
    <SLUCH>
      <ID_SLUCH>ED6C8280-D3E2-4D5C-AB1D-D1B68CC4A41E</ID_SLUCH>
      <PR_NOV>0</PR_NOV>
      <VIDPOM>31</VIDPOM>
      <MODDATE>2018-02-01T09:52:08</MODDATE>
      <BEGDATE>2018-01-01T00:00:00</BEGDATE>
      <ENDDATE>2018-01-31T00:00:00</ENDDATE>
      <MO_CUSTOM>630051</MO_CUSTOM>
      <LPUBASE>4026</LPUBASE>
      <ID_STAT>1</ID_STAT>
      <SMO>63001</SMO>
      <SMO_OK>36000</SMO_OK>
      <PD>
        <PDT>1</PDT>
        <ENP>6351635163516351</ENP>
        <W>1</W>
        <DR>1962-01-01</DR>
        <VPOLIS>3</VPOLIS>
        <NPOLIS>6351635163516351</NPOLIS>
        <FAM>ПРОБНИКОВ</FAM>
        <IM>ПРОБНИК</IM>
        <OT>ПРОБНИКОВИЧ</OT>
        <DOCTYPE>14</DOCTYPE>
        <DOCSER>36 63</DOCSER>
        <DOCNUM>123456</DOCNUM>
        <OKATOG>364403630001</OKATOG>
      </PD>
      <LPUCODE>10772</LPUCODE>
      <NPR_MO>630051</NPR_MO>
      <NPR_TYPE>1</NPR_TYPE>
      <NPR_MDCODE>Г533919</NPR_MDCODE>
      <EXTR>1</EXTR>
      <NHISTORY>41/18</NHISTORY>
      <DS>
        <DS_WAY>N18.5</DS_WAY>
        <DS_IN>N18.5</DS_IN>
        <DS_MAIN>N18.5</DS_MAIN>
      </DS>
      <RSLT>201</RSLT>
      <ISHOD>203</ISHOD>
      <PRVS>261</PRVS>
      <PROFIL>56</PROFIL>
      <DET>0</DET>
      <IDDOKT>И495416</IDDOKT>
      <DISP/>
      <SIGNPAY>1</SIGNPAY>
      <IDSP>43</IDSP>
      <GRP_SK>65</GRP_SK>
      <OPLATA>0</OPLATA>
      <ED_COL>1</ED_COL>
      <P_PER>1</P_PER>
      <PODR>10772001</PODR>
      <NPR_DATE>2018-01-01</NPR_DATE>
      <USL_OK>2</USL_OK>
      <SUMSLUCH>
        <SUMV>87444</SUMV>
      </SUMSLUCH>
      <COMENTSL>&lt;2&gt;01.02.18&lt;INSURER&gt;</COMENTSL>
      <USL>
        <ID_USL>28463213-DA7E-4F3E-9F22-C8CE630FF0BF</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-05</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>3B3DEAB4-BD9A-4DEE-8316-78398883175D</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-29</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>595987B1-2E07-4F3B-B6E4-620F959A21A6</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-31</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>5D9E6126-522F-4AB0-A7C4-DDE728E11B62</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-24</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>768CFF84-4F7B-4981-91C4-B15D015876F6</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-26</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>8081914E-EAFF-4B3D-ABEA-A64A4A5CD709</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-01</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>AE35C86C-6EB5-4BF7-BB06-CBDB6A41D97A</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-17</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>B79A7826-430B-4F4B-AAFF-091C4DEAEE17</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-03</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>BDAE3834-890C-411A-9447-88A6FB407A7C</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-15</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>BF0275D7-F827-48D4-B93A-473A50F996C0</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-10</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>C086F75F-BAE8-445C-8287-E596C1943E6E</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-19</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>C4D09658-D52B-4010-8DB1-19C9AD6DC602</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-22</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>C854984E-B70E-4D4C-AD56-9D52F2B02565</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-12</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>
      <USL>
        <ID_USL>E75EFEA2-E2F9-4578-816B-1A891AC3D098</ID_USL>
        <CODE_USL>700300</CODE_USL>
        <PRVS>261</PRVS>
        <DATEUSL>2018-01-08</DATEUSL>
        <CODE_MD>И495416</CODE_MD>
        <SKIND>35</SKIND>
        <TYPEOPER>8</TYPEOPER>
        <PODR>10772001</PODR>
        <PROFIL>56</PROFIL>
        <DET>0</DET>
        <BEDPROF>78</BEDPROF>
        <KOL_USL>1</KOL_USL>
        <SUMUSL>
          <TARIF>6246</TARIF>
        </SUMUSL>
      </USL>h
    </SLUCH>
  </SCHET>
</ZL_LIST>');

call test."P_INS_XML"(); --вызов процедуры парсинга
commit; -- завершение транзакции

