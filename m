From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] thermal: trivial: fix the typo
Date: Wed, 4 May 2016 08:46:18 -0500
Message-ID: <20160504134618.GA3079@rob-hp-laptop>
References: <1462277262-29935-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462277262-29935-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 03, 2016 at 08:07:41PM +0800, Caesar Wang wrote:
> See the thermal code, the obvious typo from my editor.

It looks like whitespace changes, not typos. Please be specific.

> 
> Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  Documentation/devicetree/bindings/thermal/thermal.txt | 10 +++++-----
>  drivers/thermal/thermal_core.c                        |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 41b817f..88b6ea1 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -62,7 +62,7 @@ For more examples of cooling devices, refer to the example sections below.
>  Required properties:
>  - #cooling-cells:	Used to provide cooling device specific information
>    Type: unsigned	while referring to it. Must be at least 2, in order
> -  Size: one cell      	to specify minimum and maximum cooling state used
> +  Size: one cell	to specify minimum and maximum cooling state used
>  			in the reference. The first cell is the minimum
>  			cooling state requested and the second cell is
>  			the maximum cooling state requested in the reference.
> @@ -119,7 +119,7 @@ Required properties:
>  Optional property:
>  - contribution:		The cooling contribution to the thermal zone of the
>    Type: unsigned	referred cooling device at the referred trip point.
> -  Size: one cell      	The contribution is a ratio of the sum
> +  Size: one cell	The contribution is a ratio of the sum
>  			of all cooling contributions within a thermal zone.
>  
>  Note: Using the THERMAL_NO_LIMIT (-1UL) constant in the cooling-device phandle
> @@ -145,7 +145,7 @@ Required properties:
>    Size: one cell
>  
>  - thermal-sensors:	A list of thermal sensor phandles and sensor specifier
> -  Type: list of 	used while monitoring the thermal zone.
> +  Type: list of		used while monitoring the thermal zone.
>    phandles + sensor
>    specifier
>  
> @@ -473,7 +473,7 @@ thermal-zones {
>  				  <&adc>;	/* pcb north */
>  
>  		/* hotspot = 100 * bandgap - 120 * adc + 484 */
> -		coefficients = 		<100	-120	484>;
> +		coefficients =		<100	-120	484>;
>  
>  		trips {
>  			...
> @@ -502,7 +502,7 @@ from the ADC sensor. The binding would be then:
>          thermal-sensors =  <&adc>;
>  
>  		/* hotspot = 1 * adc + 6000 */
> -	coefficients = 		<1	6000>;
> +	coefficients =		<1	6000>;
>  
>  (d) - Board thermal
>  
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index e5bfbd3..26870ef 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -513,7 +513,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  		if (!ret && *temp < crit_temp)
>  			*temp = tz->emul_temperature;
>  	}
> - 
> +
>  	mutex_unlock(&tz->lock);
>  exit:
>  	return ret;
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
