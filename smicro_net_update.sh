IPMI_USER=" "
IPMI_PASS=" "
TOOL="$1"
IPADDR="$2"
FILE="$3"

case $TOOL in

bios)
$HOME/sum -i "$IPADDR" -u "$IPMI_USER" -p "$IPMI_PASS" -c UpdateBIOS --file "$FILE" ;;

ipmi)
$HOME/sum -i "$IPADDR" -u "$IPMI_USER" -p "$IPMI_PASS" -c UpdateBMC --file "$FILE" ;;

*)
echo "./smicro_net_update.sh bios|ipmi <IP> file" ;;
esac
