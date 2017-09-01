From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 01/13] thermal/drivers/hisi: Fix missing interrupt
 enablement
Date: Fri, 1 Sep 2017 16:31:33 +0800
Message-ID: <20170901083133.GA26177@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 30, 2017 at 10:47:25AM +0200, Daniel Lezcano wrote:
> The interrupt for the temperature threshold is not enabled at the end of the
> probe function, enable it after the setup is complete.
> 
> On the other side, the irq_enabled is not correctly set as we are checking if
> the interrupt is masked where 'yes' means irq_enabled=false.
> 
> 	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
> 				&data->irq_enabled);
> 
> As we are always enabling the interrupt, it is pointless to check if
> the interrupt is masked or not, just set irq_enabled to 'true'.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for patch series, I will verify them one by one. I verified the
interrupt can work well with this patch:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/thermal/hisi_thermal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index bd3572c..8381696 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -345,8 +345,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  	}
>  
>  	hisi_thermal_enable_bind_irq_sensor(data);
> -	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
> -			      &data->irq_enabled);
> +	data->irq_enabled = true;
>  
>  	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
>  		ret = hisi_thermal_register_sensor(pdev, data,
> @@ -358,6 +357,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  			hisi_thermal_toggle_sensor(&data->sensors[i], true);
>  	}
>  
> +	enable_irq(data->irq);
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
