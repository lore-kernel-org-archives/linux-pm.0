From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 07/11] staging: typec: fusb302: Export current-limit
 through a power_supply class dev
Date: Wed, 30 Aug 2017 07:01:38 -0700
Message-ID: <9e20e69b-2e9d-cada-a6a6-609fe7644479@roeck-us.net>
References: <20170830094814.17758-1-hdegoede@redhat.com>
 <20170830094814.17758-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170830094814.17758-8-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org, "Yueyao (Nathan) Zhu" <yueyao@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/30/2017 02:48 AM, Hans de Goede wrote:
> The fusb302 Type-C port-controller cannot control the current-limit
> directly, so we need to exported the limit so that another driver
> (e.g. the charger driver) can pick the limit up and configure the
> system accordingly.
> 
> The power-supply subsys already provides infrastructure for this,
> power-supply devices have the notion of being supplied by another
> power-supply and have properties through which we can export the
> current-limit.
> 
> Register a power_supply and export the current-limit through the
> power_supply's current-max property.
> 
> Cc: "Yueyao (Nathan) Zhu" <yueyao@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> -Put the psy class device code directly in fusb302.c rather then introducing
>   helpers which are only used by fusb302.c
> -Add an online property to the psy so that upower does not mistake it for a
>   second battery in the system
> ---
>   drivers/staging/typec/fusb302/Kconfig   |  2 +-
>   drivers/staging/typec/fusb302/fusb302.c | 63 +++++++++++++++++++++++++++++++--
>   2 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/typec/fusb302/Kconfig b/drivers/staging/typec/fusb302/Kconfig
> index fce099ff39fe..48a4f2fcee03 100644
> --- a/drivers/staging/typec/fusb302/Kconfig
> +++ b/drivers/staging/typec/fusb302/Kconfig
> @@ -1,6 +1,6 @@
>   config TYPEC_FUSB302
>   	tristate "Fairchild FUSB302 Type-C chip driver"
> -	depends on I2C
> +	depends on I2C && POWER_SUPPLY
>   	help
>   	  The Fairchild FUSB302 Type-C chip driver that works with
>   	  Type-C Port Controller Manager to provide USB PD and USB
> diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
> index 6f007f66d597..cf6355f59cd9 100644
> --- a/drivers/staging/typec/fusb302/fusb302.c
> +++ b/drivers/staging/typec/fusb302/fusb302.c
> @@ -28,6 +28,7 @@
>   #include <linux/of_device.h>
>   #include <linux/of_gpio.h>
>   #include <linux/pinctrl/consumer.h>
> +#include <linux/power_supply.h>
>   #include <linux/proc_fs.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/sched/clock.h>
> @@ -108,6 +109,11 @@ struct fusb302_chip {
>   	/* lock for sharing chip states */
>   	struct mutex lock;
>   
> +	/* psy + psy status */
> +	struct power_supply *psy;
> +	u32 current_limit;
> +	u32 supply_voltage;
> +
>   	/* chip status */
>   	enum toggling_mode toggling_mode;
>   	enum src_current_status src_current_status;
> @@ -876,11 +882,13 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
>   		chip->vbus_on = on;
>   		fusb302_log(chip, "vbus := %s", on ? "On" : "Off");
>   	}
> -	if (chip->charge_on == charge)
> +	if (chip->charge_on == charge) {
>   		fusb302_log(chip, "charge is already %s",
>   			    charge ? "On" : "Off");
> -	else
> +	} else {
>   		chip->charge_on = charge;
> +		power_supply_changed(chip->psy);
> +	}
>   
>   done:
>   	mutex_unlock(&chip->lock);
> @@ -896,6 +904,11 @@ static int tcpm_set_current_limit(struct tcpc_dev *dev, u32 max_ma, u32 mv)
>   	fusb302_log(chip, "current limit: %d ma, %d mv (not implemented)",
>   		    max_ma, mv);
>   
> +	chip->supply_voltage = mv;
> +	chip->current_limit = max_ma;
> +
> +	power_supply_changed(chip->psy);
> +
>   	return 0;
>   }
>   
> @@ -1681,6 +1694,43 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> +static int fusb302_psy_get_property(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    union power_supply_propval *val)
> +{
> +	struct fusb302_chip *chip = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = chip->charge_on;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = chip->supply_voltage * 1000; /* mV -> µV */
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval = chip->current_limit * 1000; /* mA -> µA */
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property fusb302_psy_properties[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +};
> +
> +const struct power_supply_desc fusb302_psy_desc = {
> +	.name		= "fusb302-typec-source",
> +	.type		= POWER_SUPPLY_TYPE_USB_TYPE_C,
> +	.properties	= fusb302_psy_properties,
> +	.num_properties	= ARRAY_SIZE(fusb302_psy_properties),
> +	.get_property	= fusb302_psy_get_property,
> +};
> +
>   static int init_gpio(struct fusb302_chip *chip)
>   {
>   	struct device_node *node;
> @@ -1720,6 +1770,7 @@ static int fusb302_probe(struct i2c_client *client,
>   	struct fusb302_chip *chip;
>   	struct i2c_adapter *adapter;
>   	struct device *dev = &client->dev;
> +	struct power_supply_config cfg = {};
>   	const char *name;
>   	int ret = 0;
>   	u32 v;
> @@ -1766,6 +1817,14 @@ static int fusb302_probe(struct i2c_client *client,
>   			return -EPROBE_DEFER;
>   	}
>   
> +	cfg.drv_data = chip;
> +	chip->psy = devm_power_supply_register(dev, &fusb302_psy_desc, &cfg);
> +	if (IS_ERR(chip->psy)) {
> +		ret = PTR_ERR(chip->psy);
> +		dev_err(chip->dev, "Error registering power-supply: %d\n", ret);
> +		return ret;
> +	}
> +
>   	ret = fusb302_debugfs_init(chip);
>   	if (ret < 0)
>   		return ret;
> 
