
Business Impact:
Travel agencies in their daily life works with hundreds of hotels and clients. So they need good automate process to help their travel agents maintain relationships with hotels from which they buy rooms, and clients to which they are sell those rooms.

They need to store complex pricing rules which could depends based on the season (high or low) and other complex factors.

In this application I tried to replicate relationships with suppliers (hotels) and end users (clients). I created simple database to store travel agency's connections. Also created simple pricing rules which depends based on dates of travel.

Technical Details:

There are following objects (tables) in database:
1. Hotel
a) A possibility to setup a name for the hotel. E.g. Hilton, Marriot etc.

2. Room
a) A possibility to link room with a hotel.
b) A possibility to give a name for the room.

3) Price
a) A possibility to link price with a room.
b) A possibility to store cost values (means how much it costs for a travel agency to buy the room from the hotel)
c) A possibility to store sell values (means the rate in which a travel agency sells the room to clients)
d) A possibility to set dates range when that price is applicable (date from - date to)

4. Trip (general information about the trip which clients buy from travel agency)
a) A name for a trip.
b) A possibility to see how much trip costs for travel agency.
c) A possibility to see how much clients are going to pay for the trip.
d) A possibility to see a revenue from the trip.

5. Booked Room (which rooms Travel Agent sold to his clients)
a) A possibility to link booked room with a hotel to which it belongs.
b) A possibility to link booked room with a room to which it exactly represents.
c) A possibility to see how many rooms client booked.
d) A possibility to see how much it costs for travel agency.
e) A possibility to see how much clients are going to pay.
f) A possibility to see a revenue.

Acceptance Criteria:
Travel Agent is able to search Hotel by "Hotel Name" and booking dates. 
Booking dates should be based on price dates. 
Quantity field says to Travel Agent how many selected rooms he wants to book.
After prices are found by search result Travel Agent needs to check Rooms and clicks "Save to booked rooms". 
It will create Trip record with Booked Room records and assign them to Trip.
