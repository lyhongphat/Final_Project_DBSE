# Project cuối kỳ - Bảo mật Cơ sở dữ liệu

ĐỀ 4: Xây dựng một ứng dụng website cho quy trình gia hạn hộ chiếu

## 1. Mô tả chung quy trình gia hạn hộ chiếu

Gia hạn hộ chiếu dành cho các đối tượng đã được cấp hộ chiếu lần đầu.Thông tin để người sử dụng đăng ký gia hạn hộ chiếu bao gồm (Họ và tên, địa chỉ thường trú, phái, CMND, điện thoại, email, mã số hộ chiếu). Thông tin này sẽ được người đăng ký điền vào form online, nộp cho bộ phận xác thực **(XT)** và được lưu vào **Passport** database. Bộ phận này sau khi đối chiếu và kiểm chứng thông tin như CMND, hộ khẩu, mã số hộ chiếu …(giả sử các thông tin liên quan đến người đăng ký dùng để đối chiếu này được lưu trữ trong một database chung gọi là **Resident** database) sẽ gửi các yêu cầu đăng ký này cho bộ phận xét duyệt **(XD)**. Các yêu cầu đăng ký sau khi được phê duyệt sẽ được gửi đến bộ phận lưu trữ **(LT)** và thông báo kết quả cho người đăng ký. Song song đó bộ phận giám sát **(GS)** chịu trách nhiệm theo dõi và giám sát các hoạt động trên.

- [XT] bao gồm các bộ phận xác thực (kiểm chứng) được chia theo quận/huyện. Ví dụ [XTQ1] chịu trách nhiệm kiểm chứng các yêu cầu gia hạn hộ chiếu cho các đối tượng thuộc Quận 1. [XT] được quyền xem thông tin từ form đăng ký và thông tin liên quan đến người đăng ký (Resident Database) **ứng với mỗi quận. Nghĩa là [XTQ1] sẽ xem được dữ liệu ứng với quận 1.**
- [XD] có quyền xem tất cả các thông tin quy định gia hạn hộ chiếu và chỉ được xem thông tin trên form đăng ký. Không được xem thông tin trong Resident Database.
- [LT] chỉ được xem các thông tin được phê duyệt (đồng ý hay không đồng ý cấp hộ chiếu) và cập nhật lại thời hạn hộ chiếu được gia hạn, nhưng không xem được thông tin cá nhân và các dữ liệu liên quan khác.
- [GS] giám sát thông tin trạng thái của dữ liệu đăng ký qua từng bước (xác thực hay không, chờ xét duyệt, được duyệt hay không).

## 2. Ghi chú

- Dữ liệu mẫu cho quy trình này SV tự thiết kế và nộp kèm theo kết quả xây dựng được.
- SV phải sử dụng các kỹ thuật bảo mật trong nội dung thực hành hoặc là các công nghệ khác liên quan đến bảo mật cơ sở dữ liệu hay được hỗ trợ bởi hệ quản trị cơ sở dữ liệu để hiện thực các chính sách và yêu cầu cho quy trình trên.
