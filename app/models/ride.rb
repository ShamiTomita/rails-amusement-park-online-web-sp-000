class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :attraction


  def take_ride
    ride_taken = false
    user_tickets = self.user.tickets
    tickets_to_ride = self.attraction.tickets
    if tickets_to_ride <= user_tickets && self.user.height >= self.attraction.min_height
      user_tickets = user_tickets - tickets_to_ride
      ride_taken = true
      new_nausea = self.user.nausea + self.attraction.nausea_rating
      new_happiness = self.user.happiness + self.attraction.happiness_rating

      self.user.update(nausea: new_nausea, happiness: new_happiness, tickets: user_tickets)
      "Thanks for riding the #{self.attraction.name}!"
    elsif self.user.height < self.attraction.min_height && tickets_to_ride <= user_tickets
     "Sorry. You are not tall enough to ride the #{self.attraction.name}."
   elsif  tickets_to_ride > user_tickets && self.user.height >= self.attraction.min_height
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif tickets_to_ride > user_tickets && self.user.height < self.attraction.min_height
     "Sorry. You do not have enough tickets to ride the Roller Coaster. You are not tall enough to ride the #{self.attraction.name}."
    end
  end
end
