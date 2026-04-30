# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :weather

  validates :lat, :lng, presence: true, length: { maximum: 32 }
end

# ## Schema Information
#
# Table name: `addresses`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`full`**        | `string`           |
# **`lat`**         | `string(32)`       |
# **`lng`**         | `string(32)`       |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`weather_id`**  | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_addresses_on_weather_id`:
#     * **`weather_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`weather_id => weathers.id`**
#
