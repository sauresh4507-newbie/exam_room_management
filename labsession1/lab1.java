class Book
{
    public String title;
    public String author;
    public double price;

    public Book(String title, String author, double price)
    {
        this.title = title;
        this.author = author;
        this.price = price;
    }

    public void display()
    {
        System.out.println("Book title is " + title);
        System.out.println("Written by " + author);
        System.out.println("Price is ₹" + price);
    }
}

public class lab1
{
    public static void main(String args[])
    {
        Book b1 = new Book("One piece", "Samuel L Jackson",  1090);
        b1.display();
    }
}
