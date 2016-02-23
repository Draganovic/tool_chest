class ToolsController < ApplicationController

  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def new
    @tool = Tool.new
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update(tool_params)
      redirect_to tool_path(@tool.id)
    else
      render :edit
    end
  end

  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy
    redirect_to tools_path
  end

  def create
    #generat new tool
    @tool = Tool.new(tool_params)
    #add attributes to that tool
    #try to save tool
    if @tool.save
      flash[:message] = "THIS IS THE MESSAGE TO LET YOU KNOW YOU CREATED A TOOL"
      #if tool saves send user to view tool(database will send user)
      session[:most_recent_tool_id] = @tool.id 
      redirect_to tool_path(@tool.id)
    else
      #if not saved we will render the new view
      render :new
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :quantity, :price)
  end
end
