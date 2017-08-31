From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: of: thermal: Introduce "hwmon" optional property
Date: Thu, 31 Aug 2017 08:08:02 -0700
Message-ID: <20170831150802.GA16971@roeck-us.net>
References: <20170710115146.27313-1-kukabu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38257 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdHaPIE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 11:08:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id t3so635854pgt.5
        for <linux-pm@vger.kernel.org>; Thu, 31 Aug 2017 08:08:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170710115146.27313-1-kukabu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Tatarinov <kukabu@gmail.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, Jul 10, 2017 at 03:51:46PM +0400, Michael Tatarinov wrote:
> Introduce an optional property called, hwmon, which enable
> registration in hwmon subsystems.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Michael Tatarinov <kukabu@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 6 ++++++
>  drivers/thermal/of-thermal.c                          | 3 +--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 88b6ea1ad290..4e51fbd4efa2 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -175,6 +175,10 @@ Optional property:
>  			2000mW, while on a 10'' tablet is around
>  			4500mW.
>  
> +- hwmon:		Register the thermal zone in hwmon subsystems
> +  Type: boolean 	(requires CONFIG_THERMAL_HWMON).
> +  Size: one cell
> +

That will probably be unacceptable since it is not a hardware description
or configuration flag but an implementation problem.

What might be acceptable is to use a device property such as "linux,no-hwmon",
set it in hwmon drivers prior to calling the registration function, then use
device_property_present() in the thermal code to check it and assign the flag
to no_hwmon. An alternative might be to add a "no_hwmon" parameter to the
thermal registration function, but that would be much more invasive and,
in my opinion, much less desirable.

Rui, Eduardo, any thoughts ?

Thanks,
Guenter

>  Note: The delay properties are bound to the maximum dT/dt (temperature
>  derivative over time) in two situations for a thermal zone:
>  (i)  - when passive cooling is activated (polling-delay-passive); and
> @@ -556,6 +560,8 @@ thermal-zones {
>  
>  		sustainable-power = <2500>;
>  
> +		hwmon;
> +
>  		trips {
>  			/* Trips are based on resulting linear equation */
>  			cpu_trip: cpu-trip {
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index d04ec3b9e5ff..ce580a57313b 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -994,8 +994,7 @@ int __init of_parse_thermal_zones(void)
>  			goto exit_free;
>  		}
>  
> -		/* No hwmon because there might be hwmon drivers registering */
> -		tzp->no_hwmon = true;
> +		tzp->no_hwmon = !of_property_read_bool(child, "hwmon");
>  
>  		if (!of_property_read_u32(child, "sustainable-power", &prop))
>  			tzp->sustainable_power = prop;
