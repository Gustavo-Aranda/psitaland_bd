-- Criar o usuário de estudos
CREATE USER psitaland IDENTIFIED BY "123";

-- Dar permissões básicas para ele conectar e criar coisas
GRANT CONNECT, RESOURCE TO psitaland;

-- Permitir que ele use espaço no banco (ilimitado para estudos)
ALTER USER psitaland QUOTA UNLIMITED ON USERS;