From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] twl4030_charger: fix another compile error
Date: Fri, 4 Sep 2015 16:55:29 -0700
Message-ID: <20150904235528.GC4215@atomide.com>
References: <1441409554-518-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48722 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760133AbbIDXzc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 19:55:32 -0400
Content-Disposition: inline
In-Reply-To: <1441409554-518-1-git-send-email-notasas@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, NeilBrown <neil@brown.name>

* Grazvydas Ignotas <notasas@gmail.com> [150904 16:36]:
> When CONFIG_CHARGER_TWL4030=y and CONFIG_TWL4030_MADC=m we get a
> compile error:
> 
> drivers/built-in.o: In function `twl4030_charger_update_current':
> twl4030_charger.c:(.text+0x504681): undefined reference to
> `twl4030_get_madc_conversion'
> 
> Use IS_REACHABLE to fix it.
> 
> Cc: NeilBrown <neil@brown.name>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Looks OK to me:

Acked-by: Tony Lindgren <tony#atomide.com>

> ---
>  drivers/power/twl4030_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> index f4f2c1f..5bcc76f 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -91,7 +91,7 @@
>  #define TWL4030_MSTATEC_COMPLETE1	0x0b
>  #define TWL4030_MSTATEC_COMPLETE4	0x0e
>  
> -#if IS_ENABLED(CONFIG_TWL4030_MADC)
> +#if IS_REACHABLE(CONFIG_TWL4030_MADC)
>  /*
>   * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
>   * then AC is available.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
