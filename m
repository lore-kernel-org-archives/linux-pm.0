From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 00:37:17 -0700
Message-ID: <20090604003717.b6941159.akpm__36613.2273724817$1244101098$gmane$org@linux-foundation.org>
References: <4A25DB40.6010904@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A25DB40.6010904@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: kyungmin.park@samsung.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>
List-Id: linux-pm@vger.kernel.org

On Wed, 03 Jun 2009 11:09:04 +0900 Minkyu Kang <mk7.kang@samsung.com> wrote:

> The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-ion batteries
> This patch adds support the MAX17040 Fuel Gauge
> 
> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> ---
>  drivers/power/Kconfig            |    8 +
>  drivers/power/Makefile           |    3 +-
>  drivers/power/max17040_battery.c |  304 ++++++++++++++++++++++++++++++++++++++
>  include/linux/max17040_battery.h |   19 +++

Please Cc Anton Vorontsov <cbou@mail.ru> on drivers/power patches.

>
> ...
>
> +static int __devinit max17040_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct max17040_chip *chip;
> +	int ret;
> +
> +	chip = kzalloc(sizeof(struct max17040_chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client = client;
> +	pdata = client->dev.platform_data;
> +
> +	i2c_set_clientdata(client, chip);
> +	max17040 = chip;
> +
> +	max17040_reset();
> +
> +	max17040_get_version();
> +
> +	INIT_DELAYED_WORK_DEFERRABLE(&chip->work, max17040_work);
> +	schedule_delayed_work(&chip->work, MAX17040_DELAY);
> +
> +	bat_ps.properties = max17040_battery_props;
> +	bat_ps.num_properties = ARRAY_SIZE(max17040_battery_props);
> +
> +	ret = power_supply_register(&client->dev, &bat_ps);
> +	if (ret) {
> +		dev_err(&max17040->client->dev,
> +				"failed: power supply register\n");
> +		kfree(chip);
> +		max17040 = NULL;
> +		i2c_set_clientdata(client, NULL);
> +		return -1;

This leaves the delayed work still pending.

> +	}
> +
> +	return 0;
> +}
> +
> +static int __devexit max17040_remove(struct i2c_client *client)
> +{
> +	struct max17040_chip *chip = i2c_get_clientdata(client);
> +
> +	kfree(chip);
> +	max17040 = NULL;
> +	i2c_set_clientdata(client, NULL);
> +	power_supply_unregister(&bat_ps);
> +	return 0;
> +}

Shouldn't max17040_remove() also cancel the delayed_work?

> +static int max17040_suspend(struct i2c_client *client,
> +		pm_message_t state)
> +{
> +	struct max17040_chip *chip = i2c_get_clientdata(client);
> +
> +	cancel_delayed_work(&chip->work);
> +	return 0;
> +}
> +
> +static int max17040_resume(struct i2c_client *client)
> +{
> +	struct max17040_chip *chip = i2c_get_clientdata(client);
> +
> +	schedule_delayed_work(&chip->work, MAX17040_DELAY);
> +	return 0;
> +}
