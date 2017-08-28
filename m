From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/5] power: bq24190_charger: Add ti,bq24192i to
 devicetree table
Date: Mon, 28 Aug 2017 08:59:01 -0700
Message-ID: <20170828155900.GB3930@atomide.com>
References: <20170826051413.24569-1-liam@networkimprov.net>
 <20170826051413.24569-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38076 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdH1P7E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Aug 2017 11:59:04 -0400
Content-Disposition: inline
In-Reply-To: <20170826051413.24569-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170825 22:15]:
> From: Liam Breck <kernel@networkimprov.net>
> 
> bq24192i was previously only in ID table, so add it to DT table.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/power/supply/bq24190_charger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 14199561..40b4bba7 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1732,6 +1732,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
>  #ifdef CONFIG_OF
>  static const struct of_device_id bq24190_of_match[] = {
>  	{ .compatible = "ti,bq24190", },
> +	{ .compatible = "ti,bq24192i", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bq24190_of_match);
> -- 
> 2.13.2
> 
