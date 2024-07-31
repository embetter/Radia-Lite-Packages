docker pull postgres:15.2
docker run --name postgres -e POSTGRES_PASSWORD=your_password -p 5432:5432 -d postgres
