From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 11/13] power: max17042_battery: Add support for
 CHARGE_NOW property
Date: Fri, 14 Apr 2017 18:42:38 +0200
Message-ID: <20170414164238.4d5afudfclgfj4ft@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34665 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdDNQmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:42:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id x75so18564626wma.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:42:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-11-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:17PM +0200, Hans de Goede wrote:
> Atleast upower prefers the more precise charge_now sysfs value over
> capacity and the max17042 has the info, so lets export it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 56cfff7..fab4b95 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -92,6 +92,7 @@ static enum power_supply_property max17042_battery_props[] = {
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>  	POWER_SUPPLY_PROP_TEMP,
>  	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> @@ -322,6 +323,13 @@ static int max17042_get_property(struct power_supply *psy,
>  
>  		val->intval = data * 1000 / 2;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret = regmap_read(map, MAX17042_RepCap, &data);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = data * 1000 / 2;

Same as in previous, missing sense resistor in calculation.

Best regards,
Krzysztof


> +		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		ret = regmap_read(map, MAX17042_QH, &data);
>  		if (ret < 0)
> -- 
> 2.9.3
> 
