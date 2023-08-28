package repository;

import model.customer;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class customerRepo {
    private static List<customer> list = new ArrayList<>(Arrays.asList(new customer[]{
            new customer("Mai Văn Hoàn", LocalDate.parse("1983-08-20"), "Hà Nội", "https://antimatter.vn/wp-content/uploads/2022/11/hinh-anh-gai-xinh-trung-quoc.jpg"),
            new customer("Nguyễn Văn Nam", LocalDate.parse("1983-08-21"), "Bắc Giang", "https://haycafe.vn/wp-content/uploads/2022/03/Anh-gai-Trung-Quoc.jpg"),
            new customer("Nguyễn Thái Hòa", LocalDate.parse("1983-08-22"), "Nam Định", "https://cdn-img.thethao247.vn/upload/cuongnm/2020/04/28/cau-cau.jpg"),
            new customer("Mai Văn Hoàn", LocalDate.parse("1983-08-21"), "Hà Nội", "https://technewsvn.com/wp-content/uploads/2023/04/image7-3.jpg"),
            new customer("Mai Văn Hoàn", LocalDate.parse("1983-08-21"), "Hà Nội", "https://antimatter.vn/wp-content/uploads/2022/04/tong-hop-anh-gai-xinh-trung-quoc-7.jpg")
    }));
    public static List<customer> display(){
        return list;

    }
}
