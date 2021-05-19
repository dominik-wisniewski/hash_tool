import org.bouncycastle.crypto.generators.Argon2BytesGenerator;
import org.bouncycastle.crypto.params.Argon2Parameters;
import java.util.Base64;
import java.nio.charset.StandardCharsets;

public class Argon2Generator {
	
    public static String generateArgon2id (String password, String salt, int opsLimit, int memLimit, int outputLength, int parallelism) {
        
        byte[] salt_arr = salt.getBytes();
        
        Argon2Parameters.Builder builder = new Argon2Parameters.Builder(Argon2Parameters.ARGON2_id)
                .withVersion(Argon2Parameters.ARGON2_VERSION_13) // 19
                .withIterations(opsLimit)
                .withMemoryAsKB(memLimit)
                .withParallelism(parallelism)
                .withSalt(salt_arr);
        Argon2BytesGenerator gen = new Argon2BytesGenerator();
        gen.init(builder.build());
        byte[] result = new byte[outputLength];
        gen.generateBytes(password.getBytes(StandardCharsets.UTF_8), result, 0, result.length);
             
        return Base64.getEncoder().encodeToString(result);

    }

}
