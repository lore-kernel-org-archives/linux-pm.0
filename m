From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 4/4] power: bq24190_charger: Delay before polling reset
 flag
Date: Thu, 6 Apr 2017 09:20:10 +0200
Message-ID: <3a514e1e-8ad0-4951-c675-10c2e7de37ec@redhat.com>
References: <20170406031048.12401-1-liam@networkimprov.net>
 <20170406031048.12401-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933983AbdDFHUN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Apr 2017 03:20:13 -0400
In-Reply-To: <20170406031048.12401-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 06-04-17 05:10, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> On chip reset, polling loop was reading reset register immediately.
> Instead, call udelay() before reading chip register.

Can you extend the commit message to explain why udelay is being
called ?  IOW what is the problem with reading the register
immediately which this patch addresses ?

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
> index fa29cb3..71a796e 100644
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
