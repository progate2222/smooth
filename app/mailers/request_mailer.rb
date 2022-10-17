class RequestMailer < ApplicationMailer
    def request_mail(task)
        @task = task

        mail to: User.find(@task.requests.last.successor_id).email, subject: "あなた宛てにタスクが申し送りされました"
    end
end
