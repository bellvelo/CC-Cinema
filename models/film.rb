require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options["id"].to_i if["id"]
    @title = options["title"]
    @price = options["price"].to_i
  end

  def save()
    sql = "
    INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING *"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film["id"].to_i
  end

  def self.find(id)
    "SELECT * FROM films WHERE id = $1"
    values = [id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def update()
    sql ="
    UPDATE films SET (title, price) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
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

  def audience # who's coming to which film
    sql ="
    SELECT customers.*
    FROM customers INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1"
    values = [@id]
    audience = SqlRunner.run(sql, values)
    return audience.map {|seats| Customer.new(seats).name}
  end

  def seats_sold # number of tickets sold per film
    tickets_sold = self.audience().count
  end



  #this is the end
end
