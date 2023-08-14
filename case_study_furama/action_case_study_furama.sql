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
where (year(current_date()) - year(khach_hang.ngay_sinh) >= 18) and (khach_hang.dia_chi like "%Đà Nẵng%" 
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

-- 5., tong_tien (Với tổng tiền được tính theo công thức như sau:
-- Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet)
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
select 
	dich_vu.ma_dich_vu as "Mã dịch vụ",
    dich_vu.ten_dich_vu as "Tên dịch vụ",
    dich_vu.dien_tich as "Diện tích",
    dich_vu.chi_phi_thue as "Chi phí thuê",
    loai_dich_vu.ten_loai_dich_vu as "Loại dich vụ"
from dich_vu
	inner join hop_dong on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
	inner join loai_dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
group by
    dich_vu.ma_dich_vu

-- 7.Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue,
-- ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020
-- nhưng chưa từng được khách hàng đặt phòng trong năm 2021.

-- 8.Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.

-- 9.Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì
-- sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

-- 10.Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm.
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc,
-- so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).

-- 11.Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach
-- là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.

-- 12.Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng),
-- ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem),
-- tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020
-- nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

-- 13.Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).


-- 14.Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung
-- (được tính dựa trên việc count các ma_dich_vu_di_kem).

-- 15.Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan,
-- so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.

-- 16.Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.

-- 17.Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
-- chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021
-- là lớn hơn 10.000.000 VNĐ.

-- 18.Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).

-- 19.Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

-- 20.Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống,
-- thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai,
-- ngay_sinh, dia_chi.