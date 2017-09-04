shared_examples_for "not signed in user for" do |method, action, params|
  it "redirect to sign in" do
    send method, action, params: params
    expect(response).to redirect_to(new_user_session_url)
  end

  it 'show alert' do
    send method, action, params: params
    expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end
end

shared_examples_for "no access" do |method, action, params|
  it "redirect to root" do
    send method, action, params: { id: foreign_event.id, event: params }
    expect(response).to redirect_to(root_url)
  end

  it 'show alert' do
    send method, action, params: { id: foreign_event.id, event: params }
    expect(flash[:alert]).to eq('Access denied!')
  end
end
