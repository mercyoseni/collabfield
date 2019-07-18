require 'rails_helper'

RSpec.describe NavigationHelper, type: :helper do
  describe '#collapsible_links_partial_path' do
    context 'signed in user' do
      before do
        allow(helper).to receive(:user_signed_in?).and_return(true)
      end

      it "returns signed_in_links partial's path" do
        expect(helper.collapsible_links_partial_path).to eq(
          'layouts/navigation/collapsible_elements/signed_in_links'
        )
      end
    end

    context 'non-signed in user' do
      before do
        allow(helper).to receive(:user_signed_in?).and_return(false)
      end

      it "returns non_signed_in_links partial's path" do
        expect(helper.collapsible_links_partial_path).to eq(
          'layouts/navigation/collapsible_elements/non_signed_in_links'
        )
      end
    end
  end
end
