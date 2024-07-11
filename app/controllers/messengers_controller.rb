class MessengersController < ApplicationController
  before_action :set_messenger, only: %i[ show edit update destroy ]

  # GET /messengers or /messengers.json
  def index
    @messengers = Messenger.all
  end

  # GET /messengers/1 or /messengers/1.json
  def show
  end

  # GET /messengers/new
  def new
    @messenger = Messenger.new
  end

  # GET /messengers/1/edit
  def edit
  end

  # POST /messengers or /messengers.json
  def create
    @messenger = Messenger.new(messenger_params)

    respond_to do |format|
      if @messenger.save
        TwilioTextMessenger.new(@messenger).call
        format.html { redirect_to messenger_url(@messenger), notice: "Messenger was successfully send in #{@messenger.phone_number}." }
        format.json { render :show, status: :created, location: @messenger }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @messenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messengers/1 or /messengers/1.json
  def update
    respond_to do |format|
      if @messenger.update(messenger_params)
        format.html { redirect_to messenger_url(@messenger), notice: "Messenger was successfully updated." }
        format.json { render :show, status: :ok, location: @messenger }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @messenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messengers/1 or /messengers/1.json
  def destroy
    @messenger.destroy!

    respond_to do |format|
      format.html { redirect_to messengers_url, notice: "Messenger was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_messenger
      @messenger = Messenger.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def messenger_params
      params.require(:messenger).permit(:phone_number, :body)
    end
end
