module Public::NotificationsHelper
  def notification_action_text(notification)
    case notification.action
    when 'like'
      'いいね'
    when 'comment'
      'コメント'
    else
      'その他アクション'
    end
  end
end
