module EventsHelper
  def event_link(event)
    event.user_id == current_user.id ? link_to(event.name, edit_event_path(event)) : link_to(event.name, event)
  end
end
