class AddTagToPosts < ActiveRecord::Migration[7.1]
  def up
    add_reference :posts, :tag, foreign_key: true
    Tag.create(descryption: 'Esportes')
    Tag.create(descryption: 'Economia')
    Tag.create(descryption: 'Tecnologia')
    Tag.create(descryption: 'Artes')
  end

  def down
    remove_reference :posts, :tag, foreign_key: true

    Tag.where(descryption: ['Esportes', 'Economia', 'Tecnologia', 'Artes']).destroy_all
  end
end
