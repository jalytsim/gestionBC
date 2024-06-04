CREATE TABLE Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    telephone VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Comptes (
    compte_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    num_compte VARCHAR(20) UNIQUE NOT NULL,
    type_compte ENUM('courant', 'epargne') NOT NULL,
    solde DECIMAL(15, 2) NOT NULL,
    date_ouverture DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    compte_id INT NOT NULL,
    date_transaction DATETIME NOT NULL,
    type_transaction ENUM('depot', 'retrait', 'virement') NOT NULL,
    montant DECIMAL(15, 2) NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (compte_id) REFERENCES Comptes(compte_id)
);
