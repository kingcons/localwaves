class TrackImportJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    @importer = TrackImporter.new(user)
    @importer.run!
  end
end
