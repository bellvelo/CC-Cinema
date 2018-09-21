require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @customer_id = options["customer_id"].to_i
    @film_id = options["film_id"].to_i
  end

  def save()
    sql ="
    INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2) RETURNING *"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def self.find(id)
    "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def update()
    sql ="
    UPDATE tickets SET (customer_id, film_id) = ($1, $2)
    WHERE id = $3"
    values = [@customer_id, @film_id, @id]
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

  #this is the end
end
