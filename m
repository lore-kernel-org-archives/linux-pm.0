From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 4/4] power: bq24190_charger: Delay before polling reset
 flag
Date: Sun, 2 Apr 2017 14:29:04 +0200
Message-ID: <66a0a8ca-16e2-ecbb-a5c3-73ef94d869c7@redhat.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbdDBM3W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Apr 2017 08:29:22 -0400
In-Reply-To: <20170401202519.16280-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 01-04-17 22:25, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> On chip reset, polling loop was reading reset register immediately.
> Instead, call udelay() before reading chip register.

Why ? What does this buy us ?

Also I've yet to hear back from you on my patch to remove doing
resets of the device altogether have you find any bad side-effects
of that patch in your testing ?

If not I would like us to proceed with simply removing the reset
code as my patch does.

Regards,

Hans



>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq24190_charger.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 52389c5..898faed 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -543,18 +543,14 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>
>  	/* Reset bit will be cleared by hardware so poll until it is */
>  	do {
> +		udelay(10);
>  		ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
>  				BQ24190_REG_POC_RESET_MASK,
>  				BQ24190_REG_POC_RESET_SHIFT,
>  				&v);
>  		if (ret < 0)
>  			return ret;
> -
> -		if (!v)
> -			break;
> -
> -		udelay(10);
> -	} while (--limit);
> +	} while (v && --limit);
>
>  	if (!limit)
>  		return -EIO;
>
