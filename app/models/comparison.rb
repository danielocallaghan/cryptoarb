class Comparison < ApplicationRecord
  class << self

    def run
      puts "BTCMkts ETH price in EUR is: #{btcmkts_eur_eth_price}"
      puts "Kraken ETH price in EUR is: #{kraken_eur_eth_price}"
      puts "Spread: #{(btcmkts_eur_eth_price - kraken_eur_eth_price) / kraken_eur_eth_price}"
      puts

      puts "BTCMkts BCH price in EUR is: #{btcmkts_eur_bch_price}"
      puts "Kraken BCH price in EUR is: #{kraken_eur_bch_price}"
      puts "Spread: #{(btcmkts_eur_bch_price - kraken_eur_bch_price) / kraken_eur_bch_price}"
      #
      # puts "BTCMkts LTC price in EUR is: #{btcmkts_eur_ltc_price}"
      # puts "Kraken LTC price in EUR is: #{kraken_eur_ltc_price}"

    end

    def btcmkts_eur_bch_price
      to_eur(fetch_btcmkts_bch_to_aud)
    end

    def btcmkts_eur_ltc_price
      to_eur(fetch_btcmkts_ltc_to_aud)
    end

    def btcmkts_eur_eth_price
      to_eur(fetch_btcmkts_eth_to_aud)
    end

    def kraken_eur_bch_price
      kraken_client.ticker('BCHEUR')['BCHEUR']['c'][0].to_f
    end

    def kraken_eur_eth_price
      kraken_client.ticker('XETHZEUR')['XETHZEUR']['c'][0].to_f
    end

    def kraken_eur_ltc_price
      kraken_client.ticker('XLTCZEUR')['XLTCZEUR']['c'][0].to_f
    end

    def fetch_btcmkts_bch_to_aud
      parse_btc_response(btc_client.get_market_BCH_AUD_tick)['lastPrice']
    end

    def fetch_btcmkts_ltc_to_aud
      parse_btc_response(btc_client.get_market_LTC_AUD_tick)['lastPrice']
    end

    def fetch_btcmkts_eth_to_aud
      parse_btc_response(btc_client.get_market_ETH_AUD_tick)['lastPrice']
    end

    # API helpers
    def parse_btc_response(response)
      Hashie::Mash.new(
        JSON.parse(response)
      )
    end

    def to_eur(amount)
      0.653001 * amount
    end

    def btc_client
      @btc_client ||= BTCMarkets.new
    end

    def kraken_client
      @kraken_client ||= Kraken::Client.new('xxx', 'xxx')
    end
  end
end
