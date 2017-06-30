#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
irange=$(cdo griddes MPIOM_rawgrid_GRIS_edge.nc | grep xsize | rev | cut -d ' ' -f1 | rev)
jrange=$(cdo griddes MPIOM_rawgrid_GRIS_edge.nc | grep ysize | rev | cut -d ' ' -f1 | rev)
for i in $(seq 1 $irange)
do
    for j in $(seq 1 $jrange)
    do
        val=$(cdo -s -output -selindexbox,$i,$i,$j,$j MPIOM_rawgrid_GRIS_edge.nc | tr -d '[:space:]' )
        echo $val
        if [ $val == 1 ]
        then
            echo $i $j >> index_file_combined.dat
            echo $i >> index_file_i.dat
            echo $j >> index_file_j.dat
        fi
    done
done
