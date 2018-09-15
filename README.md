git clone https://gitlab.com/vovanmozg/bbt
cd bbt
docker-compose build
docker-compose up -d && docker-compose logs -f
