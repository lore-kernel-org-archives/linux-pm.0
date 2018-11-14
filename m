From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 13/15] power: supply: olpc_battery: Move priv data to a
 struct
Date: Wed, 14 Nov 2018 18:10:10 +0100
Message-ID: <92612aad296f8204af80573ab99f256c026e3801.camel@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-14-lkundrak@v3.sk> <20181104143743.GF23864@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181104143743.GF23864@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2018-11-04 at 15:37 +0100, Pavel Machek wrote:
> Hi!
> 
> > The global variables for private data are not too nice. I'd like some
> > more, and that would clutter the global name space even further.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Ok...
> 
> > -	olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
> > -	if (IS_ERR(olpc_bat)) {
> > -		ret = PTR_ERR(olpc_bat);
> > -		goto battery_failed;
> > -	}
> > +	data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
> > +	if (IS_ERR(data->olpc_bat))
> > +		return PTR_ERR(data->olpc_bat);
> >  
> > -	ret = device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> > +	ret = device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> >  	if (ret)
> > -		goto eeprom_failed;
> > +		return ret;
> >  
> > -	ret = device_create_file(&olpc_bat->dev, &olpc_bat_error);
> > +	ret = device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
> >  	if (ret)
> >  		goto error_failed;
> >  
> >  	if (olpc_ec_wakeup_available()) {
> > -		device_set_wakeup_capable(&olpc_ac->dev, true);
> > -		device_set_wakeup_capable(&olpc_bat->dev, true);
> > +		device_set_wakeup_capable(&data->olpc_ac->dev, true);
> > +		device_set_wakeup_capable(&data->olpc_bat->dev, true);
> >  	}
> >  
> >  	return 0;
> >  
> >  error_failed:
> > -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> > -eeprom_failed:
> > -	power_supply_unregister(olpc_bat);
> > -battery_failed:
> > -	power_supply_unregister(olpc_ac);
> > +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> >  	return ret;
> >  }
> 
> ...but you are changing error handling here, which is not mentioned in
> the changelog, and I'm nut sure you got it right.
> 
> Are you sure?

I can't see what's wrong. I'll split the priv structure and devm/error
handling changes into two separate patches as you're right they indeed
are somewhat unrelated.

If v2 (tomorrow or so) will still seem wrong to you I'd be thankful if
you could elaborate a bit more.
> 
> >  static int olpc_battery_remove(struct platform_device *pdev)
> >  {
> > -	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
> > -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> > -	power_supply_unregister(olpc_bat);
> > -	power_supply_unregister(olpc_ac);
> > +	struct olpc_battery_data *data = platform_get_drvdata(pdev);
> > +
> > +	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> > +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> >  	return 0;
> >  }
> 
> Here too.
> 									Pavel

Cheers
Lubo
