class Admin::HotThemesController < Admin::ApplicationController
  before_action :set_hot_theme, only: [ :edit, :update, :destroy]
  def index
  	@hot_theme = HotTheme.new
    @hot_themes = HotTheme.all
  end

  def create
    HotTheme.create hot_theme_params
  	redirect_to admin_hot_themes_path
  end

  def edit
  end

  def update
    @hot_theme.update_attributes hot_theme_params
    redirect_to admin_hot_themes_path
  end

  def destroy
    @hot_theme.destroy
    redirect_to admin_hot_themes_path
  end

  private 
    def hot_theme_params
    	params.require(:hot_theme).permit(:name, :url)
    end
    def set_hot_theme
      @hot_theme = HotTheme.find(params[:id])
    end       
  end
