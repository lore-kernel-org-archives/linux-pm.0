From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 5/7] power: bq24190_charger: Reorder init sequence in
 probe()
Date: Wed, 22 Mar 2017 13:14:40 +0100
Message-ID: <7d826cba-8d4a-4c09-0865-1c042edb552a@redhat.com>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-6-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934256AbdCVMYs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 08:24:48 -0400
In-Reply-To: <20170321220921.5834-6-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 21-03-17 23:09, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> We need a struct power_supply object from register() before
> calling setup_dt()
>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/power/supply/bq24190_charger.c | 37 +++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index ad09e48..2fbc7f3 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1386,16 +1386,6 @@ static int bq24190_probe(struct i2c_client *client,
>
>  	i2c_set_clientdata(client, bdi);
>
> -	if (dev->of_node)
> -		ret = bq24190_setup_dt(bdi);
> -	else
> -		ret = bq24190_setup_pdata(bdi, pdata);
> -
> -	if (ret) {
> -		dev_err(dev, "Can't get irq info\n");
> -		return -EINVAL;
> -	}
> -
>  	pm_runtime_enable(dev);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_autosuspend_delay(dev, 600);
> @@ -1405,12 +1395,6 @@ static int bq24190_probe(struct i2c_client *client,
>  		goto out1;
>  	}
>
> -	ret = bq24190_hw_init(bdi);
> -	if (ret < 0) {
> -		dev_err(dev, "Hardware init failed\n");
> -		goto out2;
> -	}
> -
>  	charger_cfg.drv_data = bdi;
>  	charger_cfg.supplied_to = bq24190_charger_supplied_to;
>  	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to),
> @@ -1431,6 +1415,23 @@ static int bq24190_probe(struct i2c_client *client,
>  		goto out3;
>  	}
>
> +	if (dev->of_node)
> +		ret = bq24190_setup_dt(bdi);
> +	else
> +		ret = bq24190_setup_pdata(bdi, pdata);
> +
> +	if (ret) {
> +		dev_err(dev, "Can't get irq info\n");
> +		ret = -EINVAL;
> +		goto out4;
> +	}
> +
> +	ret = bq24190_hw_init(bdi);
> +	if (ret < 0) {
> +		dev_err(dev, "Hardware init failed\n");
> +		goto out4;
> +	}
> +
>  	ret = bq24190_sysfs_create_group(bdi);
>  	if (ret) {
>  		dev_err(dev, "Can't create sysfs entries\n");
> @@ -1459,6 +1460,8 @@ static int bq24190_probe(struct i2c_client *client,
>  	bq24190_sysfs_remove_group(bdi);
>
>  out4:
> +	if (bdi->gpio_int)
> +		gpio_free(bdi->gpio_int);
>  	power_supply_unregister(bdi->battery);
>
>  out3:
> @@ -1470,8 +1473,6 @@ static int bq24190_probe(struct i2c_client *client,
>  out1:
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
> -	if (bdi->gpio_int)
> -		gpio_free(bdi->gpio_int);
>  	return ret;
>  }
>
>
