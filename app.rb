require('sinatra')
require('sinatra/reloader')
require './lib/word'
require './lib/definition'
also_reload('lib/**/*.rb')

# get methods
get('/') do
  @words = Word.all
  erb(:words)
end

get('/words') do
  @words = Word.all
  erb(:words)
end

get('/words/new') do
  erb(:new_word)
end

get('/words/:id') do
  @word = Word.find(params[:id].to_i)
  erb(:show_word)
end

get('/words/:id/edit') do
  @word = Word.find(params[:id].to_i)
  erb(:edit_word)
end

get('/words/:id/definitions/:definition_id') do
  @definition = Definition.find(params[:definition_id].to_i)
  erb(:show_definition)
end

post('/words') do
  name = params[:new_word]
  word = Word.new(name: name, id: nil).save
  redirect to('/words')
end

post('/words/:id/definitions') do
  @word = Word.find(params[:id].to_i)
  definition = Definition.new(name: params[:definition_name], id: nil, word_id: @word.id).save
  erb(:show_word)
end

patch('/words/:id') do
  @word = Word.find(params[:id].to_i)
  @word.update(params[:edit_word])
  erb(:show_word)
end

patch('/words/:id/definitions/:definition_id') do
  definition = Definition.find(params[:definition_id].to_i)
  definition.update(params[:new_definition])
  @word = Word.find(params[:id].to_i)
  erb(:show_word)
end

delete('/words/:id') do
  @word = Word.find(params[:id].to_i)
  @word.delete
  @words = Word.all
  erb(:words)
end

delete('/words/:id/definitions/:definition_id') do
  definition = Definition.find(params[:definition_id].to_i).delete
  @word = Word.find(params[:id].to_i)
  erb(:show_word)
end
