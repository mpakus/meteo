# frozen_string_literal: true

class Weather < ApplicationRecord
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
