require ('pg')

class Property

  attr_accessor :address, :address, :value, :num_bedrooms, :year_built, :buy_let_status, :square_footage, :build_type


  def initialize(options)
    @id = options['id'] if options['id']
    @address = options['address']
    @value = options['value']
    @num_bedrooms = options['num_bedrooms']
    @year_built = options['year_built']
    @buy_let_status = options['buy_let_status']
    @square_footage = options['square_footage']
    @build_type = options['build_type']
  end


  def save()
    # creating a connection to database and saving to var
    db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
    # writing SQL query and saving to variable
    sql = " INSERT INTO property_tracker
    (address,
      value,
      num_bedrooms,
      year_built,
      buy_let_status,
      square_footage,
      build_type)
      VALUES
      ($1, $2, $3, $4, $5, $6, $7)
      RETURNING id"
      values = [@address, @value, @num_bedrooms,
        @year_built, @buy_let_status, @square_footage, @build_type]
        db.prepare("save", sql)

        # execute the sql command
        # db.exec(sql)
        pg_result = db.exec_prepared("save", values)
        @id = pg_result[0]["id"].to_i()
        # close connection to database (security)
        db.close()
      end

      def update()
        db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
        sql = "UPDATE property_tracker
        SET(address,
          value,
          num_bedrooms,
          year_built,
          buy_let_status,
          square_footage,
          build_type)
          VALUES
          ($1, $2, $3, $4, $5, $6, $7)
          WHERE id = $8"

          values = [@address, @value, @num_bedrooms,
            @year_built, @buy_let_status, @square_footage, @build_type, @id]

            db.prepare("update", sql)
            db.exec_prepared("update", values)

            db.close()
          end

          def delete()
            db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
            sql = "DELETE FROM property_tracker WHERE id = $1"
            values = [@id]
            db.prepare("delete_one", sql)
            db.exec_prepared("delete_one", values)
            db.close()
          end

          def Property.all()
            # get db object
            db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
            # Write SQL statement
            sql = "SELECT * FROM property_tracker"
            # prepare + execute SQL
            db.prepare("all", sql)

            # this is like an array of hashes
            property_db_result = db.exec_prepared("all")
            # close DB connection
            db.close()


            # APPROACH 1
            # orders = []
            #     for order_hash in orders_db_result
            #       new_pizza_order_object = PizzaOrder.new(order_hash)
            #       orders.push(new_pizza_order_object)

            # APPROACH 2
            properties = property_db_result.map{|property_hash| Property.new(property_hash)}
            return properties
          end

          def find_by_id()
            db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
            sql = "SELECT * FROM property_tracker WHERE id = $1"
            values = [@id]
            db.prepare("delete_one", sql)
            db.exec_prepared("delete_one", values)
            db.close()
          end

          def Property.find_by_id(passed_id)
            # get db object
            db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
            # Write SQL statement
            sql = "SELECT * FROM property_tracker WHERE id = $1"
            value = [passed_id]
            # prepare + execute SQL
            db.prepare("find", sql)

            # this is like an array of hashes
            property_db_result = db.exec_prepared("find", value)
            # close DB connection
            db.close()

            #
            # APPROACH 1
            # orders = []
            #     for order_hash in orders_db_result
            #       new_pizza_order_object = PizzaOrder.new(order_hash)
            #       orders.push(new_pizza_order_object)

            # APPROACH 2
            properties = property_db_result.map{|property_hash| Property.new(property_hash)}
            return properties
          end

          def Property.find_by_address(address)
            # get db object
            db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
            # Write SQL statement
            sql = "SELECT * FROM property_tracker WHERE address = $1"
            value = [address]
            # prepare + execute SQL
            db.prepare("find", sql)

            # this is like an array of hashes
            property_db_result = db.exec_prepared("find", value)
            # close DB connection
            db.close()

            #
            # APPROACH 1
            # orders = []
            #     for order_hash in orders_db_result
            #       new_pizza_order_object = PizzaOrder.new(order_hash)
            #       orders.push(new_pizza_order_object)

            # APPROACH 2
            properties = property_db_result.map{|property_hash| Property.new(property_hash)}
            if properties.first == nil
              return "Sorry, we couldn't find #{address} in the database."
            end
            return properties
          end


          def Property.delete_all()
            # create db connection
            db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
            # write some SQL
            sql = "DELETE FROM property_tracker"
            # execute SQL
            db.prepare("delete_all", sql)
            db.exec_prepared("delete_all")

            # close db connection
            db.close()

          end


        end
