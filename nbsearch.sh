#!/bin/bash
NET_TOKEN=" "
DEVICE="$1"

# Add a line to display power port
# Create another script to display the rack devices and rack non racked devices (Site.Racks,Rack cab)
# Visit netbox.com/api/ for schemas
# After the schema, you can filter by using ? (EX: ?name=, ?site=). You can view filters in the GUI

# Get device info from NetBox
DEVICE_INFO=$(curl -s -H "Authorization: Token $NET_TOKEN" \
  -H "Accept: application/json" \
  "https://link-to-netbox/api/dcim/devices/?name=$DEVICE" \
  | jq '.results[0]')

DEVICE_ID=$(echo "$DEVICE_INFO" | jq -r '.id')
PARENT_ID=$(echo "$DEVICE_INFO" | jq -r '.parent_device.id // empty')

# Query IP addresses and find one associated with an IPMI/OOB interface
IPMI_ADDR=$(curl -s -H "Authorization: Token $NET_TOKEN" \
  -H "Accept: application/json" \
  "https://link-to-netbox/api/ipam/ip-addresses/?device_id=$DEVICE_ID&limit=100" \
  | jq -r '
      .results[]
      | select(
          (.assigned_object.name | test("(?i)ipmi|oob")) or
          (.assigned_object.description // "" | test("(?i)ipmi|oob"))
        )
      | .address' | head -n1 | cut -d'/' -f1)

# Check if the device has a parent and structure the output accordingly
if [ -n "$PARENT_ID" ]; then
  PARENT_INFO=$(curl -s -H "Authorization: Token $NET_TOKEN" \
    -H "Accept: application/json" \
    "https://Link-to-netbox/api/dcim/devices/$PARENT_ID/" \
    | jq '.')

  jq -n --argjson device "$DEVICE_INFO" \
        --argjson parent "$PARENT_INFO" \
        --arg ipmi "$IPMI_ADDR" '
  {
    device_name: $device.name,
    site: $device.site.name,
    rack: ($parent.rack.name // "N/A"),
    position: ($parent.position // "N/A"),
    ipmi_address: $ipmi,
    parent_device: $device.parent_device.name,
    parent_bay: ($device.parent_device.device_bay.name // "N/A")
  }'
else
  jq -n --argjson device "$DEVICE_INFO" \
        --arg ipmi "$IPMI_ADDR" '
  {
    device_name: $device.name,
    site: $device.site.name,
    rack: ($device.rack.name // "N/A"),
    position: ($device.position // "N/A"),
    ipmi_address: $ipmi
  }'
fi
