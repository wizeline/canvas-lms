# frozen_string_literal: true

#
# Copyright (C) 2011 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

describe LegalInformationController do
  describe "GET 'terms_of_use'" do
    it "redirects to terms_of_use_url, no authorization required" do
      get "terms_of_use"
      expect(response).to redirect_to controller.terms_of_use_url
    end

    it "works with authorization" do
      user_factory
      user_session @user
      get "terms_of_use"
      expect(response).to redirect_to controller.terms_of_use_url
    end

    it "does not require acceptance of terms" do
      user_factory
      user_session @user
      session[:require_terms] = true
      get "terms_of_use"
      expect(response).to redirect_to controller.terms_of_use_url
    end
  end

  describe "GET 'privacy_policy'" do
    it "redirects to privacy_policy_url, no authorization required" do
      get "privacy_policy"
      expect(response).to redirect_to controller.privacy_policy_url
    end

    it "works with authorization" do
      user_factory
      user_session @user
      get "privacy_policy"
      expect(response).to redirect_to controller.privacy_policy_url
    end

    it "does not require acceptance of terms" do
      user_factory
      user_session @user
      session[:require_terms] = true
      get "privacy_policy"
      expect(response).to redirect_to controller.privacy_policy_url
    end
  end
end
