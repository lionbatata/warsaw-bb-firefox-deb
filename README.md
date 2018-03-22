Gostaria de agradecer ao [lichti/warsaw-browser](https://hub.docker.com/r/lichti/warsaw-browser/) pois esse repositório é como um "fork" deste, visto que:

1) Customizei o container para acesso exclusivo ao BB (Banco do Brasil);
2) Resolvi o problema no docker-run com a inclusão do parâmetro --shm-size 2g;
3) Resolvi o problema de falta do pacote language-pack-pt no debian stable, configurando o locale pt-BR.UTF8 na mão.

No entanto, é muito fácil mudar o container para acessar outros bancos que usam igualmente a ferramenta warsaw, basta umas simples mudanças no Dockerfile e start.sh.

# Como executar:

1) Criar o alias e a function, como segue, incluindo o código abaixo no seu .bashrc ou no /etc/bash.bashrc

alias bb="warsaw-bb-firefox-deb"

function warsaw-bb-firefox-deb {
     xhost +;
     docker run -it --rm \
          -v /tmp/.X11-unix:/tmp/.X11-unix \
          -v $HOME/Downloads:/home/bank/Downloads \
          -e DISPLAY=unix$DISPLAY \
          --shm-size 2g \
          --name warsaw-bb-firefox-deb \
          lionbatata/warsaw-bb-firefox-deb;
}

2) abrir um console na sua gui de uso e executar:

$ bb

