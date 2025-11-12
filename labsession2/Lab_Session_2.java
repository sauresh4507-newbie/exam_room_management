import java.util.Scanner;

class Employee {
    String name;
    int id;
    String department;
   
    public Employee(String name, int id, String department) {
        this.name = name;
        this.id = id;
        this.department = department;
    }
   
    public void display() {
        System.out.println("ID: " + id + " | Name: " + name + " | Dept: " + department);
    }
}

class Lab2Demo {
    public static void main(String[] args) {
        System.out.println("=== LAB 2: HR Onboarding System ===\n");
       
        // Scanner input
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter employee name: ");
        String name = sc.nextLine();
        System.out.print("Enter employee ID: ");
        int id = sc.nextInt();
        sc.nextLine();
        System.out.print("Enter department: ");
        String dept = sc.nextLine();
       
        Employee emp = new Employee(name, id, dept);
        System.out.println("\n--- Employee Details ---");
        emp.display();
       
        // Command-line arguments
        System.out.println("\n--- Batch Update from Command Line ---");
        if (args.length >= 3) {
            Employee emp2 = new Employee(args[0], Integer.parseInt(args[1]), args[2]);
            emp2.display();
        } else {
            System.out.println("Run with: java Lab2Demo <name> <id> <dept>");
        }
       
        sc.close();
    }
}