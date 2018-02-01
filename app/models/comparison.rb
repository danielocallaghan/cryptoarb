class Comparison < ApplicationRecord
  class << self

    def run
      puts "BTC Spread: #{kraken_btcmkts_btc_spread}"
      puts "ETH Spread: #{kraken_btcmkts_eth_spread}"
      puts "LTC Spread: #{kraken_btcmkts_ltc_spread}"
      puts "BCH Spread: #{kraken_btcmkts_bch_spread}"
      puts
      puts "Minimum BTC Spread: #{kraken_btcmkts_btc_spread_min}"
      puts "Minimum ETH Spread: #{kraken_btcmkts_eth_spread_min}"
      puts "Minimum LTC Spread: #{kraken_btcmkts_ltc_spread_min}"
      puts "Minimum BCH Spread: #{kraken_btcmkts_bch_spread_min}"
      puts
      puts "BTC Ask: #{kraken_eur_btc_ask}"
      puts "BTC Last: #{kraken_eur_btc_last}"
      puts
      puts "ETH Ask: #{kraken_eur_eth_ask}"
      puts "ETH Last: #{kraken_eur_eth_last}"
      puts
      puts "LTC Ask: #{kraken_eur_ltc_ask}"
      puts "LTC Last: #{kraken_eur_ltc_last}"
      puts
      puts "BCH Ask: #{kraken_eur_bch_ask}"
      puts "BCH Last: #{kraken_eur_bch_last}"
    end


  #Kraken
  
  #last
    def kraken_eur_btc_last
      kraken_client.ticker('XXBTZEUR')['XXBTZEUR']['c'][0].to_f
    end

    def kraken_eur_eth_last
      kraken_client.ticker('XETHZEUR')['XETHZEUR']['c'][0].to_f
    end

    def kraken_eur_ltc_last
      kraken_client.ticker('XLTCZEUR')['XLTCZEUR']['c'][0].to_f
    end
    
    def kraken_eur_bch_last
      kraken_client.ticker('BCHEUR')['BCHEUR']['c'][0].to_f
    end
    
  #ask
    def kraken_eur_btc_ask
      kraken_client.ticker('XXBTZEUR')['XXBTZEUR']['a'][0].to_f
    end

    def kraken_eur_eth_ask
      kraken_client.ticker('XETHZEUR')['XETHZEUR']['a'][0].to_f
    end

    def kraken_eur_ltc_ask
      kraken_client.ticker('XLTCZEUR')['XLTCZEUR']['a'][0].to_f
    end
    
    def kraken_eur_bch_ask
      kraken_client.ticker('BCHEUR')['BCHEUR']['a'][0].to_f
    end


#BTC Market

#last
    def btcmkts_aud_btc_last
      parse_btc_response(btc_client.get_market_BTC_AUD_tick)['lastPrice']
    end
    
    def btcmkts_aud_eth_last
      parse_btc_response(btc_client.get_market_ETH_AUD_tick)['lastPrice']
    end
    
    def btcmkts_aud_bch_last
      parse_btc_response(btc_client.get_market_BCH_AUD_tick)['lastPrice']
    end

    def btcmkts_aud_ltc_last
      parse_btc_response(btc_client.get_market_LTC_AUD_tick)['lastPrice']
    end

#bid
    def btcmkts_aud_btc_bid
      parse_btc_response(btc_client.get_market_BTC_AUD_tick)['bestBid']
    end
    
    def btcmkts_aud_eth_bid
      parse_btc_response(btc_client.get_market_ETH_AUD_tick)['bestBid']
    end
    
    def btcmkts_aud_bch_bid
      parse_btc_response(btc_client.get_market_BCH_AUD_tick)['bestBid']
    end

    def btcmkts_aud_ltc_bid
      parse_btc_response(btc_client.get_market_LTC_AUD_tick)['bestBid']
    end

# Spreads Kraken/BTC Market

# best spread
   def kraken_btcmkts_btc_spread
    spread(btcmkts_aud_btc_last,to_aud(kraken_eur_btc_last))
   end
   
   def kraken_btcmkts_eth_spread
    spread(btcmkts_aud_eth_last,to_aud(kraken_eur_eth_last))
   end
   
   def kraken_btcmkts_bch_spread
    spread(btcmkts_aud_bch_last,to_aud(kraken_eur_bch_last))
   end
   
   def kraken_btcmkts_ltc_spread
    spread(btcmkts_aud_ltc_last,to_aud(kraken_eur_ltc_last))
   end

# minimum spread    
   def kraken_btcmkts_btc_spread_min
    spread(btcmkts_aud_btc_bid,to_aud(kraken_eur_btc_ask))
   end
   
   def kraken_btcmkts_eth_spread_min
    spread(btcmkts_aud_eth_bid,to_aud(kraken_eur_eth_ask))
   end
   
   def kraken_btcmkts_bch_spread_min
    spread(btcmkts_aud_bch_bid,to_aud(kraken_eur_bch_ask))
   end
   
   def kraken_btcmkts_ltc_spread_min
    spread(btcmkts_aud_ltc_bid,to_aud(kraken_eur_ltc_ask))
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
    
    def to_aud(amount)
     1.54039 * amount
    end
    
    def spread(high,low)
      (((high-low)/low)*100).round(2)
    end

    def btc_client
      @btc_client ||= BTCMarkets.new
    end

    def kraken_client
      @kraken_client ||= Kraken::Client.new('xxx', 'xxx')
    end
  end


end
