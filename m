From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] power: bq24190_charger: Limit over/under voltage fault
 logging
Date: Sat, 25 Mar 2017 12:17:25 +0100
Message-ID: <f3a54b7d-0ffb-3131-5f4b-145782c66e82@redhat.com>
References: <20170324102955.13808-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdCYLSd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Mar 2017 07:18:33 -0400
In-Reply-To: <20170324102955.13808-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 24-03-17 11:29, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> If the charger gets unplugged before the battery is fully charged we will
> get an over/under voltage fault. Ignore this rather then logging a message for
> it. Likewise on the next interrupt after the fault all fault flags will be 0,
> do not log a message when there are no faults.
>
> This fixes messages like these getting logged on charger unplug + replug:
> bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
> bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0
>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Sebastian, here is a replacement for the original version.
> I include Hans' sign-off since he wrote the original.

I can confirm that this still silences the log messages
on charger plug / unplug for me:

Acked-and-tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>
>  drivers/power/supply/bq24190_charger.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 897491d..2e734ab 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1257,12 +1257,15 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  	} while (f_reg && ++i < 2);
>
>  	if (f_reg != bdi->f_reg) {
> -		dev_info(bdi->dev,
> -			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
> -			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
> -			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
> -			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
> -			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
> +		if (f_reg && ((ss_reg & BQ24190_REG_SS_PG_STAT_MASK) ||
> +		    f_reg != (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT)))
> +			/* omit over/under voltage fault after disconnect */
> +			dev_warn(bdi->dev,
> +				"Fault: boost %d, charge %d, battery %d, ntc %d\n",
> +				!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
> +				!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
> +				!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
> +				!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
>
>  		mutex_lock(&bdi->f_reg_lock);
>  		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
>
