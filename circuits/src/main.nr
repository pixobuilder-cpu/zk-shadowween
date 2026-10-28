use std;

fn main(
    secret_code: Field, 
    public_hash: pub Field
) {
    // Une vérification simple pour valider le comportement du circuit
    assert(secret_code == public_hash);
}
