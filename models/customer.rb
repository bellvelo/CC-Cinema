require_relative('../db/sql_runner')

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


#this is the end
end
