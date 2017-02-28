# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(id: '0', name: 'Admin', email: 'admin@ncsu.edu', password: 'password', is_admin: 1)
User.create(id: '1', name: 'User', email: 'user@ncsu.edu', password: 'password', is_admin: 0)
User.create(id: '2', name: 'Another', email: 'user2@ncsu.edu', password: 'password', is_admin: 0)

Friend.create(friend1_id: '2', friend2_id:'1')
Friend.create(friend1_id: '1', friend2_id:'2')

account1 = Account.create(id: '121212121', user_id: 1, status:'active', balance:1000)
account2 = Account.create(id: '343434343', user_id: 2, status:'active', balance:2000)

Transaction.create(id:1, txn_type:'send', amount:50, to_account_id:account1, from_account_id:account2, status:'pending')