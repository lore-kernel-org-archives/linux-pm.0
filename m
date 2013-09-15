From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 06/16] hwmon: tmp102: expose to thermal fw via DT nodes
Date: Sun, 15 Sep 2013 16:33:40 -0700
Message-ID: <523643D4.30208@roeck-us.net>
References: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com> <1379282563-14650-7-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379282563-14650-7-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 09/15/2013 03:02 PM, Eduardo Valentin wrote:
> This patch adds to tmp102 temperature sensor the possibility
> to expose itself as thermal zone device, registered on the
> thermal framework.
>
> The thermal zone is built only if a device tree node
> describing a thermal zone for this sensor is present
> inside the tmp102 DT node. Otherwise, the driver behavior
> will be the same.
>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/hwmon/tmp102.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index d7b47ab..e432444 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -27,6 +27,8 @@
>   #include <linux/mutex.h>
>   #include <linux/device.h>
>   #include <linux/jiffies.h>
> +#include <linux/thermal.h>
> +#include <linux/of.h>
>
>   #define	DRIVER_NAME "tmp102"
>
> @@ -50,6 +52,7 @@
>
>   struct tmp102 {
>   	struct device *hwmon_dev;
> +	struct thermal_zone_device *tz;
>   	struct mutex lock;
>   	u16 config_orig;
>   	unsigned long last_update;
> @@ -93,6 +96,19 @@ static struct tmp102 *tmp102_update_device(struct i2c_client *client)
>   	return tmp102;
>   }
>
> +static int tmp102_read_temp(void *dev, long *temp)
> +{
> +	struct tmp102 *tmp102 = tmp102_update_device(to_i2c_client(dev));
> +
> +	if (tmp102->temp[0] < 0)
> +		dev_warn(tmp102->hwmon_dev,
> +			 "operating in negative temp: %d\n", tmp102->temp[0]);
> +

Please drop this warning.

Guenter

> +	*temp = tmp102->temp[0];
> +
> +	return 0;
> +}
> +
>   static ssize_t tmp102_show_temp(struct device *dev,
>   				struct device_attribute *attr,
>   				char *buf)
> @@ -204,6 +220,16 @@ static int tmp102_probe(struct i2c_client *client,
>   		goto fail_remove_sysfs;
>   	}
>
> +	tmp102->tz = thermal_zone_of_sensor_register(&client->dev, 0,
> +						     &client->dev,
> +						     tmp102_read_temp, NULL);
> +	if (IS_ERR(tmp102->tz)) {
> +		dev_warn(&client->dev,
> +			 "Could not parse thermal data in device tree: %ld\n",
> +			 PTR_ERR(tmp102->tz));

Please drop this warning. You already create error messages in
thermal_zone_of_sensor_register(). That should be sufficient.
The same applies to the lm75 patch.

As a side note, I would suggest to provide devm_ functions for registration.
We are introducing those for hwmon registration, which enables us to remove
most _remove functions. It would be great if we can keep it that way.

On a higher level, I don't think it is a good idea to make thermal zones
and thermal zone data mandatory. Many systems may neither need nor want it.

Guenter

> +		tmp102->tz = NULL;
> +	}
> +
>   	dev_info(&client->dev, "initialized\n");
>
>   	return 0;
> @@ -220,6 +246,8 @@ static int tmp102_remove(struct i2c_client *client)
>   {
>   	struct tmp102 *tmp102 = i2c_get_clientdata(client);
>
> +	/* thermal zone life cycle is not our responsibility */
> +	thermal_zone_of_sensor_unregister(&client->dev, tmp102->tz);
>   	hwmon_device_unregister(tmp102->hwmon_dev);
>   	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
