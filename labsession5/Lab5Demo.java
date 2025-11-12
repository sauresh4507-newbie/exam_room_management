interface Loan {
    void calculateEMI();
    void displayLoanDetails();
}

class HomeLoan implements Loan {
    private double principal;
    private double rate;
    private int years;
   
    public HomeLoan(double principal, double rate, int years) {
        this.principal = principal;
        this.rate = rate;
        this.years = years;
    }
   
    @Override
    public void calculateEMI() {
        double monthlyRate = rate / 12 / 100;
        int months = years * 12;
        double emi = (principal * monthlyRate * Math.pow(1 + monthlyRate, months)) /
                     (Math.pow(1 + monthlyRate, months) - 1);
        System.out.println("Home Loan EMI: $" + String.format("%.2f", emi));
    }
   
    @Override
    public void displayLoanDetails() {
        System.out.println("Principal: $" + principal + " | Rate: " + rate +
                         "% | Years: " + years);
    }
}

class CarLoan implements Loan {
    private double principal;
    private double rate;
    private int years;
   
    public CarLoan(double principal, double rate, int years) {
        this.principal = principal;
        this.rate = rate;
        this.years = years;
    }
   
    @Override
    public void calculateEMI() {
        double monthlyRate = rate / 12 / 100;
        int months = years * 12;
        double emi = (principal * monthlyRate * Math.pow(1 + monthlyRate, months)) /
                     (Math.pow(1 + monthlyRate, months) - 1);
        System.out.println("Car Loan EMI: $" + String.format("%.2f", emi));
    }
   
    @Override
    public void displayLoanDetails() {
        System.out.println("Principal: $" + principal + " | Rate: " + rate +
                         "% | Years: " + years);
    }
}

class Lab5Demo {
    public static void main(String[] args) {
        System.out.println("=== LAB 5: Loan Management System ===\n");
        Loan[] loans = {
            new HomeLoan(500000, 8.5, 20),
            new CarLoan(25000, 7.5, 5)
        };
       
        for (Loan loan : loans) {
            loan.displayLoanDetails();
            loan.calculateEMI();
            System.out.println();
        }
    }
}