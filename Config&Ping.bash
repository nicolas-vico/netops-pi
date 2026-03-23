echo "Configuring Routers and trying ping"

# 1. R1 Config
echo "--- Configuring R1 ---"
docker exec clab-netops-basic-r1 ip link set eth1 up
docker exec clab-netops-basic-r1 ip addr add 10.0.0.1/30 dev eth1
docker exec clab-netops-basic-r1 ip addr add 1.1.1.1/32 dev lo
# Static route to R2's Loopback Interface
docker exec clab-netops-basic-r1 ip route add 2.2.2.2/32 via 10.0.0.2

# 2. R2 Config
echo "--- Configuring R2 ---"
docker exec clab-netops-basic-r2 ip link set eth1 up
docker exec clab-netops-basic-r2 ip addr add 10.0.0.2/30 dev eth1
docker exec clab-netops-basic-r2 ip addr add 2.2.2.2/32 dev lo
# Static route to R1's Loopback Interface
docker exec clab-netops-basic-r2 ip route add 1.1.1.1/32 via 10.0.0.1

echo "Configuration successful, trying ping..."
docker exec clab-netops-basic-r1 ping -c 2 2.2.2.2