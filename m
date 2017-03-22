From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 4/7] power: bq24190_charger: Uniform pm_runtime_get()
 failure handling
Date: Wed, 22 Mar 2017 08:35:37 -0700
Message-ID: <20170322153536.GR8575@atomide.com>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41112 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934120AbdCVPfm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:35:42 -0400
Content-Disposition: inline
In-Reply-To: <20170321220921.5834-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170321 15:11]:
> From: Liam Breck <kernel@networkimprov.net>
> 
> On pm_runtime_get() failure, always emit error message,
> and call pm_runtime_put_noidle() in irq handler.
> 
> Fixes: 13d6fa8447fa power: bq24190_charger: Use PM runtime autosuspend

Not sure if this fixes anything? If it does the description
should say what it fixes.

Other than that, looks OK:

Acked-by: Tony Lindgren <tony@atomide.com>

> Cc: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq24190_charger.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index c443988..ad09e48 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1267,12 +1267,13 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
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
> @@ -1399,8 +1400,10 @@ static int bq24190_probe(struct i2c_client *client,
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_autosuspend_delay(dev, 600);
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get failed: %i\n", ret);
>  		goto out1;
> +	}
>  
>  	ret = bq24190_hw_init(bdi);
>  	if (ret < 0) {
> -- 
> 2.9.3
> 
