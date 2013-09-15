From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 05/16] hwmon: lm75: expose to thermal fw via DT nodes
Date: Sun, 15 Sep 2013 16:22:06 -0700
Message-ID: <5236411E.6040204@roeck-us.net>
References: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com> <1379282563-14650-6-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379282563-14650-6-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 09/15/2013 03:02 PM, Eduardo Valentin wrote:
> This patch adds to lm75 temperature sensor the possibility
> to expose itself as thermal zone device, registered on the
> thermal framework.
>
> The thermal zone is built only if a device tree node
> describing a thermal zone for this sensor is present
> inside the lm75 DT node. Otherwise, the driver behavior
> will be the same.
>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/hwmon/lm75.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index c03b490..2ba09ef 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -27,6 +27,8 @@
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/err.h>
>   #include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/thermal.h>
>   #include "lm75.h"
>
>
> @@ -70,6 +72,7 @@ static const u8 LM75_REG_TEMP[3] = {
>   /* Each client has this additional data */
>   struct lm75_data {
>   	struct device		*hwmon_dev;
> +	struct thermal_zone_device	*tz;
>   	struct mutex		update_lock;
>   	u8			orig_conf;
>   	u8			resolution;	/* In bits, between 9 and 12 */
> @@ -90,22 +93,42 @@ static struct lm75_data *lm75_update_device(struct device *dev);
>
>   /*-----------------------------------------------------------------------*/
>
> +static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
> +{
> +	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
> +}
> +
>   /* sysfs attributes for hwmon */
>
> +static int lm75_read_temp(void *dev, long *temp)
> +{
> +	struct lm75_data *data = lm75_update_device(dev);
> +	long temperature;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	temperature = lm75_reg_to_mc(data->temp[0], data->resolution);
> +	if (temperature < 0)
> +		dev_warn(data->hwmon_dev,
> +			 "operating in negative temp: %ld\n", temperature);

Please drop this warning. It is not the responsibility of the chip driver
to declare valid operational conditions, much less an arbitrary one
like zero degrees C.

Guenter

> +
> +	*temp = temperature;
> +
> +	return 0;
> +}
> +
>   static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>   			 char *buf)
>   {
>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>   	struct lm75_data *data = lm75_update_device(dev);
> -	long temp;
>
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
>
> -	temp = ((data->temp[attr->index] >> (16 - data->resolution)) * 1000)
> -	       >> (data->resolution - 8);
> -
> -	return sprintf(buf, "%ld\n", temp);
> +	return sprintf(buf, "%ld\n", lm75_reg_to_mc(data->temp[attr->index],
> +						    data->resolution));
>   }
>
>   static ssize_t set_temp(struct device *dev, struct device_attribute *da,
> @@ -271,6 +294,17 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   		goto exit_remove;
>   	}
>
> +	data->tz = thermal_zone_of_sensor_register(&client->dev,
> +						   0,
> +						   &client->dev,
> +						   lm75_read_temp, NULL);
> +	if (IS_ERR(data->tz)) {
> +		dev_warn(&client->dev,
> +			 "Could not parse thermal data in device tree: %ld\n",
> +			 PTR_ERR(data->tz));
> +		data->tz = NULL;
> +	}
> +
>   	dev_info(&client->dev, "%s: sensor '%s'\n",
>   		 dev_name(data->hwmon_dev), client->name);
>
> @@ -285,6 +319,8 @@ static int lm75_remove(struct i2c_client *client)
>   {
>   	struct lm75_data *data = i2c_get_clientdata(client);
>
> +	/* thermal zone life cycle is not our responsibility */
> +	thermal_zone_of_sensor_unregister(&client->dev, data->tz);
>   	hwmon_device_unregister(data->hwmon_dev);
>   	sysfs_remove_group(&client->dev.kobj, &lm75_group);
>   	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
