class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create

  private

  # фигня что-бы не дорабатывать стандартную форму devise
  def set_name
    self.name = "Тест №#{rand(777)}" if self.name.blank?
  end
end
