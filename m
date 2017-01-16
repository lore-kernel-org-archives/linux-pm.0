From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v2 3/6] power: bq24190_charger: Install
 irq_handler_thread() at end of probe()
Date: Mon, 16 Jan 2017 11:03:13 -0700
Message-ID: <20170116180313.GD27262@animalcreek.com>
References: <CAKvHMgQdqLBiyzJ3R-vcobhH5sCGPvu2CWxwBqMx=6Qwg6mnmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51794 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750848AbdAPSDP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 13:03:15 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgQdqLBiyzJ3R-vcobhH5sCGPvu2CWxwBqMx=6Qwg6mnmg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Sun, Jan 15, 2017 at 10:07:48PM -0800, Liam Breck wrote:
> 

> The device specific data is not fully initialized on
> request_threaded_irq(). This may cause a crash when the IRQ handler
> tries to reference them.
> 
> Fix the issue by installing IRQ handler at the end of the probe.
> 
> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq24190_charger.c | 35 ++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index b51eac1..54c8952 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c

>  out4:
> -	power_supply_unregister(bdi->battery);
> +	bq24190_sysfs_remove_group(bdi);
> +
>  out3:
> -	power_supply_unregister(bdi->charger);
> +	power_supply_unregister(bdi->battery);
> +
>  out2:
> -	pm_runtime_disable(dev);
> +	power_supply_unregister(bdi->charger);
> +
>  out1:
> +	pm_runtime_disable(dev);
>  	if (bdi->gpio_int)
>  		gpio_free(bdi->gpio_int);
> -
>  	return ret;
>  }

I don't like the reformatting that you did here and even if I did, it
should be done in a separate patch.  But, its minor so...

Acked-by: Mark Greer <mgreer@animalcreek.com>
