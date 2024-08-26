resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags   = var.tags

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.gateway_id
      nat_gateway_id = route.value.nat_gateway_id
      egress_only_gateway_id = route.value.egress_only_gateway_id
      transit_gateway_id = route.value.transit_gateway_id
      vpc_peering_connection_id = route.value.vpc_peering_connection_id
      network_interface_id = route.value.network_interface_id
      destination_prefix_list_id = route.value.destination_prefix_list_id
      carrier_gateway_id = route.value.carrier_gateway_id
    }
  }
}

resource "aws_route_table_association" "this" {
  count = length(var.subnet_ids)

  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.this.id
}
