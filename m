From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 10/13] power: max17042_battery: Add support for the
 CHARGE_FULL_DESIGN property
Date: Fri, 14 Apr 2017 18:34:29 +0200
Message-ID: <20170414163429.vcwq2afmdiilwmeb@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34092 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbdDNQed (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:34:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so13064511wrc.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:34:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-10-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:16PM +0200, Hans de Goede wrote:
> The info is there, lets export it as a property.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 770e188..56cfff7 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -90,6 +90,7 @@ static enum power_supply_property max17042_battery_props[] = {
>  	POWER_SUPPLY_PROP_VOLTAGE_AVG,
>  	POWER_SUPPLY_PROP_VOLTAGE_OCV,
>  	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>  	POWER_SUPPLY_PROP_TEMP,
> @@ -307,6 +308,13 @@ static int max17042_get_property(struct power_supply *psy,
>  
>  		val->intval = data >> 8;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret = regmap_read(map, MAX17042_DesignCap, &data);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = data * 1000 / 2;

You need to include the rsns. The step 0.5 mAh is valid only for  10
mOhm resistor.

Best regards,
Krzysztof

> +		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret = regmap_read(map, MAX17042_FullCAP, &data);
>  		if (ret < 0)
> -- 
> 2.9.3
> 
