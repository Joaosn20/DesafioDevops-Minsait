# Usa a imagem oficial do WordPress como base
FROM wordpress:latest

# Copia o conteúdo necessário (se houver) para o contêiner
COPY . /var/www/html

# Exponha a porta 80 para acesso web
EXPOSE 80
