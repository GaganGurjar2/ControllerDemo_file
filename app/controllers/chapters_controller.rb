class ChaptersController < ApplicationController
  def index
	  @chapters = Chapter.all
	  render json: @chapters
	end

  def create
    @chapter = Chapter.new(chapter_params)
    if @chapter.save
      render json: @chapter, status: :created
    else
      render json: { error:"there is a some problem for create chapter " }
    end
  end
        
  def update
    @chapter = Chapter.find(params[:id])
    if @chapter.update(chapter_params)
      render json: @chapter
    else
      render json: { error:"there is a some problem for updating " }
    end 
  end

  def destroy
		@chapter = Chapter.find(params[:id])
		if @chapter.present?
			@chapter.destroy
			head :no_content
		else
			render json: { error: "Chapter not found." }
	  end
  end

  def show
    @chapter= Chapter.find(params[:id])
    if @chapter.present?
			render json: @chapter
    else
      render json: { error: "Chapter not found." }
    end
  end   

  private      
  def chapter_params
      params.require(:chapter).permit(:name, :course_id)
  end      
end
      


	  
