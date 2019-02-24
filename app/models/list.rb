class List < ApplicationRecord
  require 'peddler'

  def self.upload(user, body, list_type)

    account = Account.find_by(user: user)
    if account == nil then return end
    marketplace = "A1VC38T7YXB528"

    client = MWS.feeds(
      marketplace: marketplace,
      merchant_id: account.seller_id,
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      auth_token: account.mws_auth_token
    )

    new_body = body.encode(Encoding::Windows_31J)

    feed_type = "_POST_FLAT_FILE_LISTINGS_DATA_"
    parser = client.submit_feed(new_body, feed_type)
    doc = Nokogiri::XML(parser.body)
    submissionId = doc.xpath(".//mws:FeedSubmissionId", {"mws"=>"http://mws.amazonaws.com/doc/2009-01-01/"}).text

    process = ""
    err = 0
    while process != "_DONE_" do
      sleep(10)
      list = {feed_submission_id_list: submissionId}
      parser = client.get_feed_submission_list(list)
      doc = Nokogiri::XML(parser.body)
      process = doc.xpath(".//mws:FeedProcessingStatus", {"mws"=>"http://mws.amazonaws.com/doc/2009-01-01/"}).text
      logger.debug(process)
      err += 1
      if err > 1 then
        break
      end
    end
    generatedId = doc.xpath(".//mws:FeedSubmissionId", {"mws"=>"http://mws.amazonaws.com/doc/2009-01-01/"}).text
    logger.debug(generatedId)
    if list_type == "新規出品" then
      account.update(
        new_upload: Time.now,
        new_feed_id: generatedId
      )
    else
      account.update(
        del_upload: Time.now,
        del_feed_id: generatedId
      )
    end

  end


end
