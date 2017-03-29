From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V11 2/6] thermal: of-thermal: Implement signed
 coefficient support
Date: Tue, 28 Mar 2017 21:54:24 -0700
Message-ID: <20170329045422.GB2582@localhost.localdomain>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489356665-3175-3-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On Sun, Mar 12, 2017 at 10:11:01PM +0000, Stefan Wahren wrote:
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

For the scope of the proposed change I see not problem with this patch.

However, this needs to go in after the of core change gets accepted.
Alternatively, I could take the full series if you get an Ack from OF
maintainers.

>  	if (ret == 0) {
>  		tz->slope = coef[0];
>  		tz->offset = coef[1];
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
