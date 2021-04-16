require 'spec_helper'

RSpec.describe 'Emulate idle state' do
  def idle_state_for(page)
    state_element = page.query_selector('#state')
    page.evaluate('(element) => element.innerText', state_element)
  end

  it_fails_firefox 'changing idle state emulation causes change of the IdleDetector state', browser_context: :incognit, sinatra: true do
    page.browser_context.override_permissions("#{server_prefix}/idle-detector.html", ['idle-detection'])
    page.goto("#{server_prefix}/idle-detector.html")

    # Store initial state, as soon as it is not guaranteed to be `active, unlocked`.
    initial_state = idle_state_for(page)

    # Emulate Idle states and verify IdleDetector updates state accordingly.
    page.emulate_idle_state(is_user_active: false, is_screen_unlocked: false)
    expect(idle_state_for(page)).to eq('Idle state: idle, locked.')

    page.emulate_idle_state(is_user_active: true, is_screen_unlocked: false)
    expect(idle_state_for(page)).to eq('Idle state: active, locked.')

    page.emulate_idle_state(is_user_active: true, is_screen_unlocked: true)
    expect(idle_state_for(page)).to eq('Idle state: active, unlocked.')

    page.emulate_idle_state(is_user_active: false, is_screen_unlocked: true)
    expect(idle_state_for(page)).to eq('Idle state: idle, unlocked.')

    # Remove Idle emulation and verify IdleDetector is in initial state.
    page.emulate_idle_state
    expect(idle_state_for(page)).to eq(initial_state)

    # Emulate idle state again after removing emulation.
    page.emulate_idle_state(is_user_active: false, is_screen_unlocked: false)
    expect(idle_state_for(page)).to eq('Idle state: idle, locked.')

    # Remove emulation second time.
    page.emulate_idle_state
    expect(idle_state_for(page)).to eq(initial_state)
  end
end
