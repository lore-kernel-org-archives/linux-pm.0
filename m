From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC/PATCH v2 1/5] ARM: cpuidle: Add cpuidle support for R-Car
 Gen2 series
Date: Fri, 17 Apr 2015 21:14:38 +0900
Message-ID: <CANqRtoQ_tQB326cnxzKaM-Ts6QwSa8y+sn+jM95XuCfsa00hNw@mail.gmail.com>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
	<1429180540-5692-2-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1429180540-5692-2-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Cc: "Simon Horman [Horms]" <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, SH-Linux <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Kobayashi-san,

On Thu, Apr 16, 2015 at 7:35 PM, Keita Kobayashi
<keita.kobayashi.ym@renesas.com> wrote:
> Define ARM_RCAR_CPUIDLE config item to enable cpuidle
> support for Renesas R-Car Gen2 SoCs.
>
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>  drivers/cpuidle/Kconfig.arm | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 21340e0..1bff62e 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -74,3 +74,11 @@ config ARM_MVEBU_V7_CPUIDLE
>         depends on ARCH_MVEBU && !ARM64
>         help
>           Select this to enable cpuidle on Armada 370, 38x and XP processors.
> +
> +config ARM_RCAR_CPUIDLE
> +       bool "CPU Idle Driver for the R-Car SoCs"
> +       depends on ARCH_RCAR_GEN2
> +       depends on ARM_CPUIDLE
> +       select ARM_CPU_SUSPEND
> +       help
> +         Select this to enable cpuidle for R-Car SoCs

Thanks for your efforts. May I ask why we need a separate Kconfig
entry for this portion? It looks a bit overkill to me.

I have not tried this myself, but it seems to me that you could simply
modify arch/arm/mach-shmobile/Kconfig something like this:

config ARCH_RCAR_GEN2
 bool
 select PM_RCAR if PM || SMP
+ select ARM_CPU_SUSPEND if ARM_CPUIDLE
 select RENESAS_IRQC

and then in patch 2/5 use ARM_CPUIDLE for the #ifdefs instead of
ARM_RCAR_CPUIDLE.

I think that would simplify things if possible.

Thanks,

/ magnus
