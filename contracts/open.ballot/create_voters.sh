EOS_KEY=EOS8k4wDWyrq9yPUL17YKqThf5F5VVMs5c8diRZQfGKG9698dd6na

# create voters
for ((i=1;i<=5;i++)); 
do
    UUID="$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z' | fold -w 6 | head -n 1)"
    printf -v NUM "1%04d" $i
    VOTER="voter.${UUID}"
    echo "voter: ${VOTER} id: ${NUM}"
    cleos create account eosio ${VOTER} ${EOS_KEY} ${EOS_KEY}
    cleos push action sim.bot issue "[\"${VOTER}\", \"1 SHEOS\", [\"/${NUM}\"], \"SHEOS-${NUM}\", \"\"]" -p sim.bot    
done
