From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: Kconfig.arm: Fix unmet direct dependencies
Date: Tue, 18 Feb 2014 14:27:06 +0100
Message-ID: <1507864.thn2joDkxp@vostro.rjw.lan>
References: <1392726951-8256-1-git-send-email-fabio.estevam@freescale.com> <1490688.YGyTpvjYUy@vostro.rjw.lan> <CAOMZO5BvaTm7BfS_+0pwCUyOJTpCOtsinjfs9fJ-SR9dURHEzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61952 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755039AbaBRNMR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2014 08:12:17 -0500
In-Reply-To: <CAOMZO5BvaTm7BfS_+0pwCUyOJTpCOtsinjfs9fJ-SR9dURHEzg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, February 18, 2014 10:07:16 AM Fabio Estevam wrote:
> On Tue, Feb 18, 2014 at 9:57 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, February 18, 2014 09:35:51 AM Fabio Estevam wrote:
> >> Currently the following warning is generated when building multi_v7_defconfig:
> >>
> >> $ make multi_v7_defconfig
> >> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
> >> # configuration written to .config
> >>
> >> Instead of forcing the selection of GENERIC_CPUFREQ_CPU0 and REGULATOR, change
> >> it to 'depends on' instead.
> >
> > OK
> >
> > Any objections here?
> 
> Thinking more about it I think the correct fix would be:
> 
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -84,9 +84,7 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>  config ARM_HIGHBANK_CPUFREQ
>         tristate "Calxeda Highbank-based"
>         depends on ARCH_HIGHBANK
> -       select GENERIC_CPUFREQ_CPU0
> -       select PM_OPP
> -       select REGULATOR
> +       depends on GENERIC_CPUFREQ_CPU0
> 
>         default m
>         help
> 
> Because we have:
> 
> config GENERIC_CPUFREQ_CPU0
>     tristate "Generic CPU0 cpufreq driver"
>     depends on HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL
>     select PM_OPP
>     help
>       This adds a generic cpufreq driver for CPU0 frequency management.
>       It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
>       systems which share clock and voltage across all CPUs.
> 
> If everyone agrees I would send a v3 with such fix.

Yes, please.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
