From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH] power: supply: Add driver for TI BQ2416X battery charger
Date: Mon,  6 Feb 2017 19:00:22 -0800
Message-ID: <20170207030022.27031-1-liam@networkimprov.net>
References: <1486429749-12973-1-git-send-email-wojciech.ziemba@verifone.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486429749-12973-1-git-send-email-wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wojciech Ziemba <wo.ziemba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

G'day,

On 7 Feb 2017 at 01:09:09, Wojciech Ziemba wrote:
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2416x.txt 
> b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
> new file mode 100644
> index 0000000..8f4b814
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq2416x.txt

DT docs are usually added/amended in a separate patch.

> @@ -0,0 +1,71 @@ 
> +Binding for TI bq2416x Li-Ion Charger
> ...
> +Optional properties:
> +===================
> +- interrupt-names:		Meanigfull irq name.
> +- ti,charge-voltage:		Charge volatge [mV].
> +- ti,charge-current:		Charge current [mA].
> +- ti,termination-current:	Termination current [mA}.
> +- ti,in-current-limit:		IN source current limit. enum:
> +				- IN_CURR_LIM_1500MA (0)
> +				- IN_CURR_LIM_2500MA (1)
> +
> +- ti,usb-current-limit:		USB source current limit. enum:
> +				- USB_CURR_LIM_100MA (0)
> +				- USB_CURR_LIM_150MA (1)
> +				- USB_CURR_LIM_500MA (2)
> +				- USB_CURR_LIM_800MA (3)
> +				- USB_CURR_LIM_900MA (4)
> +				- USB_CURR_LIM_1500MA (5)

DT values are usually uA, uV, uAh, etc.
DT properties usually get a unit suffix, e.g. -microamp.
See Documentation/devicetree/bindings/property-units.txt
and https://patchwork.kernel.org/patch/9555541/

> +- ti,status-pin-enable:		0 or 1. Enable charge status output STAT pin.
> +- ti,current-termination-enable:0 or 1. Enable charge current termination.
> +- ti,usb-dpm-voltage:		USB dpm voltage [mV]. Refer to datasheet.
> +- ti,in-dpm-voltage:		IN dpm voltage [mV].
> +- ti,safety-timer:		Safety timer. enum:
> +			- TMR_27MIN (0)
> +			- TMR_6H (1)
> +			- TMR_9H (2)
> +			- TMR_OFF (3)
> +
> +- ti,supplied-to:	string array: max 4. Names of devices to which
> +			the charger supplies.

You might want to use and/or add to power_supply_battery_info, which
Sebastian asked for, see:
https://patchwork.kernel.org/patch/9555539/
https://patchwork.kernel.org/patch/9555545/
https://patchwork.kernel.org/patch/9555547/
https://patchwork.kernel.org/patch/9555549/

I'm also at work on a patch for BQ24190 which adds:
  battery:precharge-current-microamp -> info.precharge_current_ua ->
    POWER_SUPPLY_PROP_PRECHARGE_CURRENT
  battery:endcharge-current-microamp -> info.endcharge_current_ua ->
    POWER_SUPPLY_PROP_ENDCHARGE_CURRENT

Hope that helps!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
