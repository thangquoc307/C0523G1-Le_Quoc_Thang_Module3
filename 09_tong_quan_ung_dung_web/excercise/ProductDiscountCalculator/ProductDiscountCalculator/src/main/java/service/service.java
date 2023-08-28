package service;

public class service {
    public static double[] calculator(double price, double percentage){
        double discountAmount = price * percentage / 100;
        double discountPrice = price - discountAmount;
        return new double[]{discountAmount, discountPrice};
    }
}
