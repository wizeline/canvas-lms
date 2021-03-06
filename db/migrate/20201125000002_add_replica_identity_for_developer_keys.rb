# frozen_string_literal: true

#
# Copyright (C) 2020 - present Instructure, Inc.
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

class AddReplicaIdentityForDeveloperKeys < ActiveRecord::Migration[5.2]
  tag :postdeploy
  disable_ddl_transaction!

  def up
    until DeveloperKey.where(root_account_id: nil, account_id: nil).limit(1_000).update_all(root_account_id: Account.site_admin&.id) < 1_000; end
    add_replica_identity "DeveloperKey", :root_account_id, 0
    remove_index :developer_keys, name: "index_developer_keys_on_root_account_id", if_exists: true
  end

  def down
    add_index :developer_keys, :root_account_id, algorithm: :concurrently, if_not_exists: true
    remove_replica_identity "DeveloperKey"
    change_column_null :developer_keys, :root_account_id, true
  end
end
