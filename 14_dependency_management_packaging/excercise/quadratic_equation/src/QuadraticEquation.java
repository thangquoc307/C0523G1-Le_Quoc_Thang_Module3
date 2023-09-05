import java.util.ArrayList;
import java.util.List;

public class QuadraticEquation {
    private QuadraticEquation() {}
    public static void quadraticEquation(double a, double b, double c){
        List<Double> result = new ArrayList<>();
//        a * x^2 + b * x + c = 0
        if (a == 0){
            if (b == 0){
                if (c == 0){
                    System.out.println("Phương trình vô số nghiệm");
                    return;
                } else {
                    System.out.println("Phương trình vô nghiệm");
                    return;
                }
            } else {
                System.out.println("Phương trình có nghiệm " + (-c / b));
            }
        } else {
            double delta = Math.pow(b, 2) - (4 * a * c);
            if (delta < 0){
                System.out.println("Phương trình vô nghiệm");
                return;
            } else if (delta == 0) {
                System.out.println("Phơng trình có nghiệm kép : x1 = x2 = " + (-b / 2 * a));
                return;
            } else {
                double x1 = (-b + Math.sqrt(delta)) / (2 * a);
                double x2 = (-b - Math.sqrt(delta)) / (2 * a);
                System.out.println("Phương trình có 2 nghiệm : x1 = " + x1 + " và x2 = " + x2);
                return;
            }
        }
    }
}
