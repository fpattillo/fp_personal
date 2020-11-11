# frozen_string_literal: true

require 'rails_helper'

describe 'Routing', type: :routing do
  describe 'conversation' do
    it 'to verify index' do
        expect(:get => "/conversations").to route_to(
            :controller => "conversations",
            :action => "index"
          )
    end
    it 'to verify create' do
        expect(:post => "/conversations").to route_to(
            :controller => "conversations",
            :action => "create"
          )
    end
    it 'to verify new' do
        expect(:get => "/conversations/new").to route_to(
            :controller => "conversations",
            :action => "new"
          )
      end
  end
end