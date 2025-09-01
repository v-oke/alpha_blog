module ApplicationHelper
  def gravatar_for(user)
    src="https://avatar.iran.liara.run/public"
    alt_name=user.username
    cls="rounded-circle img-fluid"
    stl="width: 100px; height: 100px; object-fit: cover;"
    image_tag(src, alt: alt_name, class: cls, style: stl)
  end
end
