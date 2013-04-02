From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2 v2] thermal: rcar: add pm_runtime_xxx() support
Date: Tue, 02 Apr 2013 21:19:30 +0800
Message-ID: <1364908770.2190.40.camel@rzhang1-mobl4>
References: <87620gqbbe.wl%kuninori.morimoto.gx@renesas.com>
	 <874ng0qb9f.wl%kuninori.morimoto.gx@renesas.com>
	 <1364200856.2465.48.camel@rzhang1-mobl4>
	 <871ub3j9r3.wl%kuninori.morimoto.gx@renesas.com>
	 <87sj3iiu5m.wl%kuninori.morimoto.gx@renesas.com>
	 <87r4j2itio.wl%kuninori.morimoto.gx@renesas.com>
	 <87obe6itfy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16318 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760279Ab3DBNTf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Apr 2013 09:19:35 -0400
In-Reply-To: <87obe6itfy.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-pm@vger.kernel.org, Linux-SH <linux-sh@vger.kernel.org>

On Mon, 2013-03-25 at 23:08 -0700, Kuninori Morimoto wrote:
> Current rcar_thermal() didn't care about own power.
> Without this patch, rcar_thermal doesn't work on APE6 board
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

applied.

thanks,
rui
> ---
> v1 -> v2
> 
>  - fixup pm_runtime_xxx() timing
>  - fixup compile error
> 
>  drivers/thermal/rcar_thermal.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index c199623..0f0f951 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -377,6 +378,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	spin_lock_init(&common->lock);
>  	common->dev = dev;
>  
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (irq) {
>  		int ret;
> @@ -468,12 +472,16 @@ error_unregister:
>  			rcar_thermal_irq_disable(priv);
>  	}
>  
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
>  	return ret;
>  }
>  
>  static int rcar_thermal_remove(struct platform_device *pdev)
>  {
>  	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
>  	struct rcar_thermal_priv *priv;
>  
>  	rcar_thermal_for_each_priv(priv, common) {
> @@ -484,6 +492,9 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, NULL);
>  
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
>  	return 0;
>  }
>  


