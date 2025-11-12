abstract class Account {
    protected String accountNumber;
    protected double balance;
   
    public Account(String accountNumber, double balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }
   
    public abstract void calculateInterest();
   
    public void display() {
        System.out.println("Account: " + accountNumber + " | Balance: $" + balance);
    }
}

class SavingsAccount extends Account {
    public SavingsAccount(String accountNumber, double balance) {
        super(accountNumber, balance);
    }
   
    @Override
    public void calculateInterest() {
        double interest = balance * 0.04;
        System.out.println("Savings Interest (4%): $" + interest);
    }
}

class CurrentAccount extends Account {
    public CurrentAccount(String accountNumber, double balance) {
        super(accountNumber, balance);
    }
   
    @Override
    public void calculateInterest() {
        System.out.println("Current Account: No interest");
    }
}

class Lab4Demo {
    public static void main(String[] args) {
        System.out.println("=== LAB 4: Banking Polymorphism ===\n");
        Account[] accounts = {
            new SavingsAccount("SA001", 10000),
            new CurrentAccount("CA001", 5000)
        };
       
        for (Account acc : accounts) {
            acc.display();
            acc.calculateInterest();
            System.out.println();
        }
    }
}