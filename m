From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 3/7] power: power_supply_core: Add *_battery_info
 fields for pre- and end-charge current
Date: Wed, 22 Mar 2017 13:12:23 +0100
Message-ID: <f49f1ca7-8882-65b8-485c-126189069ed8@redhat.com>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934304AbdCVMMw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 08:12:52 -0400
In-Reply-To: <20170321220921.5834-4-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi,

On 21-03-17 23:09, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> Battery chargers use precharge_current_ua and endcharge_current_ua
> at the beginning and end of a charging cycle. These values are set
> according to battery capacity.
>
> Depends-on: https://patchwork.kernel.org/patch/9633613/
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/power_supply_core.c | 6 ++++++
>  include/linux/power_supply.h             | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 61e20b1..17088c5 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -498,6 +498,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
>  	info->energy_full_design_uwh = -EINVAL;
>  	info->charge_full_design_uah = -EINVAL;
>  	info->voltage_min_design_uv  = -EINVAL;
> +	info->precharge_current_ua   = -EINVAL;
> +	info->endcharge_current_ua   = -EINVAL;
>
>  	if (!psy->of_node) {
>  		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> @@ -527,6 +529,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
>  			     &info->charge_full_design_uah);
>  	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
>  			     &info->voltage_min_design_uv);
> +	of_property_read_u32(battery_np, "precharge-current-microamp",
> +			     &info->precharge_current_ua);
> +	of_property_read_u32(battery_np, "endcharge-current-microamp",
> +			     &info->endcharge_current_ua);
>
>  	return 0;
>  }
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index e84f1d3..864214c 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -152,6 +152,9 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +/* where to place these? inserting above causes sysfs errors */
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_ENDCHARGE_CURRENT,
>  };
>
>  enum power_supply_type {

Ok, I just checked this and power_supply_sysfs.c contains the following:

static ssize_t power_supply_show_property(struct device *dev,
                                           struct device_attribute *attr,
                                           char *buf) {
	<snip special handling of some options>

         else if (off >= POWER_SUPPLY_PROP_MODEL_NAME)
                 return sprintf(buf, "%s\n", value.strval);

	return sprintf(buf, "%d\n", value.intval);
}

So since the options you are adding are integer options they
should be above POWER_SUPPLY_PROP_MODEL_NAME, note there
are comments in the enum stating this:

enum power_supply_property {
         /* Properties of type `int' */
         POWER_SUPPLY_PROP_STATUS = 0,
<snip>
         /* Properties of type `const char *' */
         POWER_SUPPLY_PROP_MODEL_NAME,
         POWER_SUPPLY_PROP_MANUFACTURER,
         POWER_SUPPLY_PROP_SERIAL_NUMBER,
};

And you also need to update the power_supply_attrs[]
array in drivers/power/supply/power_supply_sysfs.c

I guess missing the latter is what was causing you to see
issues with the sorting order.

Regards,

Hans


> @@ -301,6 +304,8 @@ struct power_supply_battery_info {
>  	int energy_full_design_uwh;	/* microWatt-hours */
>  	int charge_full_design_uah;	/* microAmp-hours */
>  	int voltage_min_design_uv;	/* microVolts */
> +	int precharge_current_ua;	/* microAmps */
> +	int endcharge_current_ua;       /* microAmps */
>  };
>
>  extern struct atomic_notifier_head power_supply_notifier;
>
