From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/8 v5] ARM: realview: basic device tree implementation
Date: Tue, 02 Sep 2014 14:37:50 +0200
Message-ID: <2876550.hEdeI6fXQL@wuerfel>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org> <1409659354-23553-9-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:59570 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbaIBMi0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 08:38:26 -0400
In-Reply-To: <1409659354-23553-9-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>

On Tuesday 02 September 2014 14:02:34 Linus Walleij wrote:
> +static void __init realview_dt_init_machine(void)
> +{
> +       int ret;
> +
> +#if IS_ENABLED(CONFIG_CACHE_L2X0)
> +       l2x0_of_init(0, ~0);
> +#endif
> +
> +       ret = of_platform_populate(NULL, of_default_bus_match_table,
> +                                  NULL, NULL);
> +       if (ret) {
> +               pr_crit("could not populate device tree\n");
> +               return;
> +       }
> +}
> +
> +static const char *realview_dt_platform_compat[] __initconst = {
> +       "arm,realview-eb",
> +       "arm,realview-pb1176",
> +       "arm,realview-pb11mp",
> +       "arm,realview-pba8",
> +       "arm,realview-pbx",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(REALVIEW_DT, "ARM RealView Machine (Device Tree Support)")
> +       .init_machine   = realview_dt_init_machine,
> +#ifdef CONFIG_ZONE_DMA
> +       .dma_zone_size  = SZ_256M,
> +#endif
> +       .dt_compat      = realview_dt_platform_compat,
> +MACHINE_END
> 

This looks almost perfect to me, but there is one simplification you
can do now:

If you add the .l2c_aux_val/.l2c_aux_mask fields to the
machine descriptor, you can remove the rest of the
realview_dt_init_machine function, and have only the
dma_zone_size setting left here.

On a related note, I think we need to add the same setting to the
default machine descriptor in setup_machine_fdt() so it gets set
up correctly there too.

	Arnd
