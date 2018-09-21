require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new ({
  "name" => "Jules",
  "funds" => 50
  })
customer1.save()

customer2 = Customer.new ({
  "name" => "Esmee",
  "funds" => 35
  })
customer2.save()

customer3 = Customer.new ({
  "name" => "Bronte",
  "funds" => 20
  })
customer3.save()

film1 = Film.new ({
  "title" => "Jaws",
  "price" => 5
  })
film1.save()

film2 = Film.new ({
  "title" => "The Godfather",
  "price" => 10
  })
film2.save()

film3 = Film.new ({
  "title" => "The Shining",
  "price" => 10
  })
film3.save()

film4 = Film.new ({
  "title" => "Annie Hall",
  "price" => 5
  })
film4.save()

ticket1 = Ticket.new ({
  "customer_id" => customer1.id,
  "film_id" => film4.id
  })
ticket1.save()

ticket2 = Ticket.new ({
  "customer_id" => customer2.id,
  "film_id" => film1.id
  })
ticket2.save()

ticket3 = Ticket.new ({
  "customer_id" => customer2.id,
  "film_id" => film3.id
  })
ticket3.save()

ticket4 = Ticket.new ({
  "customer_id" => customer3.id,
  "film_id" => film1.id
  })
ticket4.save()

############# TESTS #############

### MVP ###
# customer1.delete()
# customer1.name = "David"
# customer1.update()
# film2.price = 33
# film2.update()
# ticket1.film_id = 2
# ticket1.update()
## Show which films a customer has booked to see
# customer2.what_tickets_bought
## See which customers are coming to see one film.
# film1.audience

### BASIC EXTENSIONS ###
## how many tickets tickets_bought by customer ##
# customer1.number_tickets_bought
# customer1.how_many_tickets
## how mant tickets sold per film ##
# film1.seats_sold()
## Buying tickets should decrease the funds of the customer by the price
# customer1.buy_tickets(film1)
# customer1.update()



binding.pry
nil
