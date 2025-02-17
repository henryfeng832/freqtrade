### 初始化项目
#### 安装依赖
* pip install build_helpers/TA_Lib-0.4.34-cp310-cp310-win_amd64.whl
* pip install -r requirements.txt
#### 配置 Freqtrade
* freqtrade create-userdir --userdir user_data
* freqtrade new-config --config user_data/config.json
#### 配置代理
```json
{
  "ccxt_config": {
    "httpsProxy": "http://127.0.0.1:7890",
    "wsProxy": "http://127.0.0.1:7890"
  },
  "ccxt_async_config": {
    "httpsProxy": "http://127.0.0.1:7890",
    "wsProxy": "http://127.0.0.1:7890"
  }
}
```
#### 配置交易对和策略
```json
{
  "pairlists": [
    {
      "method": "StaticPairList",
      "pairs": [
        "BTC/USDT:USDT",
        "ETH/USDT:USDT",
        "SOL/USDT:USDT"
      ]
    }
  ],
}
```
#### 下载数据
* freqtrade download-data --config user_data/config.json
* freqtrade backtesting --config user_data/config.json （下载完成后，你可以通过以下命令验证数据是否下载正确）
#### 运行回测/可视化回测
* freqtrade backtesting --config user_data/config.json --strategy MyStrategy
* freqtrade backtesting --config user_data/config.json --strategy MyStrategy --export trades --export-filename backtest_results.json
#### 查看报告/评估结果
* freqtrade plot-dataframe --strategy MyStrategy --config user_data/config.json --export-filename backtest_results.json
#### 超参数优化
* freqtrade hyperopt -s SampleStrategy --spaces buy sell --epochs 100 --hyperopt-loss SharpeHyperOptLoss
#### 模拟盘交易机器人
* freqtrade trade --strategy MyStrategy --config user_data/config.json --dry-run
#### 实盘交易机器人
* freqtrade trade --strategy MyStrategy --config user_data/config.json
#### 常见问题
* 10036: 在populate_exit_trend中，将dataframe的exit_long和exit_tag列设置为(:, 'long_out')，参考：https://github.com/freqtrade/freqtrade/issues/10036


生成 ws_token 的命令：
```python
>>> import secrets
>>> secrets.token_urlsafe(25)
```

生成 jwt_secret_key 的命令：
```python
>>> import secrets
>>> secrets.token_hex()
```



在 Freqtrade 的 Hyperopt 中，`--spaces` 参数用于指定要优化的参数空间。总共有以下几个可用的参数空间：

1. `buy`（或 `entry`）：优化买入/入场策略的参数。
2. `sell`（或 `exit`）：优化卖出/出场策略的参数。
3. `roi`：优化 ROI（Return on Investment）表。
4. `stoploss`：优化止损参数。
5. `trailing`：优化追踪止损参数。
6. `protection`：优化保护参数（如果您的策略使用了保护措施）。



Freqtrade 提供了多种 Hyperopt 损失函数，每种都针对不同的优化目标。除了 `SharpeHyperOptLoss`，还有以下几种常用的损失函数：

1. `ShortTradeDurHyperOptLoss`：优化短期交易持续时间。

2. `OnlyProfitHyperOptLoss`：仅关注总利润。

3. `SortinoHyperOptLoss`：使用 Sortino 比率作为优化目标。

4. `CalmarHyperOptLoss`：使用 Calmar 比率作为优化目标。

5. `MaxDrawDownHyperOptLoss`：专注于最小化最大回撤。

6. `ProfitDrawDownHyperOptLoss`：平衡利润和回撤。

7. `ReturnDrawDownHyperOptLoss`：平衡收益率和回撤。

8. `WinRatioHyperOptLoss`：优化胜率。

9. `ExpectancyHyperOptLoss`：优化期望值（平均利润乘以胜率）。

10. `CompoundHyperOptLoss`：复合多个指标的加权和。
