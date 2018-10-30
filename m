From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] thermal: broadcom: constify
 thermal_zone_of_device_ops structure
Date: Tue, 30 Oct 2018 17:22:22 +0100
Message-ID: <b0442517-ea11-9366-b17d-c60acf5c9cb3@linaro.org>
References: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540912500-21941-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540912500-21941-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Markus Mayer <mmayer@broadcom.com>
Cc: kernel-janitors@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 30/10/2018 16:15, Julia Lawall wrote:
> The thermal_zone_of_device_ops structure can be const as it is only
> passed as the last argument of thermal_zone_of_sensor_register
> and the corresponding parameter is declared as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Unrelated to this change, is there a reason not to use
> devm_thermal_zone_of_sensor_register?

Agree, it would make sense to use the devm* version.

>  drivers/thermal/broadcom/brcmstb_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -299,7 +299,7 @@ static int brcmstb_set_trips(void *data,
>  	return 0;
>  }
>  
> -static struct thermal_zone_of_device_ops of_ops = {
> +static const struct thermal_zone_of_device_ops of_ops = {
>  	.get_temp	= brcmstb_get_temp,
>  	.set_trips	= brcmstb_set_trips,
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
