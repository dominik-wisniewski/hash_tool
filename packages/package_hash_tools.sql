create or replace package hash_tools
as

    -- for native Oracle hashing functions (supported by dbms_crypto.hash)
    function get_ora_hash(
        pv_input in varchar2
        , pv_hash_algorithm in number default dbms_crypto.HASH_SH256 -- as for dbms_crypto.hash function
        , pv_salt in varchar2
    )
    return varchar2;

    -- PBKDF2 PL/SQL implmenetation
    function get_pbkdf2_hash (
        pv_input in varchar2
        , pv_salt in varchar2
        , pn_iterations in number
        , pn_hash_function in number default dbms_crypto.hmac_sh256 -- as for dbms_crypto.hmac function  
        , pn_key_length in number 
        , pn_block_size in number -- 20 bytes for SHA1, 32 for SHA256, 64 for SHA512 etc.
    ) return varchar2;

    -- Argon2 java implementation
    function get_argon2_hash(
        pv_input in varchar2
        , pv_salt in varchar2
        , pn_ops_limit number 
        , pn_mem_limit number 
        , pn_output_length number
        , pn_parallelism number 
    ) return varchar2;

end;
