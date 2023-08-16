use furama;

-- 2.Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự
-- “H”, “T” hoặc “K” và có tối đa 15 kí tự.
select * from nhan_vien
where (substring_index(nhan_vien.ho_ten, " ", -1) like "H%"
or substring_index(nhan_vien.ho_ten, " ", -1) like "T%"
or substring_index(nhan_vien.ho_ten, " ", -1) like "K%")
and length(nhan_vien.ho_ten) <= 15;

-- 3.Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng”
-- hoặc “Quảng Trị”.
select * from khach_hang
where (year(current_date()) - year(khach_hang.ngay_sinh) >= 18)
    and (year(current_date()) - year(khach_hang.ngay_sinh) <= 50)
    and (khach_hang.dia_chi like "%Đà Nẵng%" 
	or khach_hang.dia_chi like "%Quảng Trị%");

-- 4.Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp
-- tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là
-- “Diamond”.
select khach_hang.ho_ten, loai_khach.ten_loai_khach, count(*) as so_lan_dat_phong
from khach_hang
inner join loai_khach on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
inner join hop_dong on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
where loai_khach.ten_loai_khach like "%Diamond%"
group by khach_hang.ho_ten, loai_khach.ten_loai_khach
order by so_lan_dat_phong;

-- 5.Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong,
-- ngay_ket_thuc, tong_tien (Với tổng tiền được tính theo công thức như sau:
-- Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet)
-- cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải
-- hiển thị ra).
select 
	khach_hang.ma_khach_hang,
	khach_hang.ho_ten, 
	loai_khach.ten_loai_khach, 
	hop_dong.ma_hop_dong,
	dich_vu.ten_dich_vu, 
	hop_dong.ngay_lam_hop_dong, 
	hop_dong.ngay_ket_thuc,
	sum(dich_vu.chi_phi_thue + ifnull(dich_vu_di_kem.gia, 0) * ifnull(hop_dong_chi_tiet.so_luong, 0)) as tong_tien
from khach_hang
	inner join loai_khach on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
	left join hop_dong on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
	left join dich_vu on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
	left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
	left join dich_vu_di_kem on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
group by 
	khach_hang.ma_khach_hang, 
    khach_hang.ho_ten, 
    loai_khach.ten_loai_khach, 
    hop_dong.ma_hop_dong,
	dich_vu.ten_dich_vu, 
    hop_dong.ngay_lam_hop_dong, 
    hop_dong.ngay_ket_thuc
order by khach_hang.ma_khach_hang;

-- 6.Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại
-- dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
create view hop_dong_quy_1_2021 as
select * from `hop_dong`
where (month(`hop_dong`.`ngay_lam_hop_dong`) in (1,2,3) and year(`hop_dong`.`ngay_lam_hop_dong`) = 2021);
select 
	dich_vu.ma_dich_vu as "Mã dịch vụ",
    dich_vu.ten_dich_vu as "Tên dịch vụ",
    dich_vu.dien_tich as "Diện tích",
    dich_vu.chi_phi_thue as "Chi phí thuê",
    loai_dich_vu.ten_loai_dich_vu as "Loại dich vụ"
from dich_vu
	inner join hop_dong on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
	inner join loai_dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
    left join hop_dong_quy_1_2021 on hop_dong_quy_1_2021.ma_dich_vu = dich_vu.ma_dich_vu
group by
    dich_vu.ma_dich_vu;

-- 7.Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue,
-- ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020
-- nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
create view hop_dong_2020 as
select * from `hop_dong`
where year(`hop_dong`.`ngay_lam_hop_dong`) = 2020;
create view hop_dong_2021 as
select * from `hop_dong`
where year(`hop_dong`.`ngay_lam_hop_dong`) = 2021;
select
	dich_vu.ma_dich_vu as "Mã dịch vụ",
    dich_vu.ten_dich_vu as "Tên dịch vụ",
    dich_vu.dien_tich as "Diện tích",
    dich_vu.so_nguoi_toi_da as "Số người tối đa",
    dich_vu.chi_phi_thue as "Chi phí thuê",
    loai_dich_vu.ten_loai_dich_vu as "Loại dich vụ"
from `dich_vu`
	inner join loai_dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
    inner join hop_dong_2020 on dich_vu.ma_dich_vu = hop_dong_2020.ma_dich_vu
    left join hop_dong_2021 on dich_vu.ma_dich_vu = hop_dong_2021.ma_dich_vu
where
	hop_dong_2021.ma_dich_vu is null
group by 
	dich_vu.ma_dich_vu;

-- 8.Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
select ho_ten from khach_hang
group by ho_ten;

select ho_ten from khach_hang
union
select ho_ten from khach_hang;

select distinct ho_ten from khach_hang;

-- 9.Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì
-- sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
select 
	month(ngay_lam_hop_dong) as "Tháng",
    sum(dich_vu.chi_phi_thue + ifnull(dich_vu_di_kem.gia, 0) * ifnull(hop_dong_chi_tiet.so_luong, 0)) as tong_tien
from hop_dong
	inner join dich_vu on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
    left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    left join dich_vu_di_kem on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
group by `Tháng`
order by `Tháng`;

-- 10.Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm.
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc,
-- so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
select 
	hop_dong.ma_hop_dong,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc,
    hop_dong.tien_dat_coc,
    sum(ifnull(hop_dong_chi_tiet.so_luong, 0)) as "Số lượng dịch vụ đi kèm"
from hop_dong
left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
group by 
	hop_dong.ma_hop_dong
order by
	hop_dong.ma_hop_dong;

-- 11.Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach
-- là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
create view khach_diamond_vinh_quang_ngai as
select ma_khach_hang from khach_hang
	inner join loai_khach on loai_khach.ma_loai_khach = khach_hang.ma_loai_khach
where loai_khach.ten_loai_khach like "Diamond"
	and (khach_hang.dia_chi like "%Vinh%" or khach_hang.dia_chi like "%Quảng Ngãi%");
select dich_vu_di_kem.ten_dich_vu_di_kem
from dich_vu_di_kem
	left join hop_dong_chi_tiet on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
	left join hop_dong on hop_dong_chi_tiet.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    inner join khach_diamond_vinh_quang_ngai on khach_diamond_vinh_quang_ngai.ma_khach_hang = hop_dong.ma_khach_hang
group by dich_vu_di_kem.ten_dich_vu_di_kem;

-- 12.Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng),
-- ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem),
-- tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020
-- nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
create view hop_dong_quy_4_nam_2020 as
select hop_dong.ma_hop_dong
from hop_dong
where year(hop_dong.ngay_lam_hop_dong) = 2020 and (month(hop_dong.ngay_lam_hop_dong) in (10,11,12));
create view hop_dong_6_thang_dau_nam_2021 as
select hop_dong.ma_hop_dong
from hop_dong
where year(hop_dong.ngay_lam_hop_dong) = 2021 and (month(hop_dong.ngay_lam_hop_dong) between 1 and 6);

select
	hop_dong.ma_hop_dong as "Mã hợp đồng",
    nhan_vien.ho_ten as "Họ tên nhân viên",
    khach_hang.ho_ten as "Họ tên khách hàng",
    khach_hang.so_dien_thoai as "Số điện thoại khách hàng",
    dich_vu.ten_dich_vu as "Tên dịch vụ",
    sum(ifnull(hop_dong_chi_tiet.so_luong, 0)) as "Số lượng dịch vụ đi kèm",
    sum(ifnull(hop_dong.tien_dat_coc, 0)) as "Tiền đặt cọc"
from dich_vu
	left join hop_dong on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
	left join nhan_vien on hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien
	left join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
	left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    
    inner join hop_dong_quy_4_nam_2020 on hop_dong.ma_hop_dong = hop_dong_quy_4_nam_2020.ma_hop_dong
    left join hop_dong_6_thang_dau_nam_2021 on hop_dong_6_thang_dau_nam_2021.ma_hop_dong = hop_dong.ma_hop_dong
where hop_dong_6_thang_dau_nam_2021.ma_hop_dong is null
group by
	hop_dong.ma_hop_dong,
    nhan_vien.ho_ten,
    khach_hang.ho_ten,
    khach_hang.so_dien_thoai,
    dich_vu.ten_dich_vu;

-- 13.Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
select
	dich_vu_di_kem.ten_dich_vu_di_kem,
    sum(ifnull(hop_dong_chi_tiet.so_luong, 0)) as "Số lần sử dụng"
from dich_vu_di_kem
    inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
group by
		dich_vu_di_kem.ten_dich_vu_di_kem
having
	sum(ifnull(hop_dong_chi_tiet.so_luong, 0)) = (
    select
    sum(ifnull(hop_dong_chi_tiet.so_luong, 0)) as sl
	from dich_vu_di_kem
    inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
	group by dich_vu_di_kem.ten_dich_vu_di_kem
	order by sl desc
    limit 1
    );

-- 14.Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung
-- (được tính dựa trên việc count các ma_dich_vu_di_kem).
select 
	max(hop_dong.ma_hop_dong) as id_hop_dong, 
    dich_vu_di_kem.ten_dich_vu_di_kem,
    count(hop_dong_chi_tiet.ma_hop_dong_chi_tiet) as so_lan_su_dung
from hop_dong
	inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
    right join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
group by 
    dich_vu_di_kem.ten_dich_vu_di_kem
having so_lan_su_dung = 1;
    
-- 15.Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan,
-- so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
create view hop_dong_2020_2021 as
select nhan_vien.ma_nhan_vien
from nhan_vien
	left join hop_dong on nhan_vien.ma_nhan_vien = hop_dong.ma_nhan_vien
where (year(hop_dong.ngay_lam_hop_dong) between 2020 and 2021)
group by
	nhan_vien.ma_nhan_vien
having
	count(hop_dong.ma_hop_dong) <= 3;
select
	nhan_vien.ma_nhan_vien, 
    nhan_vien.ho_ten, 
    trinh_do.ten_trinh_do, 
    bo_phan.ten_bo_phan, 
    nhan_vien.so_dien_thoai, 
    nhan_vien.dia_chi
from nhan_vien
	inner join vi_tri on nhan_vien.ma_vi_tri = vi_tri.ma_vi_tri
	inner join bo_phan on nhan_vien.ma_bo_phan = bo_phan.ma_bo_phan
	inner join trinh_do on nhan_vien.ma_trinh_do = trinh_do.ma_trinh_do
    inner join hop_dong_2020_2021 on hop_dong_2020_2021.ma_nhan_vien = nhan_vien.ma_nhan_vien;

-- 16.Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.

-- 17.Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
-- chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021
-- là lớn hơn 10.000.000 VNĐ.

-- 18.Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).

-- 19.Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

-- 20.Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống,
-- thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai,
-- ngay_sinh, dia_chi.

-- 21.Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin của tất cả các nhân viên có địa chỉ là
-- “Hải Châu” và đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng là
-- “12/12/2019”.


-- 22.Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả
-- các nhân viên được nhìn thấy bởi khung nhìn này.


-- 23.Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng nào đó với 
-- ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.

-- 24.Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng hop_dong với yêu cầu
-- sp_them_moi_hop_dong phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, với nguyên tắc
-- không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

-- 25.Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi trong bảng hop_dong thì hiển thị tổng
-- số lượng bản ghi còn lại có trong bảng hop_dong ra giao diện console của database.
-- Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.

-- 26.Tạo Trigger có tên tr_cap_nhat_hop_dong khi cập nhật ngày kết thúc hợp đồng, cần kiểm tra
-- xem thời gian cập nhật có phù hợp hay không, với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn
-- ngày làm hợp đồng ít nhất là 2 ngày. Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không 
-- hợp lệ thì in ra thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày
-- ” trên console của database.
-- Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.

-- 27.Tạo Function thực hiện yêu cầu sau:
-- a.Tạo Function func_dem_dich_vu: Đếm các dịch vụ đã được sử dụng với tổng tiền là > 2.000.000 VNĐ.
-- b.Tạo Function func_tinh_thoi_gian_hop_dong: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm
-- hợp đồng đến lúc kết thúc hợp đồng mà khách hàng đã thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng
-- thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét trên toàn bộ các lần làm hợp đồng).
-- Mã của khách hàng được truyền vào như là 1 tham số của function này.

-- 28.Tạo Stored Procedure sp_xoa_dich_vu_va_hd_room để tìm các dịch vụ được thuê bởi khách hàng với
-- loại dịch vụ là “Room” từ đầu năm 2015 đến hết năm 2019 để xóa thông tin của các dịch vụ đó
-- (tức là xóa các bảng ghi trong bảng dich_vu) và xóa những hop_dong sử dụng dịch vụ liên quan
-- (tức là phải xóa những bản gi trong bảng hop_dong) và những bản liên quan khác.
