From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 1/4] power: bq24190_charger: Limit over/under voltage
 fault logging
Date: Thu, 6 Apr 2017 09:12:02 +0200
Message-ID: <43bed26e-ca37-d5a3-2a62-de0fd5221a3c@redhat.com>
References: <20170406031048.12401-1-liam@networkimprov.net>
 <20170406031048.12401-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933548AbdDFHMF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Apr 2017 03:12:05 -0400
In-Reply-To: <20170406031048.12401-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 06-04-17 05:10, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> If the charger is unplugged before the battery is full we may
> see an over/under voltage fault. Ignore this rather then emitting
> a message or uevent.
>
> This prevents messages like these on charger unplug/replug:
> bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
> bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/power/supply/bq24190_charger.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index a699ad3..64a48b9 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1222,8 +1222,13 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  		}
>  	} while (f_reg && ++i < 2);
>
> +	/* ignore over/under voltage fault after disconnect */
> +	if (f_reg == (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT) &&
> +	    !(ss_reg & BQ24190_REG_SS_PG_STAT_MASK))
> +		f_reg = 0;
> +
>  	if (f_reg != bdi->f_reg) {
> -		dev_info(bdi->dev,
> +		dev_warn(bdi->dev,
>  			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
>  			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
>  			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
>
