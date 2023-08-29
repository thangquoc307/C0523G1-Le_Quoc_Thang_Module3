package service;

import model.customer;
import repository.customerRepo;

import java.util.List;

public class customerService {
    public static List<customer> displayCustomer(){
        return customerRepo.display();
    }
}
