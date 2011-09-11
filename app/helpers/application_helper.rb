module ApplicationHelper
  def short_url base36
   (%{%s%s/%s} % [ request.protocol, request.host_with_port, base36 ]) 
  end
end
