From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] of: thermal: Introduce "linux,hwmon" optional property
Date: Thu, 5 Oct 2017 14:04:55 +0200
Message-ID: <5e4ecdc7-b6ca-d424-b192-ed3e8f449334@linaro.org>
References: <20171005084206.2914-1-kukabu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:45873 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdJEME7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2017 08:04:59 -0400
Received: by mail-lf0-f48.google.com with SMTP id d17so16697360lfe.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Oct 2017 05:04:59 -0700 (PDT)
In-Reply-To: <20171005084206.2914-1-kukabu@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Tatarinov <kukabu@gmail.com>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On 05/10/2017 10:42, Michael Tatarinov wrote:
> Introduce an optional property called "linux,hwmon", which enable
> registration in hwmon subsystems.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Michael Tatarinov <kukabu@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 6 ++++++
>  drivers/thermal/of-thermal.c                          | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 88b6ea1ad290..0dad55e77c7e 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -175,6 +175,10 @@ Optional property:
>  			2000mW, while on a 10'' tablet is around
>  			4500mW.
>  
> +- linux,hwmon:		Register the thermal zone in hwmon subsystems
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
> +		linux,hwmon;
> +
>  		trips {
>  			/* Trips are based on resulting linear equation */
>  			cpu_trip: cpu-trip {
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index d04ec3b9e5ff..037ef6bb9420 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -994,8 +994,11 @@ int __init of_parse_thermal_zones(void)
>  			goto exit_free;
>  		}
>  
> -		/* No hwmon because there might be hwmon drivers registering */
> -		tzp->no_hwmon = true;
> +		/**

Nit: this is kerneldoc comment format "/**"

> +		 * No hwmon by default because there might be hwmon drivers
> +		 * registering
> +		 */
> +		tzp->no_hwmon = !of_property_read_bool(child, "linux,hwmon");
>  
>  		if (!of_property_read_u32(child, "sustainable-power", &prop))
>  			tzp->sustainable_power = prop;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
