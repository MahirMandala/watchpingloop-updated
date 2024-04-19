#!/bin/bash
# Script Original By Akifa And Remod By Marga EDY
# Alamat host yang ingin Anda ping
HOST="alamat_host_anda" # Recommended Menggunakan Bug Yang Di Pake Pada Tun
# Variabel untuk menghitung berapa kali ping gagal
failed_count=0
# Waktu tunggu (detik) sebelum mengaktifkan mode pesawat setelah ping gagal
WAIT_TIME=1
# Nama Interface Yang Akan Di restart
INTERFACE_NAME="wan"
# Restart Tunnel Atau tidak
RESTART_TUNNEL=yes # yes = restart tunnel dan no = tidak restart tunnel
# Nama Tunnel Yang Akan Di Restart
TOOL_TUNNELING=openclash # TOOLS TUNNELING Supported = OPENCLASH, PASSWALL, NEKOCLASH, V2RAYA


# funtion ENABLE MODE PESAWAT
enable_airplane_mode() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Mengaktifkan mode pesawat..."
    adb shell cmd connectivity airplane-mode enable
}
# function DISABLE MODE PESAWAT
disable_airplane_mode() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Menonaktifkan mode pesawat..."
    adb shell cmd connectivity airplane-mode disable
}
# function RESTART INTERFACE
restart_interface() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Restarting Interface ${INTERFACE_NAME}..."
    ifup $INTERFACE_NAME
}
# function DISABLE ENABLE OC
disable_oc() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Disable Openclash..."
    /etc/init.d/openclash stop
}
enable_oc() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Enable Openclash..."
    /etc/init.d/openclash start
}
# function DISABLE ENABLE PASSWALL
disable_passwall() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Disable Passwall..."
    /etc/init.d/passwall stop
}
enable_passwall() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Enable Enable..."
    /etc/init.d/passwall start
}
# function DISABLE ENABLE NEKOCLASH
disable_neko() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Disable NekoClash..."
    /etc/init.d/neko stop
}
enable_neko() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Enable NekoClash..."
    /etc/init.d/neko start
}
# function DISABLE ENABLE v2rayA
disable_v2rayA() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Disable v2rayA..."
    start-stop-daemon -K -p /var/run/v2raya.pid
}
enable_v2rayA() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Enable v2rayA..."
    start-stop-daemon -b -S -m -p /var/run/v2raya.pid -x /usr/bin/enable_v2rayA
}

# Loop untuk melakukan ping dan mengaktifkan/menonaktifkan mode pesawat
while true; do
    if ping -c 1 $HOST &> /dev/null; then
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Host dapat dijangkau. Melanjutkan ping..."
        failed_count=0  # Reset hitungan kegagalan jika host berhasil dijangkau
    else
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Host tidak dapat dijangkau."
        failed_count=$((failed_count + 1))  # Tingkatkan hitungan kegagalan
        if [ $failed_count -ge 5 ]; then
            echo "$(date +"%Y-%m-%d %H:%M:%S") - Gagal ping sebanyak 5 kali."
            if [ $RESTART_TUNNEL == "yes" ]; then
                echo "$(date +"%Y-%m-%d %H:%M:%S") - Disable Tunneling."
                if [ $TOOL_TUNNELING == "OpenClash" ]; then
                  disable_oc
                elif [ $TOOL_TUNNELING == "openclash" ]; then
                  disable_oc
                elif [ $TOOL_TUNNELING == "neko" ]; then
                  disable_neko
                elif [ $TOOL_TUNNELING == "nekoclash" ]; then
                  disable_neko
                elif [ $TOOL_TUNNELING == "Neko" ]; then
                  disable_neko
                elif [ $TOOL_TUNNELING == "NekoClash" ]; then
                  disable_neko
                elif [ $TOOL_TUNNELING == "v2raya" ]; then
                  disable_v2rayA
                elif [ $TOOL_TUNNELING == "V2rayA" ]; then
                  disable_v2rayA
                elif [ $TOOL_TUNNELING == "V2RAYA" ]; then
                  disable_v2rayA
                elif [ $TOOL_TUNNELING == "Passwall" ]; then
                  disable_passwall
                elif [ $TOOL_TUNNELING == "passwall" ]; then
                  disable_passwall
                else
                  echo "$(date +"%Y-%m-%d %H:%M:%S") - Tunnel Not Found, Check Your Variable TOOLS_TUNNELING."
                fi
            elif [ $RESTART_TUNNEL == "no" ]; then
              echo "$(date +"%Y-%m-%d %H:%M:%S") - Melewati Proses Restart Tunneling."
            else
              echo "$(date +"%Y-%m-%d %H:%M:%S") - Variable Not Found, Check Your Variable restart_tunnel."
            fi
            enable_airplane_mode  # Jika sudah ada 5 kegagalan berturut-turut, aktifkan mode pesawat
            sleep $WAIT_TIME  # Tunggu beberapa waktu sebelum menonaktifkan mode pesawat
            disable_airplane_mode  # Nonaktifkan mode pesawat kembali
            sleep $WAIT_TIME #Tunggu 2 detik sebelum merestart interface
            restart_interface  # Merestart interface sesuai INTERFACE_NAME
            if [ $RESTART_TUNNEL == "yes" ]; then
                echo "$(date +"%Y-%m-%d %H:%M:%S") - Restarting Tunneling."
                if [ $TOOL_TUNNELING == "OpenClash" ]; then
                  enable_oc
                elif [ $TOOL_TUNNELING == "openclash" ]; then
                  enable_oc
                elif [ $TOOL_TUNNELING == "Passwall" ]; then
                  enable_passwall
                elif [ $TOOL_TUNNELING == "passwall" ]; then
                  enable_passwall
                elif [ $TOOL_TUNNELING == "Neko" ]; then
                  enable_neko
                elif [ $TOOL_TUNNELING == "neko" ]; then
                  enable_neko
                elif [ $TOOL_TUNNELING == "v2raya" ]; then
                  enable_v2rayA
                elif [ $TOOL_TUNNELING == "V2rayA" ]; then
                  enable_v2rayA
                elif [ $TOOL_TUNNELING == "V2RAYA" ]; then
                  enable_v2rayA
                elif [ $TOOL_TUNNELING == "Passwall" ]; then
                  enable_passwall
                elif [ $TOOL_TUNNELING == "passwall" ]; then
                  enable_passwall
                else
                  echo "$(date +"%Y-%m-%d %H:%M:%S") - Tunnel Not Found, Check Your Variable TOOLS_TUNNELING."
                fi
            elif [ $RESTART_TUNNEL == "no" ]; then
              echo "$(date +"%Y-%m-%d %H:%M:%S") - Melewati Proses Restart Tunneling."
            else
              echo "$(date +"%Y-%m-%d %H:%M:%S") - Variable Not Found, Check Your Variable restart_tunnel."
            fi
            failed_count=0  # Reset hitungan kegagalan setelah mengaktifkan mode pesawat
        fi
    fi
    sleep 5  # Tunggu sebelum memeriksa koneksi lagi
done
