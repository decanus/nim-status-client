import strformat, strutils, stint, httpclient, json, chronicles
import ../libstatus/wallet as status_wallet
import ../libstatus/tokens as status_tokens
import ../libstatus/types as status_types
import ../utils/cache
import account

logScope:
  topics = "balance-manager"

type BalanceManager* = ref object
  pricePairs: CachedValues
  tokenBalances: CachedValues

proc newBalanceManager*(): BalanceManager =
  result = BalanceManager()
  result.pricePairs = newCachedValues()
  result.tokenBalances = newCachedValues()

var balanceManager = newBalanceManager()

proc getPrice(crypto: string, fiat: string): string =
  try:
    let url: string = fmt"https://min-api.cryptocompare.com/data/price?fsym={crypto}&tsyms={fiat}"
    let client = newHttpClient()
    client.headers = newHttpHeaders({ "Content-Type": "application/json" })

    let response = client.request(url)
    result = $parseJson(response.body)[fiat.toUpper]
  except Exception as e:
    echo "error getting price"
    echo e.msg
    result = "0.0"

proc getEthBalance(address: string): string =
  var balance = status_wallet.getBalance(address)
  result = status_wallet.hex2Eth(balance)

proc getBalance*(symbol: string, accountAddress: string, tokenAddress: string): string =
  let cacheKey = fmt"{symbol}-{accountAddress}-{tokenAddress}"
  if balanceManager.tokenBalances.isCached(cacheKey):
    return balanceManager.tokenBalances.get(cacheKey)

  if symbol == "ETH":
    let ethBalance = getEthBalance(accountAddress)
    balanceManager.tokenBalances.cacheValue(cacheKey, ethBalance)
    return ethBalance

  result = $status_tokens.getTokenBalance(tokenAddress, accountAddress)
  balanceManager.tokenBalances.cacheValue(cacheKey, result)

proc convertValue*(balance: string, fromCurrency: string, toCurrency: string): float =
  if balance == "0.0": return 0.0
  let cacheKey = fmt"{fromCurrency}-{toCurrency}"
  if balanceManager.pricePairs.isCached(cacheKey):
    return parseFloat(balance) * parseFloat(balanceManager.pricePairs.get(cacheKey))

  var fiat_crypto_price = getPrice(fromCurrency, toCurrency)
  balanceManager.pricePairs.cacheValue(cacheKey, fiat_crypto_price)
  parseFloat(balance) * parseFloat(fiat_crypto_price)

proc updateBalance*(asset: Asset, currency: string) =
  var token_balance = getBalance(asset.symbol, asset.accountAddress, asset.address)
  let fiat_balance = convertValue(token_balance, asset.symbol, currency)
  asset.value = token_balance
  asset.fiatBalanceDisplay = fmt"{fiat_balance:.2f} {currency}"
  asset.fiatBalance = fmt"{fiat_balance:.2f}"

proc updateBalance*(account: WalletAccount, currency: string) =
  try:
    let eth_balance = getBalance("ETH", account.address, "")
    let usd_balance = convertValue(eth_balance, "ETH", currency)
    var totalAccountBalance = usd_balance
    account.realFiatBalance = totalAccountBalance
    account.balance = fmt"{totalAccountBalance:.2f} {currency}"
    for asset in account.assetList:
      updateBalance(asset, currency)
  except RpcException:
    error "Error in updateBalance", message = getCurrentExceptionMsg()
