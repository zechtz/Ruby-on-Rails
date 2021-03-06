class PagesController < ApplicationController

    layout  "admin"
    def index
        @pages = Page.all
    end

    def show
        @page = Page.find(params[:id])
    end

    def new
        @page = Page.new

        @subjects = Subject.order("position ASC")
        @page_count = Page.count + 1
    end

    def create
        @page = Page.create(page_attr)

        if @page.save
            flash[:notice] = 'Page saved successfuly'
            redirect_to({:action => 'index'})
        else
            @subjects = Subject.order("position ASC")
            @page_count = Page.count+1
            render('new')
        end
    end

    def edit
        @page = Page.find(params[:id])
        @subjects = Subject.order("position ASC")
        @page_count = Page.count
    end

    def update
        @page = Page.find(params[:id])
        if  @page.update_attributes(page_attr)
            flash[:notice] = 'Page updated successfuly'
            redirect_to(:action => 'index',:id => @page.id)
        else
            @subjects = Subject.order("position ASC")
            @page_count = Page.count
            render('edit')
        end
    end

    def delete
        @page = Page.find(params[:id])
    end

    def destroy
        page = Page.find(params[:id])
        page.destroy
        flash[:notice] = 'Page deleted successfuly'
        redirect_to({:action => 'index'})
    end

    private

    def page_attr
        params.require(:page).permit(:subject_id ,:name,:permalink,:position,:visible)
    end
end
