class Booking < ActiveRecord::Base
	belongs_to :bike
	belongs_to :user

	validate :check_availability#, on: :create

	private
	def check_availability
		bookings = self.bike.bookings.where('confirmed = ?', true) #todo modifications
		new_booking_dates = (self.start_datetime.to_date..self.end_datetime.to_date).to_a
		bookings.each do |booking|
			booking_dates = (booking.start_datetime.to_date..booking.end_datetime.to_date).to_a
			if !((booking_dates - new_booking_dates).length == booking_dates.length)
				errors.add(:base, "This bike has been already booked")
			end
	end
	end
end
