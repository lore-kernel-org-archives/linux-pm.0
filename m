From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
Date: Mon, 16 Jan 2017 21:23:43 -0800
Message-ID: <20170117052342.GA3176@localhost.localdomain>
References: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
 <1484304418-17489-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484304418-17489-3-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: jun.nie@linaro.org, geert+renesas@glider.be, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, davem@davemloft.net, chen.chaokai@zte.com.cn, linux-arm-kernel@lists.infradead.org, wang.qiang01@zte.com.cn, akpm@linux-foundation.org, mchehab@kernel.org, shawnguo@kernel.org, rui.zhang@intel.com, linux@roeck-us.net
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, Jan 13, 2017 at 06:46:58PM +0800, Baoyou Xie wrote:
> This patch adds thermal driver for ZTE's zx2967 family.

Please consider the comments I sent on your v3. They still apply here.

and also the following:

> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>


<cut>

> +static int zx2967_thermal_get_temp(void *data, int *temp)
> +{
> +	void __iomem *regs;
> +	struct zx2967_thermal_sensor *sensor = data;
> +	struct zx2967_thermal_priv *priv = sensor->priv;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> +	u32 val, sel_id;
> +
> +	regs = priv->regs;
> +	mutex_lock(&priv->lock);
> +
> +	writel_relaxed(0, regs + ZX2967_THERMAL_POWER_MODE);
> +	writel_relaxed(2, regs + ZX2967_THERMAL_DCF);
> +
> +	val = readl_relaxed(regs + ZX2967_THERMAL_SEL);
> +	val &= ~ZX2967_THERMAL_ID_MASK;
> +	sel_id = sensor->id ? ZX2967_THERMAL_ID0 : ZX2967_THERMAL_ID1;
> +	val |= sel_id;
> +	writel_relaxed(val, regs + ZX2967_THERMAL_SEL);
> +
> +	usleep_range(100, 300);
> +	val = readl_relaxed(regs + ZX2967_THERMAL_CTRL);
> +	while (!(val & ZX2967_THERMAL_READY)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(priv->dev, "Thermal sensor %d data timeout\n",
> +				sensor->id);
> +			mutex_unlock(&priv->lock);
> +			return -ETIMEDOUT;
> +		}
> +		val = readl_relaxed(regs + ZX2967_THERMAL_CTRL);

should you usleep_range() in between loops iterations?

> +	}
> +
> +	writel_relaxed(3, regs + ZX2967_THERMAL_DCF);
> +	val = readl_relaxed(regs + ZX2967_THERMAL_CTRL)
> +			 & ZX2967_THERMAL_TEMP_MASK;
> +	writel_relaxed(1, regs + ZX2967_THERMAL_POWER_MODE);
> +
> +	/*
> +	 * Calculate temperature
> +	 *   922	initial value of calibration cure
> +	 *   1.951	slope of calibration cure
> +	 */
> +	*temp = DIV_ROUND_CLOSEST((val - 922) * 1000, 1951);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops zx2967_of_thermal_ops = {
> +	.get_temp = zx2967_thermal_get_temp,
> +};
> +
> +static int zx2967_thermal_probe(struct platform_device *pdev)
> +{
> +	struct zx2967_thermal_priv *priv;
> +	struct resource *res;
> +	int ret, i;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->regs))
> +		return PTR_ERR(priv->regs);
> +
> +	priv->clk_gate = devm_clk_get(&pdev->dev, "gate");
> +	if (IS_ERR(priv->clk_gate)) {
> +		ret = PTR_ERR(priv->clk_gate);
> +		dev_err(&pdev->dev, "failed to get clock gate: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->clk_gate);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	priv->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(priv->pclk)) {
> +		ret = PTR_ERR(priv->pclk);
> +		dev_err(&pdev->dev, "failed to get apb clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->pclk);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk_gate);
> +		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&priv->lock);
> +	for (i = 0; i < NUM_SENSORS; i++) {
> +		struct zx2967_thermal_sensor *sensor = &priv->sensors[i];
> +
> +		sensor->priv = priv;
> +		sensor->id = i;
> +		sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev,
> +					i, sensor, &zx2967_of_thermal_ops);
> +		if (IS_ERR(sensor->tzd)) {
> +			ret = PTR_ERR(sensor->tzd);
> +			dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
> +				i, ret);
> +			goto remove_ts;
> +		}
> +	}
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +remove_ts:
> +	clk_disable_unprepare(priv->clk_gate);
> +	clk_disable_unprepare(priv->pclk);
> +	for (i--; i >= 0; i--)
> +		thermal_zone_of_sensor_unregister(&pdev->dev,
> +						  priv->sensors[i].tzd);
> +
> +	return ret;
> +}
> +
> +static int zx2967_thermal_exit(struct platform_device *pdev)
> +{
> +	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < NUM_SENSORS; i++) {
> +		struct zx2967_thermal_sensor *sensor = &priv->sensors[i];
> +
> +		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
> +	}
> +	clk_disable_unprepare(priv->pclk);
> +	clk_disable_unprepare(priv->clk_gate);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id zx2967_thermal_id_table[] = {
> +	{ .compatible = "zte,zx296718-thermal" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, zx2967_thermal_id_table);
> +
> +static SIMPLE_DEV_PM_OPS(zx2967_thermal_pm_ops,
> +			 zx2967_thermal_suspend, zx2967_thermal_resume);
> +
> +static struct platform_driver zx2967_thermal_driver = {
> +	.probe = zx2967_thermal_probe,
> +	.remove = zx2967_thermal_exit,
> +	.driver = {
> +		.name = "zx2967_thermal",
> +		.of_match_table = zx2967_thermal_id_table,
> +		.pm = &zx2967_thermal_pm_ops,
> +	},
> +};
> +module_platform_driver(zx2967_thermal_driver);
> +
> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> +MODULE_DESCRIPTION("ZTE zx2967 thermal driver");
> +MODULE_LICENSE("GPL");

GPLv2?

> -- 
> 2.7.4
> 
