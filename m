From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Sun, 22 Jan 2012 13:59:25 +0100
Message-ID: <4F1C082D.2080005@gmail.com>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 01/21/2012 07:46 PM, Mark Brown wrote:
> Add stub runtime_pm calls which go through the flow of enabling and
> disabling but don't actually do anything with the device itself as
> there's nothing useful we can do. This provides the core PM framework
> with information about when the device is idle, enabling chip wide
> power savings.
> 
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> Acked-by: Heiko Stuebner<heiko@sntech.de>
> ---
>   drivers/i2c/busses/i2c-s3c2410.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index e6f982b..3d80bab 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -31,6 +31,7 @@
>   #include<linux/errno.h>
>   #include<linux/err.h>
>   #include<linux/platform_device.h>
> +#include<linux/pm_runtime.h>
>   #include<linux/clk.h>
>   #include<linux/cpufreq.h>
>   #include<linux/slab.h>
> @@ -564,6 +565,7 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
>   	int retry;
>   	int ret;
> 
> +	pm_runtime_get_sync(&adap->dev);

IMHO it's more appropriate to use i2c->dev here instead, i.e. to reference
the platform device we've enabled runtime PM for.

>   	clk_enable(i2c->clk);
> 
>   	for (retry = 0; retry<  adap->retries; retry++) {
> @@ -572,6 +574,7 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
> 
>   		if (ret != -EAGAIN) {
>   			clk_disable(i2c->clk);
> +			pm_runtime_put(&adap->dev);

Ditto.

>   			return ret;
>   		}
> 
> @@ -581,6 +584,7 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
>   	}
> 
>   	clk_disable(i2c->clk);
> +	pm_runtime_put(&adap->dev);

Ditto.

>   	return -EREMOTEIO;
>   }
> 
> @@ -1013,6 +1017,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>   	of_i2c_register_devices(&i2c->adap);
>   	platform_set_drvdata(pdev, i2c);
> 
> +	pm_runtime_enable(&pdev->dev);
> +
>   	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev));
>   	clk_disable(i2c->clk);
>   	return 0;
> @@ -1047,6 +1053,8 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
>   {
>   	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
> 
> +	pm_runtime_disable(&pdev->dev);
> +
>   	s3c24xx_i2c_deregister_cpufreq(i2c);
> 
>   	i2c_del_adapter(&i2c->adap);

How about the following patch (untested) ? It might be a better start for 
proper power management implementation and would still allow the driver 
to work on platforms that don't support runtime PM. 

8<----------------------------------------------

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 4c17180..0f588bb 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
@@ -551,6 +552,26 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	return ret;
 }
 
+static inline int s3c24xx_pm_runtime_get(struct s3c24xx_i2c *i2c)
+{
+	if (!pm_runtime_enabled(i2c->dev)) {
+		clk_enable(i2c->clk);
+		return 0;
+	}
+
+	return pm_runtime_get_sync(i2c->dev);
+}
+
+static inline int s3c24xx_pm_runtime_put(struct s3c24xx_i2c *i2c)
+{
+	if (!pm_runtime_enabled(i2c->dev)) {
+		clk_disable(i2c->clk);
+		return 0;
+	}
+
+	return pm_runtime_put(i2c->dev);
+}
+
 /* s3c24xx_i2c_xfer
  *
  * first port of call from the i2c bus code when an message needs
@@ -564,14 +585,14 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 	int retry;
 	int ret;
 
-	clk_enable(i2c->clk);
+	s3c24xx_pm_runtime_get(i2c);
 
 	for (retry = 0; retry < adap->retries; retry++) {
 
 		ret = s3c24xx_i2c_doxfer(i2c, msgs, num);
 
 		if (ret != -EAGAIN) {
-			clk_disable(i2c->clk);
+			s3c24xx_pm_runtime_put(i2c);
 			return ret;
 		}
 
@@ -580,7 +601,7 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 		udelay(100);
 	}
 
-	clk_disable(i2c->clk);
+	s3c24xx_pm_runtime_put(i2c);
 	return -EREMOTEIO;
 }
 
@@ -929,7 +950,9 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
 
-	clk_enable(i2c->clk);
+	platform_set_drvdata(pdev, i2c);
+	pm_runtime_enable(i2c->dev);
+	s3c24xx_pm_runtime_get(i2c);
 
 	/* map the registers */
 
@@ -1011,10 +1034,9 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	}
 
 	of_i2c_register_devices(&i2c->adap);
-	platform_set_drvdata(pdev, i2c);
 
 	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev));
-	clk_disable(i2c->clk);
+	s3c24xx_pm_runtime_put(i2c);
 	return 0;
 
  err_cpufreq:
@@ -1048,6 +1070,8 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	s3c24xx_i2c_deregister_cpufreq(i2c);
 
 	i2c_del_adapter(&i2c->adap);
@@ -1066,7 +1090,28 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_RUNTIME
+static int s3c24xx_i2c_runtime_suspend(struct device *dev)
+{
+	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
+
+	clk_disable(i2c->clk);
+	return 0;
+}
+
+static int s3c24xx_i2c_runtime_resume(struct device *dev)
+{
+	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
+
+	clk_enable(i2c->clk);
+	return 0;
+}
+#else
+#define s3c24xx_i2c_runtime_suspend NULL
+#define s3c24xx_i2c_runtime_resume NULL
+#endif
+
+#ifdef CONFIG_PM_SLEEP
 static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1089,17 +1134,18 @@ static int s3c24xx_i2c_resume(struct device *dev)
 
 	return 0;
 }
+#else
+#define s3c24xx_i2c_suspend_noirq NULL
+#define s3c24xx_i2c_resume NULL
+#endif
 
 static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
 	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
 	.resume = s3c24xx_i2c_resume,
+	.runtime_suspend = s3c24xx_i2c_runtime_suspend,
+	.runtime_resume = s3c24xx_i2c_runtime_resume,
 };
 
-#define S3C24XX_DEV_PM_OPS (&s3c24xx_i2c_dev_pm_ops)
-#else
-#define S3C24XX_DEV_PM_OPS NULL
-#endif
-
 /* device driver for platform bus bits */
 
 static struct platform_device_id s3c24xx_driver_ids[] = {
@@ -1131,7 +1177,7 @@ static struct platform_driver s3c24xx_i2c_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c-i2c",
-		.pm	= S3C24XX_DEV_PM_OPS,
+		.pm	= &s3c24xx_i2c_dev_pm_ops,
 		.of_match_table = s3c24xx_i2c_match,
 	},
 };

8>----------------------------------------------


-- 
Thanks,
Sylwester
