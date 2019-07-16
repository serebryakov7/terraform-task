resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.default.id
}

resource "aws_eip" "nat_gateway" {
    count = length(var.aws_avaliability_zones)
  vpc      = true
}
 
resource "aws_nat_gateway" "internet_nat_gateway" {
    count = length(var.aws_avaliability_zones)
  allocation_id = aws_eip.nat_gateway.*.id[count.index]
  subnet_id = aws_subnet.gateway.*.id[count.index]
  depends_on = ["aws_internet_gateway.internet_gateway"]
}