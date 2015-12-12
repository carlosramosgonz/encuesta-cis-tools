#!/usr/bin/env perl

# Convierte el archivo de microdatos del CIS en un CSV
# Válido para la encuesta preelectoral del CIS de 2015.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Descripción de los campos
# Lista de pares: el primer elemento de cada par es la posición
# donde comienza el campo/columna, el segundo es el final (o '0' si consta
# sólo de un caracter)
my @extraer = (
    [0, 3],
    [4, 8],
    [9, 10],
    [11, 12],
    [13, 15],
    [16, 0],
    [17, 0],
    [18, 19],
    [20, 22],
    [23, 26],
    [27, 0],
    [28, 0],
    [29, 30],
    [31, 0],
    [32, 0],
    [33, 0],
    [34, 0],
    [35, 0],
    [36, 0],
    [37, 0],
    [38, 0],
    [39, 0],
    [40, 0],
    [41, 0],
    [42, 0],
    [43, 0],
    [44, 0],
    [45, 0],
    [46, 0],
    [47, 0],
    [48, 0],
    [49, 0],
    [50, 0],
    [51, 0],
    [52, 53],
    [54, 55],
    [56, 57],
    [58, 59],
    [60, 61],
    [62, 63],
    [64, 65],
    [66, 67],
    [68, 69],
    [70, 71],
    [72, 73],
    [74, 75],
    [76, 77],
    [78, 79],
    [80, 0],
    [81, 0],
    [82, 83],
    [84, 85],
    [86, 87],
    [88, 89],
    [90, 91],
    [92, 93],
    [94, 0],
    [95, 0],
    [96, 97],
    [98, 99],
    [100, 101],
    [102, 103],
    [104, 105],
    [106, 107],
    [108, 109],
    [110, 111],
    [112, 113],
    [114, 115],
    [116, 117],
    [118, 119],
    [120, 121],
    [122, 123],
    [124, 125],
    [126, 127],
    [128, 129],
    [130, 131],
    [132, 133],
    [134, 135],
    [136, 137],
    [138, 139],
    [140, 141],
    [142, 143],
    [144, 145],
    [146, 147],
    [148, 149],
    [150, 151],
    [152, 153],
    [154, 155],
    [156, 157],
    [158, 159],
    [160, 161],
    [162, 163],
    [164, 165],
    [166, 0],
    [167, 168],
    [169, 170],
    [171, 172],
    [173, 174],
    [175, 176],
    [177, 178],
    [179, 180],
    [181, 182],
    [183, 184],
    [185, 186],
    [187, 188],
    [189, 190],
    [191, 192],
    [193, 194],
    [195, 196],
    [197, 198],
    [199, 200],
    [201, 202],
    [203, 204],
    [205, 206],
    [207, 208],
    [209, 0],
    [210, 0],
    [211, 0],
    [212, 213],
    [214, 0],
    [215, 216],
    [217, 0],
    [218, 219],
    [220, 0],
    [221, 0],
    [222, 0],
    [223, 224],
    [225, 226],
    [227, 0],
    [228, 0],
    [229, 0]
);

# Nombre de cada columna
my @columnas = (
    "id_estudio",
    "id_cuestionario",
    "id_comunidad",
    "id_provincia",
    "id_municipio",
    "tamano_habitat",
    "capital",
    "distrito",
    "seccion",
    "id_entrevistador",
    "sin_usar",
    "nacionalidad",
    "otra_nacionalidad",
    "interes_politica",
    "habla_politica",
    "situacion_politica",
    "situacion_economica",
    "valoracion_gobierno",
    "valoracion_gobierno_psoe",
    "valoracion_oposicion",
    "val_empleo",
    "val_educacion",
    "val_sanidad",
    "val_economia",
    "val_europa",
    "val_pol_social",
    "val_seguridad_ciud",
    "val_vivienda",
    "val_inmigracion",
    "val_autonomias",
    "val_medio_ambiente",
    "val_pol_exterior",
    "val_igualdad_hom_muj",
    "val_infraestructuras",
    "partido_empleo",
    "partido_educacion",
    "partido_sanidad",
    "partido_economia",
    "partido_europa",
    "partido_pol_social",
    "partido_seguridad_ciud",
    "partido_vivienda",
    "partido_inmigracion",
    "partido_autonomias",
    "partido_medio_ambiente",
    "partido_pol_exterior",
    "partido_igualdad",
    "partido_infraestructuras",
    "votara",
    "voto_decidido",
    "duda_primera_opcion",
    "duda_segunda_opcion",
    "partido_votara",
    "partido_simpatia",
    "partido_cree_ganara",
    "partido_gustaria_ganara",
    "prefiere_mayoria_absoluta",
    "quiere_partido_distinto_gob",
    "val_sostres",
    "val_boldovi",
    "val_koldo",
    "val_bosch",
    "val_herzog",
    "val_duran",
    "val_esteban",
    "val_errekondo",
    "val_olaia",
    "val_garzon",
    "val_iglesias",
    "val_macias",
    "val_oramas",
    "val_rajoy",
    "val_rivera",
    "val_salvador",
    "val_sanchez",
    "prob_votar",
    "prob_votar_pp",
    "prob_votar_psoe",
    "prob_votar_iu",
    "prob_votar_upyd",
    "prob_votar_cs",
    "prob_votar_ps",
    "prob_votar_cdc",
    "prob_votar_erc",
    "prob_votar_unio",
    "prob_votar_pnv",
    "prob_votar_bildu",
    "prob_votar_bng",
    "prob_votar_cc",
    "prob_votar_compromis",
    "prob_votar_fac",
    "prob_votar_geroabai",
    "prob_votar_upn",
    "voto_europeas",
    "partido_europeas",
    "escala_izq_der",
    "escala_pp",
    "escala_psoe",
    "escala_iu",
    "escala_upyd",
    "escala_cs",
    "escala_ps",
    "escala_cdc",
    "escala_erc",
    "escala_unio",
    "escala_pnv",
    "escala_bildu",
    "escala_bng",
    "escala_cc",
    "escala_compromis",
    "escala_fac",
    "escala_geroabai",
    "escala_upn",
    "clas_ideologica",
    "clas_ideologica_2",
    "sentimiento_nacion",
    "org_territorial",
    "voto_comunidad",
    "partido_comunidad",
    "sexo",
    "edad",
    "tiene_estudios",
    "nivel_estudios",
    "situacion_laboral",
    "nacionalidad_adquirida",
    "nacido_espana",
    "comunidad_nacimiento",
    "pais_nacimiento",
    "uso_internet",
    "tiene_fijo",
    "tiene_movil"
);

sub extraer {
    my $linea = shift;
    my @campos = ();

    for my $i (0 .. $#extraer) {
	my $pair = $extraer[$i];
	my $valor;
	if ($pair->[1] == 0) {
	    $valor = substr $linea, $pair->[0], 1;
	} else {
	    my $len = $pair->[1] - $pair->[0] + 1;
	    $valor = substr $linea, $pair->[0], $len;
	}

	$_ = $valor;
	s/^ +//;    # eliminar los espacios iniciales sobrantes
	push @campos, $_;
    }
    return @campos;
}

# comprobar que los arrays con las columnas están en orden...
# Nota: sería mejor directamente un hash? probablemente...
die "Formato columnas incorrecto, $#extraer != $#columnas" unless ($#extraer == $#columnas);

# escribir primero los nombres de los campos
for my $i (0 .. $#columnas) {
    print $columnas[$i];
    if ($i < $#columnas) {
	print ',';
    }
}
print "\n";

#my $MAX_LINEAS = 50;   # sólo leer las 50 primeras por ahora
#my $num_linea = 0;
while (my $linea = <>) {
    my @campos = extraer($linea);
    for my $campo (0 .. $#campos) {
	print "$campos[$campo]";
	if ($campo < $#campos) {
	    print ',';
	}
    }
    print "\n";
}
