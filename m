From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V11 2/6] thermal: of-thermal: Implement signed coefficient
 support
Date: Thu, 23 Mar 2017 16:32:26 -0700
Message-ID: <58D45B0A.5050500@gmail.com>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489356665-3175-3-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/12/17 15:11, Stefan Wahren wrote:
> Use the new function of_property_read_s32_array() to prepare
> of-thermal for negative coefficients. These are used by
> the upcoming bcm2835_thermal driver.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> ---
>  drivers/thermal/of-thermal.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index d04ec3b..491d58a 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -821,7 +821,8 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>  	struct device_node *child = NULL, *gchild;
>  	struct __thermal_zone *tz;
>  	int ret, i;
> -	u32 prop, coef[2];
> +	u32 prop;
> +	s32 coef[2];
>  
>  	if (!np) {
>  		pr_err("no thermal zone np\n");
> @@ -851,7 +852,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>  	 * one sensor per thermal zone. Thus, we are considering
>  	 * only the first two values as slope and offset.
>  	 */
> -	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
> +	ret = of_property_read_s32_array(np, "coefficients", coef, 2);
>  	if (ret == 0) {
>  		tz->slope = coef[0];
>  		tz->offset = coef[1];
> 

Since you are doing so much work to fix reading the array of s32 property, you
might also want to do the same for the s32 properties, "polling-delay-passive"
and "polling-delay".  Just change of_property_read_u32() to of_property_read_s32()
and change the type of prop to match.


drivers/thermal/of-thermal.c: In function 'thermal_of_build_thermal_zone':
drivers/thermal/of-thermal.c:841:2: warning: conversion to 'int' from 'u32' may change the sign of the result [-Wsign-conversion]
drivers/thermal/of-thermal.c:848:2: warning: conversion to 'int' from 'u32' may change the sign of the result [-Wsign-conversion]


 836         ret = of_property_read_u32(np, "polling-delay-passive", &prop);
 837         if (ret < 0) {
 838                 pr_err("missing polling-delay-passive property\n");
 839                 goto free_tz;
 840         }
 841         tz->passive_delay = prop;
 842
 843         ret = of_property_read_u32(np, "polling-delay", &prop);
 844         if (ret < 0) {
 845                 pr_err("missing polling-delay property\n");
 846                 goto free_tz;
 847         }
 848         tz->polling_delay = prop;


-Frank
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
