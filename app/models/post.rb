class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validate :is_not_clickbait?

    DEFINITE_CLICKBAIT = [
        /Secret/,
        /Guess/,
        /Won't Believe/,
        /Top [0..9]*/
    ]

    def is_not_clickbait?
        if DEFINITE_CLICKBAIT.none? {|a| a.match title}
            errors.add(:title, "looks like clickbait")
        end
    end
end
