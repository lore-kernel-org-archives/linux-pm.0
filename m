From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ARM: shmobile: cpuidle: Remove the pointless default driver
Date: Tue, 17 Mar 2015 16:06:31 +0100
Message-ID: <CAMuHMdX0xhLRswsQs6=kQVycQ7sZynMobHY0ySX+oMMPEg=79Q@mail.gmail.com>
References: <1426602892-17208-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426602892-17208-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Tue, Mar 17, 2015 at 3:34 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The default idle driver uses one state with the WFI instruction.
> The default idle routine invokes WFI when no cpuidle driver is present.
>
> The default cpuidle driver is pointless and does not give more than the
> default idle routine and moreover it pulls all the mathematics tied with
> the cpuidle governor for nothing, hence consuming more energy.
>
> Remove the default driver, the related code and register the driver directly.

Thanks for your patch!

> [compiled only - no board - no test]
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-shmobile/common.h    |  3 ---
>  arch/arm/mach-shmobile/cpuidle.c   | 37 -------------------------------------
>  arch/arm/mach-shmobile/pm-sh7372.c |  2 +-
>  3 files changed, 1 insertion(+), 41 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
> index 309025e..29b3088 100644
> --- a/arch/arm/mach-shmobile/common.h
> +++ b/arch/arm/mach-shmobile/common.h
> @@ -23,8 +23,6 @@ struct clk;
>  extern int shmobile_clk_init(void);
>  extern void shmobile_handle_irq_intc(struct pt_regs *);
>  extern struct platform_suspend_ops shmobile_suspend_ops;
> -struct cpuidle_driver;
> -extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
>
>  #ifdef CONFIG_SUSPEND
>  int shmobile_suspend_init(void);
> @@ -51,7 +49,6 @@ extern void __iomem *shmobile_scu_base;
>  static inline void __init shmobile_init_late(void)
>  {
>         shmobile_suspend_init();
> -       shmobile_cpuidle_init();

Please remove the forward declaration and dummy for shmobile_cpuidle_init()
above, too.

>         shmobile_cpufreq_init();
>  }
>
> diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
> index 0afeb5c..e69de29 100644
> --- a/arch/arm/mach-shmobile/cpuidle.c
> +++ b/arch/arm/mach-shmobile/cpuidle.c
> @@ -1,37 +0,0 @@

If you remove this file, you should remove its entry from
arch/arm/mach-shmobile/Makefile, too.
(did you use a config with CONFIG_CPU_IDLE=n?).

> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
> index c0293ae..9f19052 100644
> --- a/arch/arm/mach-shmobile/pm-sh7372.c
> +++ b/arch/arm/mach-shmobile/pm-sh7372.c

Support for sh7372 is scheduled for removal in v4.1, so this will become
a no-op.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
