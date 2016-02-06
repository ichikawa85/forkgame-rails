class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
    port = File.read("port.txt")
    @game.port = port.to_i
    #system("open -n lib/batch/angrybot.app") # for mac
    system("./AngryBot.x86&")
    @game.save
    sleep(10)
    respond_to do |format|
      format.html { redirect_to :action => "show", :id => @game.id}
    end
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fork
    @game = Game.new
    port = File.read("port.txt")
    @game.port = port.to_i
    #File.open("lib/batch/fork.txt","w") do |file|
    File.open("fork.txt","w") do |file|
      # replace "false" with "true" in Fork flag
      file.puts("1") # This number means true
    end
    #system(" open -n lib/batch/angrybot.app ") # for mac
    system("./AngryBot.x86&")
    @game.save
    sleep(15)
    respond_to do |format|
      format.html { redirect_to :action => "show", :id => @game.id}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :port)
    end
end
