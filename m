From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 01/18] thermal/drivers/hisi: Fix missing interrupt
 enablement
Date: Thu, 19 Oct 2017 18:52:07 -0700
Message-ID: <20171020015205.GA10997@localhost.localdomain>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 19, 2017 at 07:05:43PM +0200, Daniel Lezcano wrote:
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


Why only 18 patches this time? Can you please add a cover letter (0/X)
next time?

What happened to the other 7 patches?

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 9c3ce34..f3b50b0 100644
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
