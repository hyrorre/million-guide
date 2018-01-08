class Music < ApplicationRecord
    validates :idstr, uniqueness: true
end
