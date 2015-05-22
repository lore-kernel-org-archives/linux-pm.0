From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: RE: [PATCH v1] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Fri, 22 May 2015 03:24:16 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD5783A843@BGSMSX104.gar.corp.intel.com>
References: <1430782832-16518-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430782832-16518-1-git-send-email-ramakrishna.pallala@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

Any feedback on this patch?

> This patch adds the support for following battery properties to max17042 fuel
> gauge driver.
> 
> POWER_SUPPLY_PROP_TEMP_ALERT_MIN
> POWER_SUPPLY_PROP_TEMP_ALERT_MAX
> POWER_SUPPLY_PROP_TEMP_MIN
> POWER_SUPPLY_PROP_TEMP_MAX
> POWER_SUPPLY_PROP_HEALTH
> 
> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/power/max17042_battery.c       |  190
> ++++++++++++++++++++++++++++++--
>  include/linux/power/max17042_battery.h |    4 +
>  2 files changed, 183 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/max17042_battery.c
> b/drivers/power/max17042_battery.c
> index 6cc5e87..9af610c 100644
> --- a/drivers/power/max17042_battery.c
> +++ b/drivers/power/max17042_battery.c
> @@ -63,6 +63,8 @@
>  #define dP_ACC_100	0x1900
>  #define dP_ACC_200	0x3200
> 
> +#define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
> +
>  struct max17042_chip {
>  	struct i2c_client *client;
>  	struct regmap *regmap;
> @@ -85,10 +87,94 @@ static enum power_supply_property
> max17042_battery_props[] = {
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_COUNTER,
>  	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +	POWER_SUPPLY_PROP_TEMP_MIN,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
> +	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>  };
> 
> +static int max17042_get_temperature(struct max17042_chip *chip, int
> +*temp) {
> +	int ret;
> +	u32 data;
> +	struct regmap *map = chip->regmap;
> +
> +	ret = regmap_read(map, MAX17042_TEMP, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*temp = data;
> +	/* The value is signed. */
> +	if (*temp & 0x8000) {
> +		*temp = (0x7fff & ~*temp) + 1;
> +		*temp *= -1;
> +	}
> +
> +	/* The value is converted into deci-centigrade scale */
> +	/* Units of LSB = 1 / 256 degree Celsius */
> +	*temp = *temp * 10 / 256;
> +	return 0;
> +}
> +
> +static int max17042_get_battery_health(struct max17042_chip *chip, int
> +*health) {
> +	int temp, vavg, vbatt, ret;
> +	u32 val;
> +
> +	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, &val);
> +	if (ret < 0)
> +		goto health_error;
> +
> +	/* bits [0-3] unused */
> +	vavg = val * 625 / 8;
> +	/* Convert to millivolts */
> +	vavg /= 1000;
> +
> +	ret = regmap_read(chip->regmap, MAX17042_VCELL, &val);
> +	if (ret < 0)
> +		goto health_error;
> +
> +	/* bits [0-3] unused */
> +	vbatt = val * 625 / 8;
> +	/* Convert to millivolts */
> +	vbatt /= 1000;
> +
> +	if (vavg < chip->pdata->vmin) {
> +		*health = POWER_SUPPLY_HEALTH_DEAD;
> +		goto out;
> +	}
> +
> +	if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERENCE) {
> +		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		goto out;
> +	}
> +
> +	ret = max17042_get_temperature(chip, &temp);
> +	if (ret < 0)
> +		goto health_error;
> +
> +	if (temp <= chip->pdata->temp_min) {
> +		*health = POWER_SUPPLY_HEALTH_COLD;
> +		goto out;
> +	}
> +
> +	if (temp >= chip->pdata->temp_max) {
> +		*health = POWER_SUPPLY_HEALTH_OVERHEAT;
> +		goto out;
> +	}
> +
> +	*health = POWER_SUPPLY_HEALTH_GOOD;
> +
> +out:
> +	return 0;
> +
> +health_error:
> +	return ret;
> +}
> +
>  static int max17042_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val) @@ -181,19
> +267,34 @@ static int max17042_get_property(struct power_supply *psy,
>  		val->intval = data * 1000 / 2;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP:
> -		ret = regmap_read(map, MAX17042_TEMP, &data);
> +		ret = max17042_get_temperature(chip, &val->intval);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		ret = regmap_read(map, MAX17042_TALRT_Th, &data);
> +		if (ret < 0)
> +			return ret;
> +		/* LSB is Alert Minimum. In deci-centigrade */
> +		val->intval = (data & 0xff) * 10;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		ret = regmap_read(map, MAX17042_TALRT_Th, &data);
> +		if (ret < 0)
> +			return ret;
> +		/* MSB is Alert Maximum. In deci-centigrade */
> +		val->intval = (data >> 8) * 10;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MIN:
> +		val->intval = chip->pdata->temp_min;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MAX:
> +		val->intval = chip->pdata->temp_max;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret = max17042_get_battery_health(chip, &val->intval);
>  		if (ret < 0)
>  			return ret;
> -
> -		val->intval = data;
> -		/* The value is signed. */
> -		if (val->intval & 0x8000) {
> -			val->intval = (0x7fff & ~val->intval) + 1;
> -			val->intval *= -1;
> -		}
> -		/* The value is converted into deci-centigrade scale */
> -		/* Units of LSB = 1 / 256 degree Celsius */
> -		val->intval = val->intval * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		if (chip->pdata->enable_current_sense) { @@ -237,6 +338,69
> @@ static int max17042_get_property(struct power_supply *psy,
>  	return 0;
>  }
> 
> +static int max17042_set_property(struct power_supply *psy,
> +			    enum power_supply_property psp,
> +			    const union power_supply_propval *val) {
> +	struct max17042_chip *chip = power_supply_get_drvdata(psy);
> +	struct regmap *map = chip->regmap;
> +	int ret = 0;
> +	u32 data;
> +	int8_t temp;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		ret = regmap_read(map, MAX17042_TALRT_Th, &data);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Input in deci-centigrade, convert to centigrade */
> +		temp = val->intval / 10;
> +		/* force min < max */
> +		if (temp >= (int8_t)(data >> 8))
> +			temp = (int8_t)(data >> 8) - 1;
> +		/* Write both MAX and MIN ALERT */
> +		data = (data & 0xff00) + temp;
> +		ret = regmap_write(map, MAX17042_TALRT_Th, data);
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		ret = regmap_read(map, MAX17042_TALRT_Th, &data);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Input in Deci-Centigrade, convert to centigrade */
> +		temp = val->intval / 10;
> +		/* force max > min */
> +		if (temp <= (int8_t)(data & 0xff))
> +			temp = (int8_t)(data & 0xff) + 1;
> +		/* Write both MAX and MIN ALERT */
> +		data = (data & 0xff) + (temp << 8);
> +		ret = regmap_write(map, MAX17042_TALRT_Th, data);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int max17042_property_is_writeable(struct power_supply *psy,
> +		enum power_supply_property psp)
> +{
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		ret = 1;
> +		break;
> +	default:
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)  {
>  	int retries = 8;
> @@ -665,6 +829,8 @@ static const struct power_supply_desc
> max17042_psy_desc = {
>  	.name		= "max170xx_battery",
>  	.type		= POWER_SUPPLY_TYPE_BATTERY,
>  	.get_property	= max17042_get_property,
> +	.set_property	= max17042_set_property,
> +	.property_is_writeable	= max17042_property_is_writeable,
>  	.properties	= max17042_battery_props,
>  	.num_properties	= ARRAY_SIZE(max17042_battery_props),
>  };
> @@ -673,6 +839,8 @@ static const struct power_supply_desc
> max17042_no_current_sense_psy_desc = {
>  	.name		= "max170xx_battery",
>  	.type		= POWER_SUPPLY_TYPE_BATTERY,
>  	.get_property	= max17042_get_property,
> +	.set_property	= max17042_set_property,
> +	.property_is_writeable	= max17042_property_is_writeable,
>  	.properties	= max17042_battery_props,
>  	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
>  };
> diff --git a/include/linux/power/max17042_battery.h
> b/include/linux/power/max17042_battery.h
> index cf112b4..522757a 100644
> --- a/include/linux/power/max17042_battery.h
> +++ b/include/linux/power/max17042_battery.h
> @@ -215,6 +215,10 @@ struct max17042_platform_data {
>  	 * the datasheet although it can be changed by board designers.
>  	 */
>  	unsigned int r_sns;
> +	int         vmin;	/* in millivolts */
> +	int         vmax;	/* in millivolts */
> +	int         temp_min;	/* in tenths of degree Celsius */
> +	int         temp_max;	/* in tenths of degree Celsius */
>  };
> 
>  #endif /* __MAX17042_BATTERY_H_ */
> --
> 1.7.9.5

Thanks,
Ram
