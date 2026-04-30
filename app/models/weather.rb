# frozen_string_literal: true

class Weather < ApplicationRecord
  include Decorable

  has_many :addresses, dependent: :destroy_async

  def need_update?
    return true if updated_at < 30.minutes.ago
    return true if forecast.blank?

    false
  end
end

# ## Schema Information
#
# Table name: `weathers`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`forecast`**    | `jsonb`            |
# **`zip`**         | `string(16)`       |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_weathers_on_zip`:
#     * **`zip`**
#
