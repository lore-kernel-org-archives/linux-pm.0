From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 4/4] power: bq24190_charger: Longer delay while
 polling reset flag
Date: Tue, 11 Apr 2017 08:33:03 -0700
Message-ID: <20170411153303.GE3583@atomide.com>
References: <20170411115957.14253-1-liam@networkimprov.net>
 <20170411115957.14253-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44104 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbdDKPdJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 11:33:09 -0400
Content-Disposition: inline
In-Reply-To: <20170411115957.14253-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170411 05:02]:
> From: Liam Breck <kernel@networkimprov.net>
> 
> On chip reset, polling loop used udelay(10) which is too short
> to be useful. Instead, use usleep_range(100, 200).

Good to see this get rid of udelay in favor of usleep:

Acked-by: Tony Lindgren <tony@atomide.com>

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq24190_charger.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index a904abb..f581042 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -550,16 +550,13 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>  		if (ret < 0)
>  			return ret;
>  
> +		if (v == 0)
> +			return 0;
> -		if (!v)
> -			break;
>  
> -		udelay(10);
> +		usleep_range(100, 200);
>  	} while (--limit);
>  
> -	if (!limit)
> -		return -EIO;
> -
> -	return 0;
> +	return -EIO;
>  }
>  
>  /* Charger power supply property routines */
> -- 
> 2.9.3
> 
