From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
Date: Mon, 20 Jul 2015 06:12:10 -0700
Message-ID: <55ACF3AA.7020901@roeck-us.net>
References: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33129 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbbGTNNW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 09:13:22 -0400
In-Reply-To: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org
Cc: Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

On 07/20/2015 02:32 AM, Josh Wu wrote:
> This patch introduces a new compatible string: "atmel,sama5d3-rstc" and
> new reset function for sama5d3 and later chips.
>
> As in sama5d3 or later chips, we don't have to shutdown the DDR
> controller before reset. Shutdown the DDR controller before reset is a
> workaround to avoid DDR signal driving the bus, but since sama5d3 and
> later chips there is no such a conflict.
>
> So in this patch:
>     1. the sama5d3 reset function only need to write the rstc register
> and return.
>     2. we can remove the code related with sama5d3 DDR controller as
> we don't use it at all.
>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
> Changes in v2:
> - aligned the function parameters to be consist with the coding style
> - refined the commit log
> - add binding document changes
> - use of_device_is_compitable() instead
>
>   .../devicetree/bindings/arm/atmel-at91.txt         |  2 +-
>   drivers/power/reset/at91-reset.c                   | 26 ++++++++++++++++------
>   2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index 424ac8c..dd998b9 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -87,7 +87,7 @@ One interrupt per TC channel in a TC block:
>
>   RSTC Reset Controller required properties:
>   - compatible: Should be "atmel,<chip>-rstc".
> -  <chip> can be "at91sam9260" or "at91sam9g45"
> +  <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
>   - reg: Should contain registers location and length
>
>   Example:
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 36dc52f..c378d4e 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -123,6 +123,15 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
>   	return NOTIFY_DONE;
>   }
>
> +static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
> +			   void *cmd)
> +{
> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
> +	       at91_rstc_base);
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static void __init at91_reset_status(struct platform_device *pdev)
>   {
>   	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
> @@ -155,13 +164,13 @@ static void __init at91_reset_status(struct platform_device *pdev)
>   static const struct of_device_id at91_ramc_of_match[] = {
>   	{ .compatible = "atmel,at91sam9260-sdramc", },
>   	{ .compatible = "atmel,at91sam9g45-ddramc", },
> -	{ .compatible = "atmel,sama5d3-ddramc", },
>   	{ /* sentinel */ }
>   };
>
>   static const struct of_device_id at91_reset_of_match[] = {
>   	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
>   	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
> +	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
>   	{ /* sentinel */ }
>   };
>
> @@ -181,13 +190,16 @@ static int at91_reset_of_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>
> -	for_each_matching_node(np, at91_ramc_of_match) {
> -		at91_ramc_base[idx] = of_iomap(np, 0);
> -		if (!at91_ramc_base[idx]) {
> -			dev_err(&pdev->dev, "Could not map ram controller address\n");
> -			return -ENODEV;
> +	if (!of_device_is_compatible(pdev->dev.of_node, "atmel,sama5d3-rstc")) {
> +		/* we need to shutdown the ddr controller, so get ramc base */
> +		for_each_matching_node(np, at91_ramc_of_match) {
> +			at91_ramc_base[idx] = of_iomap(np, 0);
> +			if (!at91_ramc_base[idx]) {
> +				dev_err(&pdev->dev, "Could not map ram controller address\n");
> +				return -ENODEV;
> +			}
> +			idx++;
>   		}
> -		idx++;
>   	}
>
>   	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
>

