From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] power: reset: Add Renesas reset driver
Date: Wed, 15 Feb 2017 10:16:07 +0100
Message-ID: <CAMuHMdWRvtxxx3Lp6AyobzKaO101euF7=Bf_w3oH-t02e4J25A@mail.gmail.com>
References: <20170213182532.4042-1-chris.brandt@renesas.com> <20170213182532.4042-2-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33598 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdBOJQP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2017 04:16:15 -0500
In-Reply-To: <20170213182532.4042-2-chris.brandt@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Chris,

On Mon, Feb 13, 2017 at 7:25 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> Some Renesas SoCs do not have a reset register and the only way to do a SW
> controlled reset is to use the watchdog timer. Additionally, since all the
> WDT timeout options are so quick, a system reset is about the only thing
> it's good for.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ b/drivers/power/reset/renesas-reset.c
> @@ -0,0 +1,103 @@

> +/* Watchdog Timer Registers */
> +#define WTCSR 0
> +#define WTCNT 2
> +#define WRCSR 4
> +
> +static void __iomem *base;
> +
> +static int wdt_reset_handler(struct notifier_block *this,
> +                            unsigned long mode, void *cmd)
> +{
> +       pr_debug("%s %lu\n", __func__, mode);
> +
> +       /* Dummy read (must read WRCSR:WOVF at least once before clearing) */
> +       readw(base + WRCSR);
> +
> +       writew(0xA500, base + WRCSR);   /* Clear WOVF */
> +       writew(0x5A5F, base + WRCSR);   /* Reset Enable */
> +       writew(0x5A00, base + WTCNT);   /* Counter to 00 */
> +       writew(0xA578, base + WTCSR);   /* Start timer */

Hardcoded register values? Please use #defines.
Yes, the 0xa5 and 0x5a are magic values, but the other bits aren't.

> +
> +       /* Wait for WDT overflow */
> +       while (1)
> +               ;

This burns CPU, and thus power, albeit for a very short time.
Perhaps add an msleep() to the loop body?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
