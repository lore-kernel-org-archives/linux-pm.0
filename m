From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH] power: supply: sbs-battery: simplify DT parsing
Date: Mon, 19 Sep 2016 17:20:37 +0800
Message-ID: <d7135816-c6e0-be6b-d775-0f77f0056dc0@electromag.com.au>
References: <20160906131643.1930011-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:55164 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752711AbcISJUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 05:20:45 -0400
In-Reply-To: <20160906131643.1930011-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>
Cc: YH Huang <yh.huang@mediatek.com>, Joshua Clayton <stillcompiling@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

G'day Arnd,

Sorry for the delay.
Been distracted and just catching up on mail I was just getting back to
implementing basically this same thing as requested by Sebastian when I saw your change.

Couple of comments below, I haven't tested it.


On 6/09/2016 21:16, Arnd Bergmann wrote:
> After the change to use the gpio descriptor interface, we get a warning if
> -Wmaybe-uninitialized is added back to the build flags (it is currently
> disabled:
>
> drivers/power/supply/sbs-battery.c: In function 'sbs_probe':
> drivers/power/supply/sbs-battery.c:760:28: error: 'pdata' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> The problem is that if neither the DT properties nor a platform_data
> pointer are provided, the chip->pdata pointer gets set to an uninitialized
> value.
>
> Looking at the code some more, I found that the sbs_of_populate_pdata
> function is more complex than necessary and has confusing calling
> conventions of possibly returning a valid pointer, a NULL pointer
> or an ERR_PTR pointer (in addition to the uninitialized pointer).
>
> To fix all of that, this gets rid of the chip->pdata pointer and
> simply moves the two integers into the sbs_info structure. This
> makes it much clearer from reading sbs_probe() what the precedence
> of the three possible values are (pdata, DT, hardcoded defaults)
> and completely avoids the #ifdef CONFIG_OF guards as
> of_property_read_u32() gets replaced with a compile-time stub
> when that is disabled, and returns an error if passed a NULL of_node
> pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 3b5dd3a49496 ("power: supply: sbs-battery: Use gpio_desc and sleeping calls for battery detect")
> ---
>  drivers/power/supply/sbs-battery.c | 98 ++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 8b4c6a8681b0..248a5dd75e22 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -169,6 +169,8 @@ struct sbs_info {
>  	bool				enable_detection;
>  	int				last_state;
>  	int				poll_time;
> +	int				i2c_retry_count;
> +	int				poll_retry_count;
>  	struct delayed_work		work;
>  	int				ignore_changes;
>  };
Done we need to remove pdata from here now. It's not set in the probe funciton anymore.

> @@ -184,7 +186,7 @@ static int sbs_read_word_data(struct i2c_client *client, u8 address)
>  	int retries = 1;
>
>  	if (chip->pdata)
> -		retries = max(chip->pdata->i2c_retry_count + 1, 1);
> +		retries = max(chip->i2c_retry_count + 1, 1);
I don't think this is quite right. as pdata is never set, condition needs to removed.

>
>  	while (retries > 0) {
>  		ret = i2c_smbus_read_word_data(client, address);
> @@ -212,8 +214,8 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
>  	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
>
>  	if (chip->pdata) {
> -		retries_length = max(chip->pdata->i2c_retry_count + 1, 1);
> -		retries_block = max(chip->pdata->i2c_retry_count + 1, 1);
> +		retries_length = max(chip->i2c_retry_count + 1, 1);
> +		retries_block = max(chip->i2c_retry_count + 1, 1);
>  	}
ditto

>
>  	/* Adapter needs to support these two functions */
> @@ -279,7 +281,7 @@ static int sbs_write_word_data(struct i2c_client *client, u8 address,
>  	int retries = 1;
>
>  	if (chip->pdata)
> -		retries = max(chip->pdata->i2c_retry_count + 1, 1);
> +		retries = max(chip->i2c_retry_count + 1, 1);
ditto
>
>  	while (retries > 0) {
>  		ret = i2c_smbus_write_word_data(client, address,
> @@ -741,61 +743,6 @@ static void sbs_delayed_work(struct work_struct *work)
>  	}
>  }
>
> -#if defined(CONFIG_OF)
> -
> -#include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> -
> -static const struct of_device_id sbs_dt_ids[] = {
> -	{ .compatible = "sbs,sbs-battery" },
> -	{ .compatible = "ti,bq20z75" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> -
> -static struct sbs_platform_data *sbs_of_populate_pdata(struct sbs_info *chip)
> -{
> -	struct i2c_client *client = chip->client;
> -	struct device_node *of_node = client->dev.of_node;
> -	struct sbs_platform_data *pdata;
> -	int rc;
> -	u32 prop;
> -
> -	/* verify this driver matches this device */
> -	if (!of_node)
> -		return NULL;
> -
> -	/* first make sure at least one property is set, otherwise
> -	 * it won't change behavior from running without pdata.
> -	 */
> -	if (!of_get_property(of_node, "sbs,i2c-retry-count", NULL) &&
> -	    !of_get_property(of_node, "sbs,poll-retry-count", NULL))
> -		goto of_out;
> -
> -	pdata = devm_kzalloc(&client->dev, sizeof(struct sbs_platform_data),
> -				GFP_KERNEL);
> -	if (!pdata)
> -		return ERR_PTR(-ENOMEM);
> -
> -	rc = of_property_read_u32(of_node, "sbs,i2c-retry-count", &prop);
> -	if (!rc)
> -		pdata->i2c_retry_count = prop;
> -
> -	rc = of_property_read_u32(of_node, "sbs,poll-retry-count", &prop);
> -	if (!rc)
> -		pdata->poll_retry_count = prop;
> -
> -of_out:
> -	return pdata;
> -}
> -#else
> -static struct sbs_platform_data *sbs_of_populate_pdata(
> -	struct sbs_info *client)
> -{
> -	return ERR_PTR(-ENOSYS);
> -}
> -#endif
> -
>  static const struct power_supply_desc sbs_default_desc = {
>  	.type = POWER_SUPPLY_TYPE_BATTERY,
>  	.properties = sbs_properties,
> @@ -838,13 +785,23 @@ static int sbs_probe(struct i2c_client *client,
>  	chip->ignore_changes = 1;
>  	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
>
> -	if (!pdata)
> -		pdata = sbs_of_populate_pdata(chip);
> -
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -
> -	chip->pdata = pdata;
No longer set here.

> +	/* use pdata if available, fall back to DT properties,
> +	 * or hardcoded defaults if not
> +	 */
> +	rc = of_property_read_u32(client->dev.of_node, "sbs,i2c-retry-count",
> +				  &chip->i2c_retry_count);
> +	if (rc)
> +		chip->i2c_retry_count = 1;
> +
> +	rc = of_property_read_u32(client->dev.of_node, "sbs,poll-retry-count",
> +				  &chip->poll_retry_count);
> +	if (rc)
> +		chip->poll_retry_count = 0;
> +
> +	if (pdata) {
> +		chip->poll_retry_count = pdata->poll_retry_count;
> +		chip->i2c_retry_count  = pdata->i2c_retry_count;
> +	}
>
>  	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
>  			"sbs,battery-detect", GPIOD_IN);
> @@ -953,13 +910,20 @@ static const struct i2c_device_id sbs_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, sbs_id);
>
> +static const struct of_device_id sbs_dt_ids[] = {
> +	{ .compatible = "sbs,sbs-battery" },
> +	{ .compatible = "ti,bq20z75" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> +
>  static struct i2c_driver sbs_battery_driver = {
>  	.probe		= sbs_probe,
>  	.remove		= sbs_remove,
>  	.id_table	= sbs_id,
>  	.driver = {
>  		.name	= "sbs-battery",
> -		.of_match_table = of_match_ptr(sbs_dt_ids),
> +		.of_match_table = sbs_dt_ids,
>  		.pm	= SBS_PM_OPS,
>  	},
>  };
>


Also sbs_external_power_changed is still referencing chip->pdata->poll_retry_count.
Which I think will result in null pointer dereference now.


-- 
Regards
Phil Reid


