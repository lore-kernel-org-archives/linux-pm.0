From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Sun, 2 Aug 2015 08:53:43 +0200
Message-ID: <20150802065343.GA32270@amd>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150724115813.GA3004@vaishali-Ideapad-Z570>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2015-07-24 17:28:13, Vaishali Thakkar wrote:
> Use devm_kasprintf instead of kasprintf. Also, remove various
> gotos by direct returns and drop unneeded label err_free_name.

What happens if some /sys file is still open when the device is
removed?



> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
>  drivers/power/bq24735-charger.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
> index b017437..b2bb67e 100644
> --- a/drivers/power/bq24735-charger.c
> +++ b/drivers/power/bq24735-charger.c
> @@ -267,8 +267,9 @@ static int bq24735_charger_probe(struct i2c_client *client,
>  
>  	name = (char *)charger->pdata->name;
>  	if (!name) {
> -		name = kasprintf(GFP_KERNEL, "bq24735@%s",
> -				 dev_name(&client->dev));
> +		name = devm_kasprintf(&client->dev, GFP_KERNEL,
> +				      "bq24735@%s",
> +				      dev_name(&client->dev));
>  		if (!name) {
>  			dev_err(&client->dev, "Failed to alloc device name\n");
>  			return -ENOMEM;
> @@ -296,23 +297,21 @@ static int bq24735_charger_probe(struct i2c_client *client,
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to read manufacturer id : %d\n",
>  			ret);
> -		goto err_free_name;
> +		return ret;
>  	} else if (ret != 0x0040) {
>  		dev_err(&client->dev,
>  			"manufacturer id mismatch. 0x0040 != 0x%04x\n", ret);
> -		ret = -ENODEV;
> -		goto err_free_name;
> +		return -ENODEV;
>  	}
>  
>  	ret = bq24735_read_word(client, BQ24735_DEVICE_ID);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to read device id : %d\n", ret);
> -		goto err_free_name;
> +		return ret;
>  	} else if (ret != 0x000B) {
>  		dev_err(&client->dev,
>  			"device id mismatch. 0x000b != 0x%04x\n", ret);
> -		ret = -ENODEV;
> -		goto err_free_name;
> +		return -ENODEV;
>  	}
>  
>  	if (gpio_is_valid(charger->pdata->status_gpio)) {
> @@ -331,7 +330,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
>  	ret = bq24735_config_charger(charger);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "failed in configuring charger");
> -		goto err_free_name;
> +		return ret;
>  	}
>  
>  	/* check for AC adapter presence */
> @@ -339,7 +338,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
>  		ret = bq24735_enable_charging(charger);
>  		if (ret < 0) {
>  			dev_err(&client->dev, "Failed to enable charging\n");
> -			goto err_free_name;
> +			return ret;
>  		}
>  	}
>  
> @@ -349,7 +348,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
>  		ret = PTR_ERR(charger->charger);
>  		dev_err(&client->dev, "Failed to register power supply: %d\n",
>  			ret);
> -		goto err_free_name;
> +		return ret;
>  	}
>  
>  	if (client->irq) {
> @@ -371,10 +370,6 @@ static int bq24735_charger_probe(struct i2c_client *client,
>  	return 0;
>  err_unregister_supply:
>  	power_supply_unregister(charger->charger);
> -err_free_name:
> -	if (name != charger->pdata->name)
> -		kfree(name);
> -
>  	return ret;
>  }
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
