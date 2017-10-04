From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 04/14] pinctrl: sh-pfc: Add sh_pfc_pin_to_bias_reg() helper
Date: Wed, 04 Oct 2017 13:12:59 +0300
Message-ID: <16944240.gWf3YhhmQZ@avalon>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be> <1507108033-8606-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:57259 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdJDKM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 06:12:57 -0400
In-Reply-To: <1507108033-8606-5-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday, 4 October 2017 12:07:03 EEST Geert Uytterhoeven wrote:
> Add a helper to look up bias registers and bit number for a specific
> pin, using the generic bias register description.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pinctrl/sh-pfc/core.c | 18 ++++++++++++++++++
>  drivers/pinctrl/sh-pfc/core.h |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 1eee3b71cc87ca72..54fae18c32bce3f3 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -404,6 +404,24 @@ sh_pfc_pin_to_bias_info(const struct sh_pfc_bias_info
> *info, return NULL;
>  }
> 
> +const struct pinmux_bias_reg *
> +sh_pfc_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
> +		       unsigned int *bit)
> +{
> +	unsigned int i, j;
> +
> +	for (i = 0; pfc->info->bias_regs[i].puen; i++)
> +		for (j = 0; j < 32; j++)

Maybe ARRAY_SIZE(pfc->info->bias_regs[i].pins) instead of 32 ?

> +			if (pfc->info->bias_regs[i].pins[j] == pin) {
> +				*bit = j;
> +				return &pfc->info->bias_regs[i];
> +			}

While not required by C, curly braces for both for statements would help 
readability.

> +	WARN_ONCE(1, "Pin %u is not in bias info list\n", pin);
> +
> +	return NULL;
> +}
> +
>  static int sh_pfc_init_ranges(struct sh_pfc *pfc)
>  {
>  	struct sh_pfc_pin_range *range;
> diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
> index b9645a2b22895938..d3e3e92601ce1945 100644
> --- a/drivers/pinctrl/sh-pfc/core.h
> +++ b/drivers/pinctrl/sh-pfc/core.h
> @@ -35,5 +35,8 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark,
> int pinmux_type); const struct sh_pfc_bias_info *
>  sh_pfc_pin_to_bias_info(const struct sh_pfc_bias_info *info,
>  			unsigned int num, unsigned int pin);
> +const struct pinmux_bias_reg *
> +sh_pfc_pin_to_bias_reg(const struct sh_pfc *pfc, unsigned int pin,
> +		       unsigned int *bit);
> 
>  #endif /* __SH_PFC_CORE_H__ */


-- 
Regards,

Laurent Pinchart
