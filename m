From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 2/7] thermal: armada: Add infrastructure to support
 generic formulas
Date: Wed, 14 May 2014 20:07:22 -0400
Message-ID: <20140515000722.GA10716@developer>
References: <1399395591-5713-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1399395591-5713-3-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:55564 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaEOAHm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 20:07:42 -0400
Received: by mail-yk0-f170.google.com with SMTP id 10so279766ykt.29
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 17:07:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1399395591-5713-3-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hello Ezequiel,

A minor change suggestion:

On Tue, May 06, 2014 at 01:59:46PM -0300, Ezequiel Garcia wrote:
> In order to support other similar SoC, with different sensor
> coeficients, this commit adds the coeficients to the per-variant

s/coeficient/coefficient/g

> structure, instead of having the formula hardcoded.
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/thermal/armada_thermal.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index c5db071..4de6e56 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -53,6 +53,11 @@ struct armada_thermal_data {
>  
>  	/* Test for a valid sensor value (optional) */
>  	bool (*is_valid)(struct armada_thermal_priv *);
> +
> +	/* Formula coeficients: temp = (b + m * reg) / div */
> +	unsigned long coef_b;
> +	unsigned long coef_m;
> +	unsigned long coef_div;
>  };
>  
>  static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
> @@ -111,6 +116,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  {
>  	struct armada_thermal_priv *priv = thermal->devdata;
>  	unsigned long reg;
> +	unsigned long m, b, div;
>  
>  	/* Valid check */
>  	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
> @@ -121,7 +127,13 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  
>  	reg = readl_relaxed(priv->sensor);
>  	reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
> -	*temp = (3153000000UL - (10000000UL*reg)) / 13825;
> +
> +	/* Get formula coeficients */
> +	b = priv->data->coef_b;
> +	m = priv->data->coef_m;
> +	div = priv->data->coef_div;
> +
> +	*temp = (b - (m * reg)) / div;
>  	return 0;
>  }
>  
> @@ -131,11 +143,17 @@ static struct thermal_zone_device_ops ops = {
>  
>  static const struct armada_thermal_data armadaxp_data = {
>  	.init_sensor = armadaxp_init_sensor,
> +	.coef_b = 3153000000UL,
> +	.coef_m = 10000000UL,
> +	.coef_div = 13825,
>  };
>  
>  static const struct armada_thermal_data armada370_data = {
>  	.is_valid = armada_is_valid,
>  	.init_sensor = armada370_init_sensor,
> +	.coef_b = 3153000000UL,
> +	.coef_m = 10000000UL,
> +	.coef_div = 13825,

No difference between armada370 and armadaxp extrapolation 
formula?

>  };
>  
>  static const struct of_device_id armada_thermal_id_table[] = {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
