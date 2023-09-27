# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id         :bigint           not null, primary key
#  original   :string           not null
#  short      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_urls_on_short  (key) UNIQUE
#

class Url < ApplicationRecord
  validates :original, presence: true, url: true
  validates :short, uniqueness: true, presence: true
end
