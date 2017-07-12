From: Michael Tatarinov <kukabu@gmail.com>
Subject: Re: [PATCH] of: thermal: Introduce "hwmon" optional property
Date: Wed, 12 Jul 2017 11:49:10 +0400
Message-ID: <CABrG=Zy7SYZBP6PyZ4aP6Fi5q3k5nCh6b5shN=CtOYTQ2DDoTA@mail.gmail.com>
References: <20170710115146.27313-1-kukabu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34679 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756778AbdGLHtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 03:49:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21so1474171lfk.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 00:49:11 -0700 (PDT)
In-Reply-To: <20170710115146.27313-1-kukabu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hello

Some clarifications for this patch.
I uses CONFIG_THERMAL_HWMON feature on Raspberry PI. It works ok with
the downstream thermal driver because it uses
thermal_zone_device_register(). After I switches to the upstream
driver this feature doesn't work because it uses
thermal_zone_of_sensor_register().
I would like to use this opportunity and in the future.

2017-07-10 15:51 GMT+04:00, Michael Tatarinov <kukabu@gmail.com>:
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
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt
> b/Documentation/devicetree/bindings/thermal/thermal.txt
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
> --
> 2.9.4
>
>
