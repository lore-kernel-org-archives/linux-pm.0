From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 01/17] reset: add of_reset_control_get_by_index()
Date: Thu, 12 Mar 2015 16:01:44 +0100
Message-ID: <1426172504.14455.67.camel@pengutronix.de>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
	 <1426162518-7405-2-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426162518-7405-2-git-send-email-vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Vince,

Am Donnerstag, den 12.03.2015, 20:15 +0800 schrieb Vince Hsu:
> Add of_reset_control_get_by_index() to allow the drivers to get reset device
> without knowing its name.

I see this is useful in the case of PM domain drivers that just need to
trigger a list of resets in whatever order.

> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> ---
> v2: minor changes according to Alex's comments
> 
>  drivers/reset/core.c  | 44 +++++++++++++++++++++++++++++---------------
>  include/linux/reset.h |  9 +++++++++
>  2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 7955e00d04d4..5e78866acd62 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -140,28 +140,15 @@ int reset_control_status(struct reset_control *rstc)
>  }
>  EXPORT_SYMBOL_GPL(reset_control_status);
>  
> -/**
> - * of_reset_control_get - Lookup and obtain a reference to a reset controller.
> - * @node: device to be reset by the controller
> - * @id: reset line name
> - *
> - * Returns a struct reset_control or IS_ERR() condition containing errno.
> - *
> - * Use of id names is optional.
> - */
> -struct reset_control *of_reset_control_get(struct device_node *node,
> -					   const char *id)
> +struct reset_control *__of_reset_control_get(struct device_node *node,
> +						int index)

static

>  {
>  	struct reset_control *rstc = ERR_PTR(-EPROBE_DEFER);
>  	struct reset_controller_dev *r, *rcdev;
>  	struct of_phandle_args args;
> -	int index = 0;
>  	int rstc_id;
>  	int ret;
>  
> -	if (id)
> -		index = of_property_match_string(node,
> -						 "reset-names", id);
>  	ret = of_parse_phandle_with_args(node, "resets", "#reset-cells",
>  					 index, &args);
>  	if (ret)
> @@ -202,6 +189,33 @@ struct reset_control *of_reset_control_get(struct device_node *node,
>  
>  	return rstc;
>  }
> +
> +struct reset_control *of_reset_control_get_by_index(struct device_node *node,
> +					   int index)
> +{
> +	return __of_reset_control_get(node, index);
> +}
> +EXPORT_SYMBOL_GPL(of_reset_control_get_by_index);

This function is missing a kerneldoc comment, and please add a note that
this is only to be used if the order of the resets doesn't matter.

Actually, I see no reason not to just merge __of_reset_control_get into
of_reset_control_get_by_index and then just call that from
of_reset_control_get.

> +/**
> + * of_reset_control_get - Lookup and obtain a reference to a reset controller.
> + * @node: device to be reset by the controller
> + * @id: reset line name
> + *
> + * Returns a struct reset_control or IS_ERR() condition containing errno.
> + *
> + * Use of id names is optional.
> + */
> +struct reset_control *of_reset_control_get(struct device_node *node,
> +					   const char *id)
> +{
> +	int index = 0;
> +
> +	if (id)
> +		index = of_property_match_string(node,
> +						 "reset-names", id);
> +	return __of_reset_control_get(node, index);
> +}
>  EXPORT_SYMBOL_GPL(of_reset_control_get);
[...]

regards
Philipp
