From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: power: max17040: use devm_kzalloc
Date: Sat, 5 Jan 2013 19:04:24 -0800
Message-ID: <20130106030424.GF6919@lizard.sbx05280.losalca.wayport.net>
References: <CA+C2MxQVdgWn_fjrbiHBDeENHce5FT2xYxYxom84XncQ3bB1nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:49513 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab3AFDH4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Jan 2013 22:07:56 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so8132080dan.23
        for <linux-pm@vger.kernel.org>; Sat, 05 Jan 2013 19:07:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+C2MxQVdgWn_fjrbiHBDeENHce5FT2xYxYxom84XncQ3bB1nQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Devendra Naga <develkernel412222@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On Fri, Dec 07, 2012 at 01:01:06PM +0530, Devendra Naga wrote:
> use devm_kzalloc and no need of error path and unload frees
> 
> Signed-off-by: Devendra Naga <develkernel412222@gmail.com>
> ---

The patch doesn't apply, it is whitespace-damaged...

>  drivers/power/max17040_battery.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/max17040_battery.c
> b/drivers/power/max17040_battery.c
> index 22cfe9c..74a0bd9 100644
> --- a/drivers/power/max17040_battery.c
> +++ b/drivers/power/max17040_battery.c
> @@ -207,7 +207,7 @@ static int max17040_probe(struct i2c_client *client,
>         if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>                 return -EIO;
> 
> -       chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +       chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>         if (!chip)
>                 return -ENOMEM;
> 
> @@ -225,7 +225,6 @@ static int max17040_probe(struct i2c_client *client,
>         ret = power_supply_register(&client->dev, &chip->battery);
>         if (ret) {
>                 dev_err(&client->dev, "failed: power supply register\n");
> -               kfree(chip);
>                 return ret;
>         }
> 
> @@ -244,7 +243,6 @@ static int max17040_remove(struct i2c_client *client)
> 
>         power_supply_unregister(&chip->battery);
>         cancel_delayed_work(&chip->work);
> -       kfree(chip);
>         return 0;
>  }
> 
> -- 
> 1.7.5.4
