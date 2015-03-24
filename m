From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: mstp: Never disable INTC-SYS
Date: Tue, 24 Mar 2015 16:25:08 -0700
Message-ID: <20150324232508.7930.89483@quantum>
References: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
 <1426706164-28309-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426706164-28309-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Quoting Geert Uytterhoeven (2015-03-18 12:16:00)
> INTC-SYS is the module clock for the GIC.  Accessing the GIC while it is
> disabled causes:
> 
>     Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
> 
> Currently, the GIC driver cannot enable its module clock for several
> reasons:
>   - It does not use a platform device, so Runtime PM is not an option,
>   - gic_of_init() runs before any clocks are registered, so it cannot
>     explicitly enable the clock,
>   - gic_of_init() cannot return -EPROBE_DEFER, as IRQCHIP_DECLARE()
>     doesn't support deferred probing.
> 
> Hence we have to keep on relying on the boot loader for enabling the
> module clock.
> 
> To prevent the module clock from being disabled when the CCF core thinks
> it is unused, and thus causing a system lock-up, add a quirk to the MSTP
> clock driver to make sure the module clock is never disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/clk/shmobile/clk-mstp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index 2d2fe773ac8168f9..742af84735a07450 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -62,6 +62,12 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
>         unsigned int i;
>         u32 value;
>  
> +       /* INTC-SYS is the module clock of the GIC, and must not be disabled */
> +       if (!enable && !strcmp(__clk_get_name(hw->clk), "intc-sys")) {
> +               pr_debug("MSTP %pC skipping disable\n", hw->clk);
> +               return 0;
> +       }

Hello Geert,

This is a bit ugly for three reasons:

1) we hit this code for every MSTP clock {en,dis}able call
2) __clk_get_name is kind of gross
3) the enable_count will not be correct. It will be zero but the clock
will actually be enabled

Have you considered Lee's series to express these always-on clocks in
DT? See,

https://lkml.org/lkml/2015/2/24/495

Regards,
Mike

> +
>         spin_lock_irqsave(&group->lock, flags);
>  
>         value = clk_readl(group->smstpcr);
> -- 
> 1.9.1
> 
