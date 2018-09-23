require_relative('../db/sql_runner')
require_relative('ticket')  # must be required here in order to new up the Ticket in buy_tickets method
require_relative('film')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"].to_i
  end

  def save
    sql ="
    INSERT INTO customers (name, funds)
    VALUES ($1, $2) RETURNING *"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  def self.find(id)
    "SELECT * FROM customers WHERE id = $1"
    values = [id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql ="DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql =" DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def what_tickets_bought # what films/tickets the customr has bought
    sql = "
    SELECT films.*
    FROM films INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    tickets_bought = SqlRunner.run(sql, values)
    return tickets_bought.map{|tix| Film.new(tix).title}
  end

  def how_many_tickets # how many tickets has the customer purchased
    self.what_tickets_bought().count
  end

  def buy_tickets(film)
    if @funds >= film.price
      @funds -= film.price
      new_ticket = Ticket.new({'customer_id' => @id, 'film_id' => film.id})
      new_ticket.save()
    end
  end

  def average_ticket_price  # practice methods
    sql = "
    SELECT films.*
    FROM films INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE customer_id = $1"
    values = [@id]
    all_tickets = SqlRunner.run(sql, values)
    ticket_array = all_tickets.map{|tix| Film.new(tix)}
    tickets = ticket_array.map{|tix| tix.price}
    total_price = tickets.sum.to_f
    ave_price = total_price / self.how_many_tickets
  end


  #this is the end
end
