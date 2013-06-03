class ResultsController < ApplicationController

helper_method :direct	
helper_method :hits
helper_method :test
helper_method :organic
helper_method :cpc
helper_method :facebook
helper_method :youtube
helper_method :pinterest
helper_method :twitter
helper_method :mail
helper_method :internal

helper_method :stumble
helper_method :favecrafts
helper_method :faveblog
helper_method :sewing
helper_method :afghan
helper_method :jewelry
helper_method :knitting
helper_method :christmas
helper_method :mustang
helper_method :stitch

def index
  	Garb::Session.login(params[:username], params[:password])
  	@profile = Garb::Management::Profile.all.detect {|p| p.web_property_id == params[:ua]}
 	@total = Hits.results(@profile, {:start_date => Date.today - 7, :end_date => Date.today - 1} )	
 #profile.pageviews
end

def hits
	@total.results[0]
end

#wrong thing but works
def direct
	direct = Sources.results(@profile, {:start_date => Date.today - 7, :end_date => Date.today - 1, :source.eql => '(direct)'}).results[0].visits
end

def facebook
	facebook = Social.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:socialNetwork.matches => 'Facebook'}).results[0].visits.to_i
end

def youtube
	@youtube = Social.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:socialNetwork.matches => 'YouTube'}).results[0]
	if @youtube.nil?
		@youtube = 0
	else
		@youtube.visits.to_i
	end
end

def pinterest
	pinterest = Social.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:socialNetwork.matches => 'Pinterest'}).results[0].visits.to_i
end

def organic
	organic = Medium.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:medium.matches => 'organic'}).results[0].visits.to_i
end

def cpc
	cpc = Medium.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:medium.matches => 'cpc'}).results[0].visits.to_i
end

def twitter
	twitter = Social.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:socialNetwork.matches => 'Twitter'}).results[0].visits.to_i
end

def stumble
	@stumble = Social.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:socialNetwork.matches => 'StumbleUpon'}).results[0]
	if !@stumble.nil?
		@stumble.visits.to_i
	else
		@stumble = 0
	end
end

def mail
	totalM = 0
	totalL = 0
	Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :sort => :visits.desc, :filters => {:source.contains => 'mlr.'}).each do |source|
		totalM = totalM + source.visits.to_i
	end

	Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :limit => 2000, :filters => {:source.contains => 'mail.'}).each do |source|
		totalL = totalL + source.visits.to_i
	end
	totalL+totalM #mail+mlr
end

def mustang
	totalM = 0
	Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :sort => :visits.desc, :filters => {:source.contains => 'mustanglist'}).each do |source|
		totalM = totalM + source.visits.to_i
	end
	return totalM
end

def internal
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => params[:site]}).results[0]
		if !internal.nil?
			internal.visits.to_i
		else
			internal = 0
	end
end

def stitch
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'StitchandUnwind'}).results[0].visits
end


def faveblog
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'favecraftsblog'}).results[0].visits
end

def jewelry
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'allfreejewelry'}).results[0].visits
end

def favecrafts
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'favecrafts.com'}).results[0].visits
end

def afghan
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'allfreecrochetafghan'}).results[0].visits
end

def knitting
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'allfreeknitting'}).results[0].visits
end

def sewing
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'allfreesewing'}).results[0].visits
end

def christmas
	internal = Sources.results(@profile, :start_date => Date.today - 7, :end_date => Date.today - 1, :filters => {:source.contains => 'allfreechristmas'}).results[0].visits
end


end
