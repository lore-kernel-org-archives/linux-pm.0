From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 04/18] staging: typec: tcpm: Add helpers for exporting
 current-limit through a psy
Date: Sun, 6 Aug 2017 07:13:57 -0700
Message-ID: <49b98ec2-2282-2443-56d1-01d71b66d741@roeck-us.net>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57237 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdHFOOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 10:14:00 -0400
In-Reply-To: <20170806123555.5124-5-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org

On 08/06/2017 05:35 AM, Hans de Goede wrote:
> Not all type-c port-controller can control the current-limit directly,
> in cases where the current limit can not be controlled directly it needs
> to be exported so that another driver (e.g. the charger driver) can pick
> the limit up and configure the system accordingly.
> 
> The power-supply subsys already provides infrastructure for this,
> power-supply devices have the notion of being supplied by another
> power-supply and have properties through which we can export the
> current-limit.
> 
> This commits adds 2 helper functions for use by port-controller drivers
> which want to export the current-limit info in this way:
> 
> int tcpm_register_psy(struct device *dev, struct tcpc_dev *tcpc,
> 		      const char *name);
> int tcpm_set_current_limit_psy(struct tcpc_dev *tcpc, u32 max_ma, u32 mv);
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/staging/typec/tcpm-helpers.c | 66 ++++++++++++++++++++++++++++++++++++
>   drivers/staging/typec/tcpm.h         |  9 +++++
>   2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/staging/typec/tcpm-helpers.c b/drivers/staging/typec/tcpm-helpers.c
> index 0c87ec9936e1..8f7699576878 100644
> --- a/drivers/staging/typec/tcpm-helpers.c
> +++ b/drivers/staging/typec/tcpm-helpers.c
> @@ -20,6 +20,60 @@
>   
>   #include "tcpm.h"
>   
> +static int tcpm_psy_get_property(struct power_supply *psy,
> +				 enum power_supply_property psp,
> +				 union power_supply_propval *val)
> +{
> +	struct tcpc_dev *tcpc = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = tcpc->supply_voltage * 1000; /* mV -> µV */
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval = tcpc->current_limit * 1000; /* mA -> µA */
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property tcpm_psy_properties[] = {
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +};
> +
> +int tcpm_register_psy(struct device *dev, struct tcpc_dev *tcpc,
> +		      const char *name)

This is misleading since it relies on devm functions, and there is no unregister function.
Overall I am not too happy with tying this all into tcpm. The functions are not really tcpm
related. Not that I have a better idea how to handle this right now, but conceptually it
doesn't seem correct.

> +{
> +	struct power_supply_config psy_cfg = {};
> +	struct power_supply_desc *desc;
> +	int ret = 0;
> +
> +	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	desc->name		= name;
> +	desc->type		= POWER_SUPPLY_TYPE_USB;
> +	desc->properties	= tcpm_psy_properties;
> +	desc->num_properties	= ARRAY_SIZE(tcpm_psy_properties);
> +	desc->get_property	= tcpm_psy_get_property;
> +	psy_cfg.drv_data	= tcpc;
> +
> +	tcpc->psy = devm_power_supply_register(dev, desc, &psy_cfg);
> +	if (IS_ERR(tcpc->psy)) {
> +		ret = PTR_ERR(tcpc->psy);
> +		tcpc->psy = NULL;
> +		dev_err(dev, "Error registering power-supply: %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tcpm_register_psy);
> +
>   /* Generic (helper) implementations for some tcpc_dev callbacks */
>   int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc)
>   {
> @@ -58,3 +112,15 @@ int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc)
>   	return current_limit;
>   }
>   EXPORT_SYMBOL_GPL(tcpm_get_usb2_current_limit_extcon);
> +
> +int tcpm_set_current_limit_psy(struct tcpc_dev *tcpc, u32 max_ma, u32 mv)
> +{
> +	tcpc->supply_voltage = mv;
> +	tcpc->current_limit = max_ma;
> +
> +	if (tcpc->psy)
> +		power_supply_changed(tcpc->psy);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tcpm_set_current_limit_psy);
> diff --git a/drivers/staging/typec/tcpm.h b/drivers/staging/typec/tcpm.h
> index 35e8c1e7dba0..1b1475b487b5 100644
> --- a/drivers/staging/typec/tcpm.h
> +++ b/drivers/staging/typec/tcpm.h
> @@ -17,6 +17,7 @@
>   
>   #include <linux/bitops.h>
>   #include <linux/extcon.h>
> +#include <linux/power_supply.h>
>   #include <linux/usb/typec.h>
>   #include "pd.h"
>   
> @@ -129,6 +130,10 @@ struct tcpc_dev {
>   	struct tcpc_mux_dev *mux;
>   	/* Used by tcpm_get_usb2_current_limit_extcon helpers */
>   	struct extcon_dev *usb2_extcon;
> +	/* Used by tcpm_set_current_limit_psy helpers */
> +	struct power_supply *psy;
> +	u32 current_limit;
> +	u32 supply_voltage;
>   };
>   
>   struct tcpm_port;
> @@ -154,7 +159,11 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
>   void tcpm_pd_hard_reset(struct tcpm_port *port);
>   void tcpm_tcpc_reset(struct tcpm_port *port);
>   
> +int tcpm_register_psy(struct device *dev, struct tcpc_dev *tcpc,
> +		      const char *name);
> +
>   /* Generic (helper) implementations for some tcpc_dev callbacks */
>   int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc);
> +int tcpm_set_current_limit_psy(struct tcpc_dev *tcpc, u32 max_ma, u32 mv);
>   
>   #endif /* __LINUX_USB_TCPM_H */
> 
