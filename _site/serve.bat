@echo off
echo Iniciando servidor local Jekyll...
echo.
call bundle install
echo.
echo Servidor rodando. Acesse: http://localhost:4000
echo Pressione Ctrl + C para parar.
call bundle exec jekyll serve --livereload
