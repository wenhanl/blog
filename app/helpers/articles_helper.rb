module ArticlesHelper
	def article_params
	    params.permit(:title, :text)
	end
end
