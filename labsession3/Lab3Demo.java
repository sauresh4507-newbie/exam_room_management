class Vehicle {
    protected String brand;
    protected String model;
   
    public Vehicle(String brand, String model) {
        this.brand = brand;
        this.model = model;
    }
   
    public String startEngine() {
        return brand + " " + model + " engine starting...";
    }
}

class Car extends Vehicle {
    protected int doors;
   
    public Car(String brand, String model, int doors) {
        super(brand, model);
        this.doors = doors;
    }
   
    @Override
    public String startEngine() {
        return super.startEngine() + " Vroom!";
    }
}

class ElectricCar extends Car {
    private double battery;
   
    public ElectricCar(String brand, String model, int doors, double battery) {
        super(brand, model, doors);
        this.battery = battery;
    }
   
    @Override
    public String startEngine() {
        return brand + " " + model + " starting... Silent electric!";
    }
}

class Lab3Demo {
    public static void main(String[] args) {
        System.out.println("=== LAB 3: Vehicle Hierarchy ===\n");
        Vehicle v = new Vehicle("Generic", "V1");
        Car c = new Car("Toyota", "Camry", 4);
        ElectricCar e = new ElectricCar("Tesla", "Model 3", 4, 75);
       
        System.out.println(v.startEngine());
        System.out.println(c.startEngine());
        System.out.println(e.startEngine());
    }
}
