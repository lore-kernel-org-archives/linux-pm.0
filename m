From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 1/2] power: reset: at91-poweroff: fix clobber list
Date: Thu, 1 Jun 2017 11:00:42 +0200
Message-ID: <67ae4003-bcfb-c875-c4b7-0d1dc840d3f0@microchip.com>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:15703 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFAJAT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 05:00:19 -0400
In-Reply-To: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Le 31/05/2017 à 11:49, Alexandre Belloni a écrit :
> Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.
> 
> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  drivers/power/reset/at91-poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
> index c6c3beea72f9..c30c40193aaa 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -97,7 +97,7 @@ static void at91_lpddr_poweroff(void)
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
>  		  "r" (at91_shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
> -		: "r0");
> +		: "r6");
>  }
>  
>  static int at91_poweroff_get_wakeup_mode(struct device_node *np)
> 


-- 
Nicolas Ferre
