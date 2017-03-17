From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 14/15] power: supply: Add driver for Cherry Trail
 Whiskey Cove PMIC Fuel Gauge
Date: Fri, 17 Mar 2017 19:58:49 +0200
Message-ID: <1489773529.19767.84.camel@linux.intel.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
         <20170317095527.10487-15-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-15-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
> Add a driver for the Cherry Trail Whiskey Cove PMIC Fuel Gauge, note
> the Cherry Trail Whiskey Cove PMIC Fuel Gauge block is purely a fuel
> gauge
> and not a full battery controller. As such it offers a platform_data
> callback for extra power_supply properties for the actual external-
> charger
> ic driver and does not register a power_supply itself.

ic -> IC

Can we move to something like built-in device properties for additional
properties instead of extending platform data?

> +config CHT_WC_FUEL_GAUGE

I would use similar pattern:

FUEL_GAUGE_INTEL_CHTWC (or FUEL_GAUGE_CHTWC, but this might be less
obvious about vendor)

> --- /dev/null
> +++ b/drivers/power/supply/cht_wc_fuel_gauge.c
> @@ -0,0 +1,209 @@
> +/*
> + * Intel CHT Whiskey Cove Fuel Gauge driver

CHT -> Cherry Trail 

> + *
> + * Cherrytrail Whiskey Cove devices have 2 functional blocks which
> interact
> + * with the battery.

Cherry Trail? 

> +#define REG_CHARGE_NOW		0x05
> +#define REG_VOLTAGE_NOW		0x09
> +#define REG_CURRENT_NOW		0x0a
> +#define REG_CURRENT_AVG		0x0b
> +#define REG_CHARGE_FULL		0x10
> +#define REG_CHARGE_DESIGN	0x18
> +#define REG_VOLTAGE_AVG		0x19

> +#define REG_VOLTAGE_OCV		0x1b /* Only updated during
> charging */

I think comment makes more sense where actual update is happening in the
code.

> +
> +static int cht_wc_fg_read(struct cht_wc_fg_data *fg, u8 reg,
> +			  union power_supply_propval *val, int scale,
> +			  int sign_extend)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(fg->client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (sign_extend)
> +		ret = sign_extend32(ret, 15);

Magic?

> +
> +	val->intval = ret * scale;
> +
> +	return 0;
> +}


> +
> +int cht_wc_fg_get_property(enum power_supply_property prop,
> +			   union power_supply_propval *val)
> +{
> +	int ret = 0;

Sounds like redundant assignment...

> +
> +	mutex_lock(&cht_wc_fg_mutex);
> +
> 

> +	if (!cht_wc_fg) {
> +		ret = -ENXIO;
> +		goto out_unlock;
> +	}

...otherwise maybe

ret = cht_wc_fg ? 0 : -ENXIO;
if (ret)
 goto ...;

?

> +	default:
> +		ret = -ENODATA;
> +	}
> +out_unlock:
> +	mutex_unlock(&cht_wc_fg_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cht_wc_fg_get_property);

> +
> +static int cht_wc_fg_probe(struct i2c_client *client,
> +			const struct i2c_device_id *i2c_id)
> +{
> +	struct device *dev = &client->dev;
> +	struct cht_wc_fg_data *fg;
> +	acpi_status status;
> +	unsigned long long ptyp;

> +	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP",
> NULL, &ptyp);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "Failed to get PTYPE\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * The same ACPI HID is used with different PMICs check PTYP
> to
> +	 * ensure that we are dealing with a Whiskey Cove PMIC.
> +	 */
> +	if (ptyp != CHT_WC_FG_PTYPE)
> +		return -ENODEV;

Logically I would split this part to be a main driver for device which
would use actual driver based on this, though I think it too much churn
for no benefit right now.

> +	mutex_lock(&cht_wc_fg_mutex);
> +	cht_wc_fg = fg;
> +	mutex_unlock(&cht_wc_fg_mutex);

It's pity we have no common storage of single possible present device
drivers in the kernel. I would use some kind of framework rather then
keeping all those global variables with locking. Perhaps radix / RB
tree.

> +
> +	return 0;
> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
