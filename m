From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date: Wed, 24 Apr 2019 00:35:28 +0200
Message-ID: <a8e7d5d8-056c-a130-bf89-c3a29e982821@linaro.org>
References: <20190423141414.24264-1-jiada_wang@mentor.com>
 <20190423141414.24264-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423141414.24264-2-jiada_wang@mentor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, erosca@de.adit-jv.com, george_davis@mentor.com, joshua_frkuska@mentor.com
List-Id: linux-pm@vger.kernel.org

On 23/04/2019 16:14, Jiada Wang wrote:
> Currently IRQF_SHARED type interrupt line is allocated, but it
> is not appropriate, as the interrupt line isn't shared between
> different devices, instead IRQF_ONESHOT is the proper type.
> 
> By changing interrupt type to IRQF_ONESHOT, now irq handler is
> no longer needed, as clear of interrupt status can be done in
> threaded interrupt context.
> 
> Because IRQF_ONESHOT type interrupt line is kept disabled until
> the threaded handler has been run, so there is no need to protect
> read/write of REG_GEN3_IRQSTR with lock.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Fixes: 7d4b269776ec6 ("enable hardware interrupts for trip points")
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>





> ---
>  drivers/thermal/rcar_gen3_thermal.c | 34 +++++------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41cf16e8..ebbaef5a3cf1 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -231,39 +231,17 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
>  static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>  {
>  	struct rcar_gen3_thermal_priv *priv = data;
> +	int i;
>  	u32 status;
> -	int i, ret = IRQ_HANDLED;
>  
> -	spin_lock(&priv->lock);
>  	for (i = 0; i < priv->num_tscs; i++) {
>  		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
>  		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
>  		if (status)
> -			ret = IRQ_WAKE_THREAD;
> +			thermal_zone_device_update(priv->tscs[i]->zone,
> +						   THERMAL_EVENT_UNSPECIFIED);
>  	}
>  
> -	if (ret == IRQ_WAKE_THREAD)
> -		rcar_thermal_irq_set(priv, false);
> -
> -	spin_unlock(&priv->lock);
> -
> -	return ret;
> -}
> -
> -static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
> -{
> -	struct rcar_gen3_thermal_priv *priv = data;
> -	unsigned long flags;
> -	int i;
> -
> -	for (i = 0; i < priv->num_tscs; i++)
> -		thermal_zone_device_update(priv->tscs[i]->zone,
> -					   THERMAL_EVENT_UNSPECIFIED);
> -
> -	spin_lock_irqsave(&priv->lock, flags);
> -	rcar_thermal_irq_set(priv, true);
> -	spin_unlock_irqrestore(&priv->lock, flags);
> -
>  	return IRQ_HANDLED;
>  }
>  
> @@ -390,9 +368,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (!irqname)
>  			return -ENOMEM;
>  
> -		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
> -						rcar_gen3_thermal_irq_thread,
> -						IRQF_SHARED, irqname, priv);
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						rcar_gen3_thermal_irq,
> +						IRQF_ONESHOT, irqname, priv);
>  		if (ret)
>  			return ret;
>  	}
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
