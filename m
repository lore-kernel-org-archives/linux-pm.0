From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 2/3] thermal: rcar_thermal: Prevent doing work after
 unbind
Date: Fri, 28 Sep 2018 11:00:53 +0200
Message-ID: <20180928090053.GC24305@bigcity.dyn.berto.se>
References: <20180927113235.30354-1-geert+renesas@glider.be>
 <20180927113235.30354-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927113235.30354-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Support Opensource <support.opensource@diasemi.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2018-09-27 13:32:34 +0200, Geert Uytterhoeven wrote:
> When testing bind/unbind on r8a7791/koelsch:
> 
>     WARNING: CPU: 1 PID: 697 at lib/debugobjects.c:329 debug_print_object+0x8c/0xb4
>     ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x10
> 
> This happens if the workqueue runs after the device has been unbound.
> Fix this by cancelling any queued work during remove.
> 
> Fixes: e0a5172e9eec7f0d ("thermal: rcar: add interrupt support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index ea132e122b174757..616ba2fccf410d3b 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -453,6 +453,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  
>  	rcar_thermal_for_each_priv(priv, common) {
>  		rcar_thermal_irq_disable(priv);
> +		cancel_delayed_work_sync(&priv->work);
>  		if (priv->chip->use_of_thermal)
>  			thermal_remove_hwmon_sysfs(priv->zone);
>  		else
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
