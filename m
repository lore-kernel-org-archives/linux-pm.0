From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/3] PM / clock_ops: make __pm_clk_enable more generic
Date: Thu, 6 Nov 2014 09:31:56 -0800
Message-ID: <20141106173156.GD34214@dtor-ws>
References: <1415281862-23764-1-git-send-email-grygorii.strashko@ti.com>
 <1415281862-23764-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415281862-23764-3-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 06, 2014 at 03:51:01PM +0200, Grygorii Strashko wrote:
> Now there are two places in code which do the same things,
> so allow __pm_clk_enable() to accept pointer on pm_clock_entry
> structure as second parameter instead of pointer on clock and
> remove duplicated code.
> 
> Also, updated function intended to be used by following patch.
> 
> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> CC: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/base/power/clock_ops.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index f061eaa..b32b5d4 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -35,14 +35,20 @@ struct pm_clock_entry {
>  /**
>   * pm_clk_enable - Enable a clock, reporting any errors
>   * @dev: The device for the given clock
> - * @clk: The clock being enabled.
> + * @ce: PM clock entry corresponding to the clock.
>   */
> -static inline int __pm_clk_enable(struct device *dev, struct clk *clk)
> +static inline int __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce)
>  {
> -	int ret = clk_enable(clk);
> -	if (ret)
> -		dev_err(dev, "%s: failed to enable clk %p, error %d\n",
> -			__func__, clk, ret);
> +	int ret;
> +
> +	if (ce->status < PCE_STATUS_ERROR) {
> +		ret = clk_enable(ce->clk);
> +		if (!ret)
> +			ce->status = PCE_STATUS_ENABLED;
> +		else
> +			dev_err(dev, "%s: failed to enable clk %p, error %d\n",
> +				__func__, ce->clk, ret);
> +	}
>  
>  	return ret;
>  }
> @@ -293,7 +299,6 @@ int pm_clk_resume(struct device *dev)
>  	struct pm_subsys_data *psd = dev_to_psd(dev);
>  	struct pm_clock_entry *ce;
>  	unsigned long flags;
> -	int ret;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
> @@ -302,13 +307,8 @@ int pm_clk_resume(struct device *dev)
>  
>  	spin_lock_irqsave(&psd->lock, flags);
>  
> -	list_for_each_entry(ce, &psd->clock_list, node) {
> -		if (ce->status < PCE_STATUS_ERROR) {
> -			ret = __pm_clk_enable(dev, ce->clk);
> -			if (!ret)
> -				ce->status = PCE_STATUS_ENABLED;
> -		}
> -	}
> +	list_for_each_entry(ce, &psd->clock_list, node)
> +		__pm_clk_enable(dev, ce);
>  
>  	spin_unlock_irqrestore(&psd->lock, flags);
>  
> @@ -417,7 +417,6 @@ int pm_clk_resume(struct device *dev)
>  	struct pm_subsys_data *psd = dev_to_psd(dev);
>  	struct pm_clock_entry *ce;
>  	unsigned long flags;
> -	int ret;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
> @@ -427,13 +426,8 @@ int pm_clk_resume(struct device *dev)
>  
>  	spin_lock_irqsave(&psd->lock, flags);
>  
> -	list_for_each_entry(ce, &psd->clock_list, node) {
> -		if (ce->status < PCE_STATUS_ERROR) {
> -			ret = __pm_clk_enable(dev, ce->clk);
> -			if (!ret)
> -				ce->status = PCE_STATUS_ENABLED;
> -		}
> -	}
> +	list_for_each_entry(ce, &psd->clock_list, node)
> +		__pm_clk_enable(dev, ce);
>  
>  	spin_unlock_irqrestore(&psd->lock, flags);
>  
> -- 
> 1.9.1
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
