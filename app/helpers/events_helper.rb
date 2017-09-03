module EventsHelper
  def event_link(event)
    event.user_id == current_user.id ? link_to(event.name, edit_event_path(event.id || event.parent_id)) : link_to(event.name, event_path(event.id || event.parent_id))
  end
end
