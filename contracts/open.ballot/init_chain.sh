cleos wallet unlock -n debug --password PW5JGqrHwsAphXLGcZ4rHAJqQxmGQXdL42puB5Vjo14odGspwYFvo

# setup params
EOS_BUILD_PATH=$HOME/eos/build
EOS_KEY=EOS8k4wDWyrq9yPUL17YKqThf5F5VVMs5c8diRZQfGKG9698dd6na

# initial chain contracts
echo "\nBooting Chain Contracts"
cleos set contract eosio ${EOS_BUILD_PATH}/contracts/eosio.bios -p eosio
cleos create account eosio eosio.token ${EOS_KEY} ${EOS_KEY}

# sim.bot account
echo "\nCreating sim.bot account"
cleos create account eosio sim.bot ${EOS_KEY} ${EOS_KEY}
cleos set contract sim.bot ../eosio.nft -p sim.bot
cleos push action sim.bot create '[ "sim.bot", "BALLOT"]' -p sim.bot

# create voters
for ((i=1;i<=4000;i++)); 
do
    UUID="$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z' | fold -w 6 | head -n 1)"
    printf -v NUM "1%04d" $i
    VOTER="voter.${UUID}"
    echo "voter: ${VOTER} id: ${NUM}"
    cleos create account eosio ${VOTER} ${EOS_KEY} ${EOS_KEY}
    cleos push action sim.bot issue "[\"${VOTER}\", \"1 BALLOT\", [\"/${NUM}\"], \"BALLOT-${NUM}\", \"\"]" -p sim.bot
done

