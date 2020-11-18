Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB2C63777
	for <linux-pm@archiver.kernel.org>; Wed, 18 Nov 2020 10:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEE9241A5
	for <linux-pm@archiver.kernel.org>; Wed, 18 Nov 2020 10:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKRKwf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 Nov 2020 05:52:35 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:33397 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKRKwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 05:52:34 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id ED33A240002;
        Wed, 18 Nov 2020 10:52:32 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:52:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH 4/5] power: reset: ocelot: Add support 2 othe MIPS based
 SoCs
Message-ID: <20201118105232.GE4556@piout.net>
References: <20201116171159.1735315-1-gregory.clement@bootlin.com>
 <20201116171159.1735315-5-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116171159.1735315-5-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 16/11/2020 18:11:58+0100, Gregory CLEMENT wrote:
> This adds reset support for Luton and Jaguar2 in the ocelot-reset
> driver. They are both MIPS based belonging to the VvoreIII family.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/power/reset/ocelot-reset.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
> index a203c42e99d4..0f92416f2907 100644
> --- a/drivers/power/reset/ocelot-reset.c
> +++ b/drivers/power/reset/ocelot-reset.c
> @@ -29,6 +29,8 @@ struct ocelot_reset_context {
>  	struct notifier_block restart_handler;
>  };
>  
> +#define BIT_OFF_INVALID				32
> +
>  #define SOFT_SWC_RST  BIT(1)
>  #define SOFT_CHIP_RST BIT(0)
>  
> @@ -77,9 +79,11 @@ static int ocelot_restart_handle(struct notifier_block *this,
>  			   ctx->props->vcore_protect, 0);
>  
>  	/* Make the SI back to boot mode */
> -	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
> -			   IF_SI_OWNER_MASK << if_si_owner_bit,
> -			   IF_SI_OWNER_SIBM << if_si_owner_bit);
> +	if (if_si_owner_bit != BIT_OFF_INVALID)
> +		regmap_update_bits(ctx->cpu_ctrl,
> +				   ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
> +				   IF_SI_OWNER_MASK << if_si_owner_bit,
> +				   IF_SI_OWNER_SIBM << if_si_owner_bit);
>  
>  	pr_emerg("Resetting SoC\n");
>  
> @@ -127,6 +131,20 @@ static int ocelot_reset_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static const struct reset_props reset_props_jaguar2 = {
> +	.syscon		 = "mscc,ocelot-cpu-syscon",
> +	.protect_reg     = 0x20,
> +	.vcore_protect   = BIT(2),
> +	.if_si_owner_bit = 6,
> +};
> +
> +static const struct reset_props reset_props_luton = {
> +	.syscon		 = "mscc,ocelot-cpu-syscon",
> +	.protect_reg     = 0x20,
> +	.vcore_protect   = BIT(2),
> +	.if_si_owner_bit = BIT_OFF_INVALID, /* n/a */
> +};
> +
>  static const struct reset_props reset_props_ocelot = {
>  	.syscon		 = "mscc,ocelot-cpu-syscon",
>  	.protect_reg     = 0x20,
> @@ -143,6 +161,12 @@ static const struct reset_props reset_props_sparx5 = {
>  
>  static const struct of_device_id ocelot_reset_of_match[] = {
>  	{
> +		.compatible = "mscc,jaguar2-chip-reset",
> +		.data = &reset_props_jaguar2
> +	}, {
> +		.compatible = "mscc,luton-chip-reset",
> +		.data = &reset_props_luton
> +	}, {

These compatible strings are undocumented. Else,

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

>  		.compatible = "mscc,ocelot-chip-reset",
>  		.data = &reset_props_ocelot
>  	}, {
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
