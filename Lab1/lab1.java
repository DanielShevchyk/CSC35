import java.util.Scanner;
public class lab1{
    public static void main (String[] args){
        Scanner s = new Scanner(System.in);
        int n1;
        int n2;
        int result;
        
        //First Number
        System.out.print("Enter a 3 digit number: ");
        n1 = s.nextInt();
        
        //Second Number
        System.out.print("Enter the second 3 digit number: ");
        n2 = s.nextInt();
        
        //Resulting Answer
        result = n1 * n2;
        
        //Formatting of multiplication table.
        System.out.printf("%10d\nX%9d\n-----------\n", n1, n2);
        System.out.printf("%10d\n", n1 * (n2 % 10));
        System.out.printf("%9d\n", n1 * (n2 / 10 % 10));
        System.out.printf("+%7d\n-----------\n", n1 * (n2 / 100));
        System.out.printf("%10d\n", result);
    }
}