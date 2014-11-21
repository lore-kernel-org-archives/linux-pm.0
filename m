From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: qoriq: Make the driver usable on all
 QorIQ platforms
Date: Fri, 21 Nov 2014 13:24:54 +0530
Message-ID: <CAKohpok0yOJTfZ7arkW8N2YORk+-U_NqQvp+dx52FA1m3gh4MA@mail.gmail.com>
References: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, r64188@freescale.com
List-Id: linux-pm@vger.kernel.org

On 21 November 2014 12:58, Tang Yuantian <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 83a75dc..1925ae94 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -247,3 +247,11 @@ config ARM_TEGRA_CPUFREQ
>         default y
>         help
>           This adds the CPUFreq driver support for TEGRA SOCs.
> +
> +config QORIQ_CPUFREQ
> +       tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> +       depends on OF && COMMON_CLK
> +       select CLK_PPC_CORENET
> +       help
> +         This adds the CPUFreq driver support for Freescale QorIQ SoCs
> +         which are capable of changing the CPU's frequency dynamically.
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index 72564b7..3a34248 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -23,14 +23,13 @@ config CPU_FREQ_MAPLE
>           This adds support for frequency switching on Maple 970FX
>           Evaluation Board and compatible boards (IBM JS2x blades).
>
> -config PPC_CORENET_CPUFREQ
> -       tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
> -       depends on PPC_E500MC && OF && COMMON_CLK
> +config QORIQ_CPUFREQ
> +       tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> +       depends on OF && COMMON_CLK
>         select CLK_PPC_CORENET
>         help
> -         This adds the CPUFreq driver support for Freescale e500mc,
> -         e5500 and e6500 series SoCs which are capable of changing
> -         the CPU's frequency dynamically.
> +         This adds the CPUFreq driver support for Freescale QorIQ SoCs
> +         which are capable of changing the CPU's frequency dynamically.
>
>  config CPU_FREQ_PMAC
>         bool "Support for Apple PowerBooks"

Now that following patch is pushed into linux-next:

f41f481 cpufreq: Kconfig: Remove architecture specific menu entries

you can move above config entries directly to drivers/cpufreq/Kconfig
instead of replicating them.
