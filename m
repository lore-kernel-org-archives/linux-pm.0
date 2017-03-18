From: Liam Breck <liam@networkimprov.net>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset pdata flag
Date: Sat, 18 Mar 2017 00:10:13 -0700
Message-ID: <20170318071019.4561-1-liam@networkimprov.net>
References: <20170317095527.10487-5-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33306 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdCRHK5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2017 03:10:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id p189so5421420pfp.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2017 00:10:56 -0700 (PDT)
In-Reply-To: <20170317095527.10487-5-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

[dropped CC's not relevant to BQ24190; pls re-add anyone appropriate]

Hi Hans,

I am the de facto maintainer of BQ24190, with help from Tony. I contracted the original author to 
create the driver. I'm not aware of anyone else relying on it at present.

Pls rebase to -next (!) and post BQ24190 changes in a separate patchset. Reference any 
dependencies in other patchsets with Depends-on lines in patch descriptions linking to 
patchwork.kernel.org. If any dependency might be controversial, pls defer the BQ24190 patchset til 
controversy resolves.

You may be interested in these, which I will support in BQ24190 in near future:
https://patchwork.kernel.org/patch/9626487/
https://patchwork.kernel.org/patch/9626491/

Further comments below...

On Fri, 17 Mar 2017 10:55:16 +0100, Hans de Goede wrote:

> On some platforms the register have been setup with platform specific
> values by the firmware and should not be reset.

Pls describe this mysterious, meddling firmware. Who wrote it, when does it run, on what devices, 
etc? Include URLs to docs, etc. BTW it's not really "firmware" if it runs on the main cpu, IMO. 
A boot loader is not firmware.

We probably don't want to disable register_reset in all circumstances. Can you record the 
firmware's settings for charger? I suspect we should replay them in set_mode_host() -- to be 
renamed set_operating_params in forthcoming patchset.

What generates your platform_data objects?
Are you forced to use platform_data for some reason?

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Add to all BQ24190 patches:
Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>

Pls don't CC me on the related patchsets.

> ---
>  drivers/power/supply/bq24190_charger.c | 5 +++++
>  include/linux/power/bq24190_charger.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index a4f0849..c92a40e4 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -151,6 +151,7 @@ struct bq24190_dev_info {
>  	struct device			*dev;
>  	struct power_supply		*charger;
>  	struct power_supply		*battery;
> +	struct bq24190_platform_data	*pdata;

Use a register settings array/struct here, instead of platform-data. None of your other patches need 
to retain pdata.

>  	char				model_name[I2C_NAME_SIZE];
>  	kernel_ulong_t			model;
>  	unsigned int			gpio_int;
> @@ -506,6 +507,9 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>  	int ret, limit = 100;
>  	u8 v;
>  
> +	if (bdi->pdata && bdi->pdata->no_register_reset)
> +		return 0;
> +
>  	/* Reset the registers */
>  	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>  			BQ24190_REG_POC_RESET_MASK,
> @@ -1339,6 +1343,7 @@ static int bq24190_probe(struct i2c_client *client,
>  	bdi->client = client;
>  	bdi->dev = dev;
>  	bdi->model = id->driver_data;
> +	bdi->pdata = client->dev.platform_data;
>  	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
>  	mutex_init(&bdi->f_reg_lock);
>  	bdi->f_reg = 0;
> diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/bq24190_charger.h
> index 9f02837..cb49717 100644
> --- a/include/linux/power/bq24190_charger.h
> +++ b/include/linux/power/bq24190_charger.h
> @@ -11,6 +11,7 @@
>  
>  struct bq24190_platform_data {
>  	unsigned int	gpio_int;	/* GPIO pin that's connected to INT# */
> +	bool no_register_reset;
>  };
>  
>  #endif

Thanks,
Liam
