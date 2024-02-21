class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user


  after_create :send_alert_to_admin

  private

  def send_alert_to_admin
    if event.present? && event.admin.present?
      admin = event.admin
      UserMailer.attendance_alert(admin, user).deliver_now
    end
  end
end




