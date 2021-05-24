# hash_tool
PL/SQL wrapper for hash functions


Dependencies:
- Bouncy Castle Provider (https://www.bouncycastle.org/latest_releases.html)

Installation:

1. User / schema used for installation should have set of permissions granted:

execute dbms_java.grant_permission(:user, 'java.util.PropertyPermission','*', 'read,write');

execute dbms_java.grant_permission(:user,'java.util.PropertyPermission','*','read');

execute dbms_java.grant_permission( :user, 'SYS:java.lang.RuntimePermission', 'getClassLoader', ' ' );

execute dbms_java.grant_permission( :user, 'SYS:oracle.aurora.security.JServerPermission', 'Verifier', ' ' );

execute dbms_java.grant_permission( :user, 'SYS:java.lang.RuntimePermission', 'accessClassInPackage.sun.util.calendar', ' ' ) ; 

execute dbms_java.grant_permission( :user, 'java.net.SocketPermission', '*', 'connect,resolve' );

execute dbms_java.grant_permission( :user, 'SYS:java.lang.RuntimePermission', 'createClassLoader', ' ');

grant execute on dbms_crypto to :user;

Since loadjava tool will be used, appropriate default tablespace and its quota should be set as CREATE$JAVA$LOB$TABLE table is created during java loading (for testing purposes we can grant unlimited tablespace)

2. Loadjava

{bouncy_castle_prov} = jar file of latest relase of Bouncy Castle provider (https://www.bouncycastle.org/latest_releases.html) 

loadjava -user {user}/{password}@{connection_string} -resolve {bouncy_castle_prov} <br>
loadjava -user {user}/{password}@{connection_string} -resolve hashGenerator.jar


3. Package installation

TODO
