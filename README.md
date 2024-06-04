This is a new [**React Native**](https://reactnative.dev) project, bootstrapped using [`@react-native-community/cli`](https://github.com/react-native-community/cli).

# Getting Started

>**Note**: Make sure you have completed the [React Native - Environment Setup](https://reactnative.dev/docs/environment-setup) instructions till "Creating a new application" step, before proceeding.

## Step 1: Start the Metro Server

First, you will need to start **Metro**, the JavaScript _bundler_ that ships _with_ React Native.

To start Metro, run the following command from the _root_ of your React Native project:

```bash
# using npm
npm start

# OR using Yarn
yarn start
```

## Step 2: Start your Application

Let Metro Bundler run in its _own_ terminal. Open a _new_ terminal from the _root_ of your React Native project. Run the following command to start your _Android_ or _iOS_ app:

### For Android

```bash
# using npm
npm run android

# OR using Yarn
yarn android
```

### For iOS

```bash
# using npm
npm run ios

# OR using Yarn
yarn ios
```

If everything is set up _correctly_, you should see your new app running in your _Android Emulator_ or _iOS Simulator_ shortly provided you have set up your emulator/simulator correctly.

This is one way to run your app — you can also run it directly from within Android Studio and Xcode respectively.

## Step 3: Modifying your App

Now that you have successfully run the app, let's modify it.

1. Open `App.tsx` in your text editor of choice and edit some lines.
2. For **Android**: Press the <kbd>R</kbd> key twice or select **"Reload"** from the **Developer Menu** (<kbd>Ctrl</kbd> + <kbd>M</kbd> (on Window and Linux) or <kbd>Cmd ⌘</kbd> + <kbd>M</kbd> (on macOS)) to see your changes!

   For **iOS**: Hit <kbd>Cmd ⌘</kbd> + <kbd>R</kbd> in your iOS Simulator to reload the app and see your changes!

## Congratulations! :tada:

You've successfully run and modified your React Native App. :partying_face:

### Now what?

- If you want to add this new React Native code to an existing application, check out the [Integration guide](https://reactnative.dev/docs/integration-with-existing-apps).
- If you're curious to learn more about React Native, check out the [Introduction to React Native](https://reactnative.dev/docs/getting-started).

# Troubleshooting

If you can't get this to work, see the [Troubleshooting](https://reactnative.dev/docs/troubleshooting) page.

# Learn More

To learn more about React Native, take a look at the following resources:

- [React Native Website](https://reactnative.dev) - learn more about React Native.
- [Getting Started](https://reactnative.dev/docs/environment-setup) - an **overview** of React Native and how setup your environment.
- [Learn the Basics](https://reactnative.dev/docs/getting-started) - a **guided tour** of the React Native **basics**.
- [Blog](https://reactnative.dev/blog) - read the latest official React Native **Blog** posts.
- [`@facebook/react-native`](https://github.com/facebook/react-native) - the Open Source; GitHub **repository** for React Native.
# Schéma de Base de Données pour la Gestion d'un Compte Bancaire

## Tables et Colonnes

### Table `Clients`
- `client_id` (INT, PRIMARY KEY, AUTO_INCREMENT) : Identifiant unique pour chaque client.
- `nom` (VARCHAR(255)) : Nom du client.
- `prenom` (VARCHAR(255)) : Prénom du client.
- `adresse` (VARCHAR(255)) : Adresse du client.
- `email` (VARCHAR(255), UNIQUE) : Email du client.
- `telephone` (VARCHAR(20), UNIQUE) : Numéro de téléphone du client.

### Table `Comptes`
- `compte_id` (INT, PRIMARY KEY, AUTO_INCREMENT) : Identifiant unique pour chaque compte.
- `client_id` (INT, FOREIGN KEY REFERENCES Clients(client_id)) : Identifiant du client propriétaire du compte.
- `num_compte` (VARCHAR(20), UNIQUE) : Numéro de compte bancaire.
- `type_compte` (ENUM('courant', 'epargne')) : Type de compte (courant ou épargne).
- `solde` (DECIMAL(15, 2)) : Solde du compte.
- `date_ouverture` (DATE) : Date d'ouverture du compte.

### Table `Transactions`
- `transaction_id` (INT, PRIMARY KEY, AUTO_INCREMENT) : Identifiant unique pour chaque transaction.
- `compte_id` (INT, FOREIGN KEY REFERENCES Comptes(compte_id)) : Identifiant du compte associé à la transaction.
- `date_transaction` (DATETIME) : Date et heure de la transaction.
- `type_transaction` (ENUM('depot', 'retrait', 'virement')) : Type de transaction (dépôt, retrait, virement).
- `montant` (DECIMAL(15, 2)) : Montant de la transaction.
- `description` (VARCHAR(255)) : Description de la transaction.

## Contraintes

### Contraintes de Clé Primaire (Primary Key)
- Chaque table a une clé primaire unique (`client_id`, `compte_id`, `transaction_id`).

### Contraintes de Clé Étrangère (Foreign Key)
- `client_id` dans la table `Comptes` doit exister dans la table `Clients`.
- `compte_id` dans la table `Transactions` doit exister dans la table `Comptes`.

### Contraintes d'Unicité (Unique)
- `email` et `telephone` dans la table `Clients` doivent être uniques.
- `num_compte` dans la table `Comptes` doit être unique.

### Contraintes de Vérification (Check)
- `type_compte` dans la table `Comptes` doit être soit 'courant' soit 'epargne'.
- `type_transaction` dans la table `Transactions` doit être soit 'depot', 'retrait', soit 'virement'.

### Contraintes de Non Nullité (NOT NULL)
- Les colonnes `nom`, `prenom`, `email`, et `telephone` dans la table `Clients` ne doivent pas être nulles.
- Les colonnes `client_id`, `num_compte`, `type_compte`, `solde`, et `date_ouverture` dans la table `Comptes` ne doivent pas être nulles.
- Les colonnes `compte_id`, `date_transaction`, `type_transaction`, et `montant` dans la table `Transactions` ne doivent pas être nulles.

## Exemple de Création des Tables en SQL

```sql
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
