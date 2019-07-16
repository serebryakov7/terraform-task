resource "aws_route_table" "cluster" {
    count = "${ length(var.aws_avaliability_zones) }"
  vpc_id = "${ aws_vpc.default.id }"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${ aws_nat_gateway.internet_nat_gateway.*.id[count.index] }"
  }
}

resource "aws_route_table" "gateway" {
  vpc_id = "${ aws_vpc.default.id }"
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.internet_gateway.id }"
  }
}

resource "aws_route_table_association" "cluster" {
    count = "${ length(var.aws_avaliability_zones) }"

    subnet_id      = "${ aws_subnet.cluster.*.id[count.index] }"
    route_table_id = "${ aws_route_table.cluster.*.id[count.index] }"
}

resource "aws_route_table_association" "gateway" {
    count = "${ length(var.aws_avaliability_zones) }"
    
    subnet_id      = "${ aws_subnet.gateway.*.id[count.index] }"
    route_table_id = "${ aws_route_table.gateway.id }"
}