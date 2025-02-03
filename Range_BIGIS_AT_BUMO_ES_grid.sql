select distinct a.id,a.cellcode,a.geom from
inventorizacija.cell_es_10x10km_lks a
join
(select st_union(st_buffer(geom,10)) as geom from
(select ST_ShortestLine(b.geom,a.geom) as geom from
(select id,cellcode, st_centroid(geom) as geom from
(select distinct a.id,a.cellcode,a.geom from
inventorizacija.cell_es_10x10km_lks a
join 

(select left(buveine,4) as buveine,'apsaugos tikslai' as saltinis, geom from apsaugos_tikslai.bast_zemelapiu_exportui_materiali 
where left(buveine,4) = '91D0' and statusas in ('patvirtintas', 'rengiamas')
union all
select buveine_domin as buveine, 'BIGIS' as saltinis, geom from bigis."bigisdb_plotai[senas]"
where buveine_domin = '91D0'
union all
select left(buveines_tipas,4) as buveine,'BUMO' as saltinis, geometrija as geom from bigis."misku_anketa_plotas" 
where left(buveines_tipas,4) = '91D0') 

b on st_intersects(a.geom,b.geom)
group by a.id,a.cellcode,a.geom) a) a,

(select id,cellcode, st_centroid(geom) as geom from
(select distinct a.id,a.cellcode,a.geom from
inventorizacija.cell_es_10x10km_lks a
join (select left(buveine,4) as buveine,'apsaugos tikslai' as saltinis, geom from apsaugos_tikslai.bast_zemelapiu_exportui_materiali 
where left(buveine,4) = '91D0' and statusas in ('patvirtintas', 'rengiamas')
union all
select buveine_domin as buveine, 'BIGIS' as saltinis, geom from bigis."bigisdb_plotai[senas]"
where buveine_domin = '91D0'
union all
select left(buveines_tipas,4) as buveine,'BUMO' as saltinis, geometrija as geom from bigis."misku_anketa_plotas" 
where left(buveines_tipas,4) = '91D0') b on st_intersects(a.geom,b.geom)
group by a.id,a.cellcode,a.geom) a) b

where a.id<b.id and ST_Length(ST_ShortestLine(b.geom,a.geom)) <= 49963.368

union all

select st_centroid(geom) as geom from
(select distinct a.id,a.cellcode,a.geom from
inventorizacija.cell_es_10x10km_lks a
join (select left(buveine,4) as buveine,'apsaugos tikslai' as saltinis, geom from apsaugos_tikslai.bast_zemelapiu_exportui_materiali 
where left(buveine,4) = '91D0' and statusas in ('patvirtintas', 'rengiamas')
union all
select buveine_domin as buveine, 'BIGIS' as saltinis, geom from bigis."bigisdb_plotai[senas]"
where buveine_domin = '91D0'
union all
select left(buveines_tipas,4) as buveine,'BUMO' as saltinis, geometrija as geom from bigis."misku_anketa_plotas" 
where left(buveines_tipas,4) = '91D0') b on st_intersects(a.geom,st_pointonsurface(b.geom))
group by a.id,a.cellcode,a.geom) a) a) b
on st_intersects(st_buffer(a.geom,-12),b.geom)
;
