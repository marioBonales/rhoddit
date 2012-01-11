require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SubmitStoryController < Rho::RhoController
  include BrowserHelper

  #GET /SubmitStory
  def index
    @submit_stories = SubmitStory.find(:all)
    render
  end

  # GET /SubmitStory/{1}
  def show
    @submit_story = SubmitStory.find(@params['id'])
    if @submit_story
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /SubmitStory/new
  def new
    @submit_story = SubmitStory.new
    render :action => :new
  end

  # GET /SubmitStory/{1}/edit
  def edit
    @submit_story = SubmitStory.find(@params['id'])
    if @submit_story
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /SubmitStory/create
  def create
    @submit_story = SubmitStory.create(@params['submit_story'])
    redirect :action => :index
  end

  # POST /SubmitStory/{1}/update
  def update
    @submit_story = SubmitStory.find(@params['id'])
    @submit_story.update_attributes(@params['submit_story']) if @submit_story
    redirect :action => :index
  end

  # POST /SubmitStory/{1}/delete
  def delete
    @submit_story = SubmitStory.find(@params['id'])
    @submit_story.destroy if @submit_story
    redirect :action => :index
  end
end
