# Mục tiêu
- đánh giá xem tracking ghi nhận đã đầy đủ so với plan chưa
- plan xem tại file `analyses/evaluate tracking data/AI_Home 2 copy.xlsx`
# hướng dẫn
- đọc file `analyses/evaluate tracking data/ai_home_template.xlsx.xlsx` để hiểu plan tracking
- query vào bigquery với 2 dự án `AI_Home` và `AI_Home_ios` 
- check data trong các bảng trong `team-begamob.{project_id}_CACHED_Events_02.{EVENT_NAME}` với hướng dẫn
    - {project_id} là tên dự án: `AI_Home` hoặc `AI_Home_ios` 
    - {EVENT_NAME} là tên event trong plan tracking (đã viết hoa)
    - trong bảng đó sẽ có các cột có tiền tố params_{...}, đó chính là những ParamKey trong plan tracking (params_from params_action_type...)
    - nội dung của các cột đó là những ParamValue
- Hãy verify rằng tất cả data đã đầy đủ và sẵn sàng sử dụng
