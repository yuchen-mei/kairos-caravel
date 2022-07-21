#!/bin/bash

while getopts ":p:" opt; do
  case $opt in
    p)
      build_dir=$OPTARG
      echo "Build directory: $build_dir" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

top="user_proj_example"

gds_src="$build_dir/21-cadence-innovus-signoff/outputs/design-merged.gds"
lef_src="$build_dir/21-cadence-innovus-signoff/outputs/design.lef"
def_src="$build_dir/21-cadence-innovus-signoff/outputs/design.def.gz"
gl_src="$build_dir/21-cadence-innovus-signoff/outputs/design.virtuoso.v"
spef_src="$build_dir/21-cadence-innovus-signoff/outputs/design.spef.gz"
rtl_src="./verilog/rtl_kairos/kairos_top.v"
sram_lef="$build_dir/7-sram/outputs/sky130_sram_1kbyte_1rw1r_32x256_8.lef"

gds_dest="./gds/$top.gds"
lef_dest="./lef/$top.lef"
def_dest="./def/$top.def.gz"
gl_dest="./verilog/gl/$top.v"
spef_dest="./spef/$top.spef.gz"
rtl_dest="./verilog/rtl/$top.v"

echo "Copying $gds_src to $gds_dest"
cp $gds_src $gds_dest
echo "Copying $lef_src to $lef_dest"
cp $lef_src $lef_dest
echo "Copying $def_src to $def_dest"
cp $def_src $def_dest
echo "Copying $gl_src to $gl_dest"
cp $gl_src $gl_dest
echo "Copying $spef_src to $spef_dest"
cp $spef_src $spef_dest
echo "Copying $rtl_src to $rtl_dest"
cp $rtl_src $rtl_dest
cp sram_lef ./lef/

echo "Decompressing $def_dest"
gunzip $def_dest
echo "Decompressing $spef_dest"
gunzip $spef_dest
