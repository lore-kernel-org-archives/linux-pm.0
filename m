From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/14] pinctrl: sh-pfc: Remove matching on plain sh-pfc platform device
Date: Wed, 04 Oct 2017 12:52:32 +0300
Message-ID: <2182027.qnhtCa0uq9@avalon>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be> <1507108033-8606-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1507108033-8606-2-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday, 4 October 2017 12:07:00 EEST Geert Uytterhoeven wrote:
> As of commit 8682b3c522c639f3 ("sh-pfc: Remove platform device
> registration"), plain "sh-pfc" platform devices are no longer created.
> Hence remove their match entry, and the now obsolete checks for missing
> device IDs and driver data.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 0c5e952461fdf7c6..9cdbaeab2cf10d46 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -569,7 +569,6 @@ static const struct of_device_id sh_pfc_of_table[] = {
> 
>  static int sh_pfc_probe(struct platform_device *pdev)
>  {
> -	const struct platform_device_id *platid = platform_get_device_id(pdev);
>  #ifdef CONFIG_OF
>  	struct device_node *np = pdev->dev.of_node;
>  #endif
> @@ -582,10 +581,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
>  		info = of_device_get_match_data(&pdev->dev);
>  	else
>  #endif
> -		info = platid ? (const void *)platid->driver_data : NULL;
> -
> -	if (info == NULL)
> -		return -ENODEV;
> +		info = (const void *)platform_get_device_id(pdev)->driver_data;
> 
>  	pfc = devm_kzalloc(&pdev->dev, sizeof(*pfc), GFP_KERNEL);
>  	if (pfc == NULL)
> @@ -683,7 +679,6 @@ static const struct platform_device_id sh_pfc_id_table[]
> = { #ifdef CONFIG_PINCTRL_PFC_SHX3
>  	{ "pfc-shx3", (kernel_ulong_t)&shx3_pinmux_info },
>  #endif
> -	{ "sh-pfc", 0 },
>  	{ },
>  };


-- 
Regards,

Laurent Pinchart

