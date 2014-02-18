From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] cpufreq: Kconfig.arm: Fix unmet direct dependencies
Date: Tue, 18 Feb 2014 10:07:16 -0300
Message-ID: <CAOMZO5BvaTm7BfS_+0pwCUyOJTpCOtsinjfs9fJ-SR9dURHEzg@mail.gmail.com>
References: <1392726951-8256-1-git-send-email-fabio.estevam@freescale.com>
	<1490688.YGyTpvjYUy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:33979 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbaBRNHR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2014 08:07:17 -0500
Received: by mail-ve0-f170.google.com with SMTP id cz12so13759196veb.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2014 05:07:16 -0800 (PST)
In-Reply-To: <1490688.YGyTpvjYUy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Feb 18, 2014 at 9:57 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, February 18, 2014 09:35:51 AM Fabio Estevam wrote:
>> Currently the following warning is generated when building multi_v7_defconfig:
>>
>> $ make multi_v7_defconfig
>> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
>> # configuration written to .config
>>
>> Instead of forcing the selection of GENERIC_CPUFREQ_CPU0 and REGULATOR, change
>> it to 'depends on' instead.
>
> OK
>
> Any objections here?

Thinking more about it I think the correct fix would be:

--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -84,9 +84,7 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 config ARM_HIGHBANK_CPUFREQ
        tristate "Calxeda Highbank-based"
        depends on ARCH_HIGHBANK
-       select GENERIC_CPUFREQ_CPU0
-       select PM_OPP
-       select REGULATOR
+       depends on GENERIC_CPUFREQ_CPU0

        default m
        help

Because we have:

config GENERIC_CPUFREQ_CPU0
    tristate "Generic CPU0 cpufreq driver"
    depends on HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL
    select PM_OPP
    help
      This adds a generic cpufreq driver for CPU0 frequency management.
      It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
      systems which share clock and voltage across all CPUs.

If everyone agrees I would send a v3 with such fix.

Thanks,

Fabio Estevam
