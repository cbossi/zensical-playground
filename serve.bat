@echo off
docker compose up --build zensical_serve -d
docker compose watch zensical_serve