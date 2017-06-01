From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 2/2] power: reset: at91-sama5d2_shdwc: fix clobber list
Date: Thu, 1 Jun 2017 11:00:56 +0200
Message-ID: <83a8441d-e07c-c1a8-faa5-28521ea9ab39@microchip.com>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
 <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Le 31/05/2017 à 11:49, Alexandre Belloni a écrit :
> Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.
> 
> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index 90b0b5a70ce5..55fce8b75245 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -132,7 +132,7 @@ static void at91_lpddr_poweroff(void)
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
>  		  "r" (at91_shdwc->at91_shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
> -		: "r0");
> +		: "r6");
>  }
>  
>  static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
> 


-- 
Nicolas Ferre
