class LowBalanceException extends Exception {
    public LowBalanceException(String message) {
        super(message);
    }
}

class BankAccount {
    private String accountNumber;
    private double balance;
   
    public BankAccount(String accountNumber, double balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }
   
    public void withdraw(double amount) throws LowBalanceException {
        System.out.println("Withdrawing $" + amount + " from " + accountNumber);
       
        if (amount > balance) {
            throw new LowBalanceException("Insufficient balance! Available: $" + balance);
        }
       
        balance -= amount;
        System.out.println("✓ Success! New balance: $" + balance);
    }
   
    public double getBalance() {
        return balance;
    }
}

class Lab6Demo {
    public static void main(String[] args) {
        System.out.println("=== LAB 6: Exception Handling ===\n");
        BankAccount account = new BankAccount("ACC001", 5000);
       
        try {
            account.withdraw(2000);
            account.withdraw(4000);
        } catch (LowBalanceException e) {
            System.out.println("✗ Error: " + e.getMessage());
        } finally {
            System.out.println("Final balance: $" + account.getBalance());
        }
    }
}