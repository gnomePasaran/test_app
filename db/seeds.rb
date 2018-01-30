require 'creek'

goods = []

file_path = Rails.root.join('spec', 'support', 'goods.xlsx')

unless File.exist?(file_path)
  puts 'File dose not exist!'
  return
end

creek = Creek::Book.new(file_path)
sheet = creek.sheets[0]

dates = sheet.rows.first.except('A1').values

ActiveRecord::Base::transaction do
  sheet.rows.to_a.last(sheet.rows.count - 1).each do |row|
    next unless row.any?

    title = row.first[1]
    row.except(row.first[0]).each_with_index do |cell, i|
      goods << { title: title, date: dates[i], revenue: cell[1].to_f }
    end
  end

  Goods.create(goods)
  puts 'Well done!'
end
