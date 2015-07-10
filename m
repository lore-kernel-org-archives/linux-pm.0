From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 08:03:50 +0200
Message-ID: <20150710060350.GA3127@piout.net>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37361 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751979AbbGJGDw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 02:03:52 -0400
Content-Disposition: inline
In-Reply-To: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Hi,

On 09/07/2015 at 18:15:46 +0800, Josh Wu wrote :
> As since sama5d3, to reset the chip, we don't need to shutdown the ddr
> controller.
> 
> So add a new compatible string and new restart function for sama5d3 and
> later chips. As we don't use sama5d3 ddr controller, so remove it as
> well.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> 
>  drivers/power/reset/at91-reset.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 36dc52f..8944b63 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -123,6 +123,14 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
>  	return NOTIFY_DONE;
>  }
>  
> +static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
> +			void *cmd)

Please align that line properly.

> +{
> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
> +				at91_rstc_base);

That one too.

> +	return NOTIFY_DONE;
> +}
> +
>  static void __init at91_reset_status(struct platform_device *pdev)
>  {
>  	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
> @@ -155,13 +163,13 @@ static void __init at91_reset_status(struct platform_device *pdev)
>  static const struct of_device_id at91_ramc_of_match[] = {
>  	{ .compatible = "atmel,at91sam9260-sdramc", },
>  	{ .compatible = "atmel,at91sam9g45-ddramc", },
> -	{ .compatible = "atmel,sama5d3-ddramc", },
>  	{ /* sentinel */ }
>  };
>  
>  static const struct of_device_id at91_reset_of_match[] = {
>  	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
>  	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
> +	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
>  	{ /* sentinel */ }
>  };
>  
> @@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	for_each_matching_node(np, at91_ramc_of_match) {
> -		at91_ramc_base[idx] = of_iomap(np, 0);
> -		if (!at91_ramc_base[idx]) {
> -			dev_err(&pdev->dev, "Could not map ram controller address\n");
> -			return -ENODEV;
> +	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
> +	at91_restart_nb.notifier_call = match->data;
> +
> +	if (match->data != sama5d3_restart) {

This doesn't scale well. I would create a structure with a pointer to
the restart function and a boolean or a bitfield to store whether the
workaround is needed. Use that structure in your match data. Then, you
won't need to reorder anything.

> +		/* we need to shutdown the ddr controller, so get ramc base */
> +		for_each_matching_node(np, at91_ramc_of_match) {
> +			at91_ramc_base[idx] = of_iomap(np, 0);
> +			if (!at91_ramc_base[idx]) {
> +				dev_err(&pdev->dev, "Could not map ram controller address\n");
> +				return -ENODEV;
> +			}
> +			idx++;
>  		}
> -		idx++;
>  	}
>  
> -	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
> -	at91_restart_nb.notifier_call = match->data;
>  	return register_restart_handler(&at91_restart_nb);
>  }

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
