#!/usr/bin/gnuplot -persist
reset
NO_ANIMATION = 1

set fit prescale

set key font "Times-Roman,20"
set tics font "Times-Roman,20"
set key left top

set terminal svg size 960, 540
set xlabel "Число n" font "Times-Roman,20"
set ylabel "Время вычисления величины 1/sqrt(n), нс" font "Times-Roman,20"
set grid

set output "./plots/O0.svg"
set title "Оптимизация O0" font "Times-Roman,20"
plot './postdata/data_fast_rsqrt/O0.txt' with lines lw 1 dashtype 1 lt rgb "red" title "fast\\\_rsqrt", \
 './postdata/data_rsqrt/O0.txt' with lines lw 1 dashtype 1 lt rgb "green" title "rsqrt"

set output "./plots/O2_rsqrt_only.svg"
set title "Оптимизация O2" font "Times-Roman,20"
plot './postdata/data_rsqrt/O2.txt' with lines lw 1 dashtype 1 lt rgb "green" title "rsqrt"

set output "./plots/O2_fast_rsqrt_only.svg"
set title "Оптимизация O2" font "Times-Roman,20"
plot './postdata/data_fast_rsqrt/O2.txt' with lines lw 1 dashtype 1 lt rgb "red" title "fast\\\_rsqrt"
