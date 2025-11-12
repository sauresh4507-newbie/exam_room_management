class Printer {
    public synchronized void printDocument(String user, int pages) {
        System.out.println(user + " started printing " + pages + " pages...");
        for (int i = 1; i <= pages; i++) {
            System.out.println(">> " + user + " is printing page " + i);
            try {
                Thread.sleep(500); 
            } catch (InterruptedException e) {
                System.out.println("Printing interrupted for " + user);
            }
        }
        System.out.println(user + " finished printing.\n");
    }
}

class User implements Runnable {
    private String userName;
    private Printer printer;
    private int pages;

    public User(String userName, Printer printer, int pages) {
        this.userName = userName;
        this.printer = printer;
        this.pages = pages;
    }

    @Override
    public void run() {
        printer.printDocument(userName, pages);
    }
}

public class Lab7 {
    public static void main(String[] args) {
        Printer sharedPrinter = new Printer();

        Thread user1 = new Thread(new User("Alice", sharedPrinter, 3));
        Thread user2 = new Thread(new User("Bob", sharedPrinter, 4));
        Thread user3 = new Thread(new User("Charlie", sharedPrinter, 2));

        user1.start();
        user2.start();
        user3.start();
    }
}