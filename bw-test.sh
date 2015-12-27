target=${1:-nuc.local}
dir=$target/$(date -Idate)/$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
mkdir -p $dir || true
iperf3 -J -c $target > $dir/$(date +%s).json
