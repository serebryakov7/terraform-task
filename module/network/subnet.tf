resource "aws_subnet" "gateway" {
  count             = length(var.aws_avaliability_zones)
  availability_zone = var.aws_avaliability_zones[count.index]
  cidr_block        = "10.0.1${count.index}.0/24"
  vpc_id            = aws_vpc.default.id
}

resource "aws_subnet" "cluster" {
  count             = length(var.aws_avaliability_zones)
  availability_zone = var.aws_avaliability_zones[count.index]
  cidr_block        = "10.0.2${count.index}.0/24"
  vpc_id            = aws_vpc.default.id
}