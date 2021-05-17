create or replace package body hash_tools
as

    function get_ora_hash(
        pv_input in varchar2
        , pv_hash_algorithm in varchar2 default dbms_crypto.HASH_SH256
        , pv_salt in varchar2
    )
    return varchar2
    is
    begin
        return null;
    end;

    function get_pbkdf2_hash (
        pv_password in varchar2
        , pv_salt in varchar2
        , pn_iterations in number
        , pn_hash_function in number default dbms_crypto.hmac_sh256
        , pn_key_length in number 
        , pn_block_size in number
    ) return varchar2
    is
        l_block_count number;
        l_last raw(32767);
        l_xorsum raw(32767);
        l_result raw(32767);
    begin
       
        l_block_count := ceil(pn_key_length / pn_block_size);  
     
        for i in 1..l_block_count loop
        
            l_last := utl_raw.concat(utl_raw.cast_to_raw(pv_salt), utl_raw.cast_from_binary_integer(i, utl_raw.big_endian));
            l_xorsum := null;
    
            for j in 1..pn_iterations loop
                
                l_last := dbms_crypto.mac(
                    src => l_last
                    , typ => pn_hash_function
                    , key => utl_raw.cast_to_raw(pv_password)
                );
    
                if l_xorsum is null then
                    l_xorsum := l_last;
                else
                    l_xorsum := utl_raw.bit_xor(l_xorsum, l_last);
                end if;
                
            end loop;
    
            l_result := utl_raw.concat(l_result, l_xorsum);
            
        end loop;
    
        return rawtohex(utl_raw.substr(l_result, 1, pn_key_length));     
     
    end;

    function get_argon2_hash(
        pv_password in varchar2
        , pv_salt in varchar2
        , pn_Ops_Limit number 
        , pn_Mem_Limit number 
        , pn_Output_Length number
        , pn_Parallelism number 
    ) return varchar2 AS
    language java name 'hash/Argon2Generator.generateArgon2id (java.lang.String, java.lang.String, int, int, int, int) return java.lang.String';

end;
