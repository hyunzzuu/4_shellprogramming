#!/bin/bash

TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3 
TMP4=/tmp/tmp4

# 1. PV
# 2. VG
# 3. LV

#######################
# 1. PV
#######################
# (1) View
while true
do
fdisk -l | grep LVM | awk '{print $1}' > $TMP1
pvs | tail -n +2 | awk '{print $1}' > $TMP2

cat << EOF
############# PV VIEW #############
$(cat $TMP1 $TMP2 | sort | uniq -u)
###################################

EOF

# (2) Works
echo "=> 위의 목록에서 PV로 생성하고 싶은 볼륨을 선택합니다. <="
echo -n "볼륨 선택? (ex: /dev/sdb1 /dev/sdc1...) : "
read VOLUME

echo -n "pvcreate를 수행하시겠습니까?(y|n|s|e) : "
read A1
case $A1 in
    y) : ;;
    n) continue ;;
    s) break ;;
    e) exit ;;
    *) continue
esac

pvcreate $VOLUME >/dev/null  2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Physical volume $VOLUME successfully created."
    pvs
else
    echo "[ FAIL ] Physical volume not created."
    exit 1
fi

#######################
# 2. VG
#######################
# (1) View
vgs | tail -n +2 | awk '{print $1}' > $TMP3 
pvs > $TMP4
for i in $(cat $TMP3)
do
    sed -i "/$i/d" $TMP4
done
#fi

cat << EOF
############# PV LIST #############
$(cat $TMP4)
###################################
EOF
echo -n "vgcreate를 수행하시겠습니까?(y|n|s|e) : "
read A1
case $A1 in
    y) : ;;
    n) continue ;;
    s) break ;;
    e) exit ;;
    *) continue
esac

# (2) Works
# vgcreate vg1 /dev/sdb1 dev/sdc1
echo -n "VG NAME? (ex: vg1) : "
read VGNAME

echo -n "선택가능한 PV 목록을 적어주세요 (ex: /dev/sdb1 /dev/sdc1...)"
read PVLIST

vgcreate $VGNAME $PVLIST
if [ $? -eq 0 ] ; then 
    echo "[ OK ] Volume group $VGNAME successfully created."
    echo "======================================"
    vgs
    echo "======================================"
else 
    echo "[ FAIL ] Volume group not created."
    exit 2
fi


#######################
# 3. LV
#######################
# (1) View

cat << EOF
############# VG LIST #############
$(vgs | awk '$7 != '0' {print $0}')
###################################

EOF
echo -n "lvcreate를 수행하시겠습니까?(y|n|s|e) : "
read A1
case $A1 in
    y) : ;;
    n) continue ;;
    s) break ;;
    e) exit ;;
    *) continue
esac
# (2) Works
# lvcreate vg1 -n lv1 -L 500m

echo -n "LV를 생성할 VG 이름은? (ex: vg1) : "
read VGLV

echo -n "생성할 LV 이름은? (ex: lv1) : "
read LVNAME

echo -n "LV 용량은? (ex: 500m) : "
read LVSIZE

lvcreate $VGLV -n $LVNAME -L $LVSIZE >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "[ OK ] Logical Volume $LVNAME successfully created."
    echo "======================================"
    lvs
    echo "======================================"
else
    echo "[ FAIL ] Logical Volume not created."
    exit 3
fi
done