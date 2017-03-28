From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] power: bq24190_charger: Uniform pm_runtime_get() failure
 handling
Date: Tue, 28 Mar 2017 13:49:49 +0200
Message-ID: <ad5be5ae-c204-d6b4-ff57-61cf07e8a805@redhat.com>
References: <20170328100128.25512-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751430AbdC1LuM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Mar 2017 07:50:12 -0400
In-Reply-To: <20170328100128.25512-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 28-03-17 12:01, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> On pm_runtime_get() failure, always emit an error message.
> Prevent unbalanced pm_runtime_get by calling:
>   pm_runtime_put_noidle() in irq handler
>   pm_runtime_put_sync() on any probe() failure
> Rename probe() out labels instead of renumbering them.
>
> Fixes: 13d6fa8447fa power: bq24190_charger: Use PM runtime autosuspend
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/power/supply/bq24190_charger.c | 41 ++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 64a48b9..cf7557f 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1278,12 +1278,13 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>  {
>  	struct bq24190_dev_info *bdi = data;
> -	int ret;
> +	int error;
>
>  	bdi->irq_event = true;
> -	ret = pm_runtime_get_sync(bdi->dev);
> -	if (ret < 0) {
> -		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
> +	error = pm_runtime_get_sync(bdi->dev);
> +	if (error < 0) {
> +		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> +		pm_runtime_put_noidle(bdi->dev);
>  		return IRQ_NONE;
>  	}
>  	bq24190_check_status(bdi);
> @@ -1447,13 +1448,15 @@ static int bq24190_probe(struct i2c_client *client,
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_autosuspend_delay(dev, 600);
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> -		goto out1;
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get failed: %i\n", ret);
> +		goto out_pmrt;
> +	}
>
>  	ret = bq24190_hw_init(bdi);
>  	if (ret < 0) {
>  		dev_err(dev, "Hardware init failed\n");
> -		goto out2;
> +		goto out_pmrt;
>  	}
>
>  	charger_cfg.drv_data = bdi;
> @@ -1464,7 +1467,7 @@ static int bq24190_probe(struct i2c_client *client,
>  	if (IS_ERR(bdi->charger)) {
>  		dev_err(dev, "Can't register charger\n");
>  		ret = PTR_ERR(bdi->charger);
> -		goto out2;
> +		goto out_pmrt;
>  	}
>
>  	battery_cfg.drv_data = bdi;
> @@ -1473,13 +1476,13 @@ static int bq24190_probe(struct i2c_client *client,
>  	if (IS_ERR(bdi->battery)) {
>  		dev_err(dev, "Can't register battery\n");
>  		ret = PTR_ERR(bdi->battery);
> -		goto out3;
> +		goto out_charger;
>  	}
>
>  	ret = bq24190_sysfs_create_group(bdi);
>  	if (ret) {
>  		dev_err(dev, "Can't create sysfs entries\n");
> -		goto out4;
> +		goto out_battery;
>  	}
>
>  	bdi->initialized = true;
> @@ -1490,7 +1493,7 @@ static int bq24190_probe(struct i2c_client *client,
>  			"bq24190-charger", bdi);
>  	if (ret < 0) {
>  		dev_err(dev, "Can't set up irq handler\n");
> -		goto out5;
> +		goto out_sysfs;
>  	}
>
>  	if (bdi->extcon) {
> @@ -1498,8 +1501,10 @@ static int bq24190_probe(struct i2c_client *client,
>  		bdi->extcon_nb.notifier_call = bq24190_extcon_event;
>  		ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
>  						    &bdi->extcon_nb);
> -		if (ret)
> -			goto out5;
> +		if (ret) {
> +			dev_err(dev, "Can't register extcon\n");
> +			goto out_sysfs;
> +		}
>
>  		/* Sync initial cable state */
>  		queue_delayed_work(system_wq, &bdi->extcon_work, 0);
> @@ -1512,19 +1517,17 @@ static int bq24190_probe(struct i2c_client *client,
>
>  	return 0;
>
> -out5:
> +out_sysfs:
>  	bq24190_sysfs_remove_group(bdi);
>
> -out4:
> +out_battery:
>  	power_supply_unregister(bdi->battery);
>
> -out3:
> +out_charger:
>  	power_supply_unregister(bdi->charger);
>
> -out2:
> +out_pmrt:
>  	pm_runtime_put_sync(dev);
> -
> -out1:
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	return ret;
>
