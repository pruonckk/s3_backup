#!/bin/bash


S3_ACCESS_KEY="CHAVE_DE_ACESSO_S3"
S3_SECRET_KEY="SECRET_KEY_S3"

S3_BUCKET="BUCKET_S3"
DIR_ANTIGO=`pwd`


DIR_ORIGEM=/mnt/STORAGE/SERVIDOR/PASTA_A_SER_SINCRONIZADA/
DIR_DESTINO=/SERVIDOR/PASTA_A_SER_SINCRONIZADA/

if [ ! -d "/var/log/sincronia" ]; then
	mkdir /var/log/sincronia
fi

LOG="/var/log/sincronia/gravacoes_SERVIDOR-`date +%d.%m.%Y`.log"



for OFFSET in $(seq 1 4); do 
	
	DIR_ORIGEM=/mnt/STORAGE/SERVIDOR/PASTA_A_SER_SINCRONIZADA/
	DIR_DESTINO=/SERVIDOR/PASTA_A_SER_SINCRONIZADA/

	ANO=$(date -j -v-${OFFSET}d +"%Y")
	MES=$(date -j -v-${OFFSET}d +"%m")
	DIA=$(date -j -v-${OFFSET}d +"%d")


	DIR_ORIGEM=${DIR_ORIGEM}/${ANO}/${MES}/${DIA}
	DIR_DESTINO=${DIR_DESTINO}/${ANO}/${MES}/${DIA}

	echo "${DIR_ORIGEM} - ${DIR_DESTINO}"

 	cd $DIR_ORIGEM
        echo "/usr/local/bin/s3cmd -v --no-encrypt -c /root/.s3cfg-gravacoes  sync .  s3://${S3_BUCKET}${DIR_DESTINO}${NAME}/ 1>$LOG 2>$LOG"
        /usr/local/bin/s3cmd -v --no-encrypt -c /root/.s3cfg-gravacoes  sync .  s3://${S3_BUCKET}${DIR_DESTINO}${NAME}/ 1>$LOG 2>$LOG
	cd $DIR_ANTIGO

done


