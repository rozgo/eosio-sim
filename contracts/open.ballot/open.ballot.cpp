#include <eosiolib/eosio.hpp>

using namespace eosio;

class openballot : public eosio::contract
{
public:
  using contract::contract;

  /// @abi table
  struct Election
  {
    uint64_t id;
    checksum256 document; // ipfs hash of document describing election

    uint64_t primary_key() const { return id; }

    EOSLIB_SERIALIZE(Election, (id)(document))
  };

  /// @abi table
  struct Candidate
  {
    uint64_t id;
    checksum256 document; // ipfs hash of document describing candidate

    uint64_t primary_key() const { return id; }

    EOSLIB_SERIALIZE(Candidate, (id)(document))
  };

  /// @abi table
  struct Ballot
  {
    uint64_t id;
    uint64_t election_id;
    std::vector<uint64_t> candidates;

    uint64_t primary_key() const { return id; }

    EOSLIB_SERIALIZE(Ballot, (id)(election_id)(candidates))
  };

  /// @abi table
  struct Vote
  {
    uint64_t id;
    account_name voter;
    uint64_t ballot_id;
    uint64_t candidate_id;

    uint64_t primary_key() const { return id; }

    EOSLIB_SERIALIZE(Vote, (id)(voter)(ballot_id)(candidate_id))
  };

  /// @abi action
  void neweleccion(account_name user)
  {
  }
};

EOSIO_ABI(openballot, (neweleccion))
