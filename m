From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 04/04] video: Runtime PM hack for SuperH LCDC
	driver
Date: Fri, 31 Jul 2009 20:56:19 +0200
Message-ID: <200907312056.20542.rjw__11868.8325085261$1249066663$gmane$org@sisk.pl>
References: <20090731140158.11351.26021.sendpatchset@rx1.opensource.se>
	<20090731140252.11351.1697.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090731140252.11351.1697.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 31 July 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch modifies the SuperH Mobile LCDC framebuffer driver
> to support Runtime PM. This patch is experimental and is at this
> point still missing context save and restore support.
> 
> With debug messages it is however already possible to see that
> the deferred io clock management strategy pays off since in that
> mode the clocks are only turned on for a short period of time to
> redraw the screen. When the screen is unchanged the clocks are
> disabled and the driver can be in runtime suspended state.
> 
> Regarding pm_runtime_put_noidle()/pm_runtime_get_noresume():
> 
> This driver does not work well with the Runtime PM v11 code
> since it performs runtime_pm_get_sync() from probe() which is
> not allowed.

It is allowed, but doesn't work as expected.

> This driver needs to access hardware registers from
> probe() so runtime_pm_get_sync() must really succeed in this case
> so the bus code gets a chance to turn on the hardware device.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Changes from V1 prototype:
>  - use pm_runtime_get_sync() and pm_runtime_put_sync()
>  - use pm_runtime_disable()
>  - no need for pm_runtime_set_suspended()
>  - incomplete runtime pm functions for dev_pm_ops
>  - work around with pm_runtime_put_noidle()/pm_runtime_get_noresume()
> 
>  TODO:
>  - quite a bit
> 
>  drivers/video/sh_mobile_lcdcfb.c |   47 +++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> --- 0001/drivers/video/sh_mobile_lcdcfb.c
> +++ work/drivers/video/sh_mobile_lcdcfb.c	2009-07-30 23:12:49.000000000 +0900
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/fb.h>
>  #include <linux/clk.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
> @@ -42,9 +43,9 @@ struct sh_mobile_lcdc_chan {
>  struct sh_mobile_lcdc_priv {
>  	void __iomem *base;
>  	int irq;
> -	atomic_t clk_usecnt;
> +	atomic_t hw_usecnt;
> +	struct device *dev;
>  	struct clk *dot_clk;
> -	struct clk *clk;
>  	unsigned long lddckr;
>  	struct sh_mobile_lcdc_chan ch[2];
>  	int started;
> @@ -185,8 +186,8 @@ struct sh_mobile_lcdc_sys_bus_ops sh_mob
>  
>  static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
>  {
> -	if (atomic_inc_and_test(&priv->clk_usecnt)) {
> -		clk_enable(priv->clk);
> +	if (atomic_inc_and_test(&priv->hw_usecnt)) {
> +		pm_runtime_get_sync(priv->dev);
>  		if (priv->dot_clk)
>  			clk_enable(priv->dot_clk);
>  	}
> @@ -194,10 +195,10 @@ static void sh_mobile_lcdc_clk_on(struct
>  
>  static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
>  {
> -	if (atomic_sub_return(1, &priv->clk_usecnt) == -1) {
> +	if (atomic_sub_return(1, &priv->hw_usecnt) == -1) {
>  		if (priv->dot_clk)
>  			clk_disable(priv->dot_clk);
> -		clk_disable(priv->clk);
> +		pm_runtime_put(priv->dev);
>  	}
>  }
>  
> @@ -566,7 +567,6 @@ static int sh_mobile_lcdc_setup_clocks(s
>  				       int clock_source,
>  				       struct sh_mobile_lcdc_priv *priv)
>  {
> -	char clk_name[8];
>  	char *str;
>  	int icksel;
>  
> @@ -580,23 +580,15 @@ static int sh_mobile_lcdc_setup_clocks(s
>  
>  	priv->lddckr = icksel << 16;
>  
> -	atomic_set(&priv->clk_usecnt, -1);
> -	snprintf(clk_name, sizeof(clk_name), "lcdc%d", pdev->id);
> -	priv->clk = clk_get(&pdev->dev, clk_name);
> -	if (IS_ERR(priv->clk)) {
> -		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
> -		return PTR_ERR(priv->clk);
> -	}
> -
>  	if (str) {
>  		priv->dot_clk = clk_get(&pdev->dev, str);
>  		if (IS_ERR(priv->dot_clk)) {
>  			dev_err(&pdev->dev, "cannot get dot clock %s\n", str);
> -			clk_put(priv->clk);
>  			return PTR_ERR(priv->dot_clk);
>  		}
>  	}
> -
> +	atomic_set(&priv->hw_usecnt, -1);
> +	pm_runtime_enable(priv->dev);
>  	return 0;
>  }
>  
> @@ -714,9 +706,18 @@ static int sh_mobile_lcdc_resume(struct 
>  	return sh_mobile_lcdc_start(platform_get_drvdata(pdev));
>  }
>  
> +static int sh_mobile_lcdc_runtime_nop(struct device *dev)
> +{
> +	/* TODO: implement register save and restore */
> +
> +	return 0;
> +}
> +
>  static struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
>  	.suspend = sh_mobile_lcdc_suspend,
>  	.resume = sh_mobile_lcdc_resume,
> +	.runtime_suspend = sh_mobile_lcdc_runtime_nop,
> +	.runtime_resume = sh_mobile_lcdc_runtime_nop,
>  };
>  
>  static int sh_mobile_lcdc_remove(struct platform_device *pdev);
> @@ -753,6 +754,9 @@ static int __init sh_mobile_lcdc_probe(s
>  		goto err0;
>  	}
>  
> +	/* workaround: allow resume from probe() */
> +	pm_runtime_put_noidle(&pdev->dev);

Why don't you just call pm_runtime_resume(&pdev->dev); from here?

You know that the usage counter has been incremented, because it is .probe(),
so that should be safe.  And you won't need that
pm_runtime_get_noresume(&pdev->dev); below in that case. :-)

> +
>  	error = request_irq(i, sh_mobile_lcdc_irq, IRQF_DISABLED,
>  			    dev_name(&pdev->dev), priv);
>  	if (error) {
> @@ -761,6 +765,7 @@ static int __init sh_mobile_lcdc_probe(s
>  	}
>  
>  	priv->irq = i;
> +	priv->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, priv);
>  	pdata = pdev->dev.platform_data;
>  
> @@ -896,8 +901,13 @@ static int __init sh_mobile_lcdc_probe(s
>  			sh_mobile_lcdc_clk_off(priv);
>  	}
>  
> +	/* workaround: balance pm_runtime_put_noidle() call */
> +	pm_runtime_get_noresume(&pdev->dev);
>  	return 0;
>   err1:
> +	/* workaround: balance pm_runtime_put_noidle() call */
> +	pm_runtime_get_noresume(&pdev->dev);
> +
>  	sh_mobile_lcdc_remove(pdev);
>   err0:
>  	return error;
> @@ -932,7 +942,8 @@ static int sh_mobile_lcdc_remove(struct 
>  
>  	if (priv->dot_clk)
>  		clk_put(priv->dot_clk);
> -	clk_put(priv->clk);
> +
> +	pm_runtime_disable(priv->dev);
>  
>  	if (priv->base)
>  		iounmap(priv->base);

Best,
Rafael
