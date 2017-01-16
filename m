From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v2 4/6] power: bq24190_charger: Call
 power_supply_changed() for relevant component
Date: Mon, 16 Jan 2017 11:31:25 -0700
Message-ID: <20170116183125.GE27262@animalcreek.com>
References: <CAKvHMgQHAfRUVp8ka_Y_h0TC97U6euMrq1+Fy5+zq510jpoaOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37391 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750826AbdAPSbd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 13:31:33 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgQHAfRUVp8ka_Y_h0TC97U6euMrq1+Fy5+zq510jpoaOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Sun, Jan 15, 2017 at 10:08:04PM -0800, Liam Breck wrote:
> 

> We wrongly get uevents for bq24190-charger and bq24190-battery on every
> register change.
> 
> Fix by checking the association with charger and battery before
> emitting uevent(s).
> 
> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq24190_charger.c | 50 +++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 62194d8..ba5a5b2 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c

> @@ -1225,8 +1227,12 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>  					ret);
>  		}
>  
> +		if ((bdi->ss_reg & battery_mask_ss) != (ss_reg & battery_mask_ss))
> +			alert_battery = true;
> +		if ((bdi->ss_reg & ~battery_mask_ss) != (ss_reg & ~battery_mask_ss))

Lines are > 80 characters. Please break up.

The rest looks good.

Mark
--
