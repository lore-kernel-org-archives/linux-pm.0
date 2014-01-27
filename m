From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
Date: Mon, 27 Jan 2014 09:23:47 +0100
Message-ID: <52E61793.4020608@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org> <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:55348 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbaA0IXs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2014 03:23:48 -0500
Received: by mail-we0-f177.google.com with SMTP id x55so4819608wes.22
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2014 00:23:46 -0800 (PST)
In-Reply-To: <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> ARM and ARM64 are the only two architectures implementing
> arch_cpu_idle_prepare() simply to call local_fiq_enable().
>
> We have secondary_start_kernel() already calling local_fiq_enable() a=
nd
> this is done a second time in arch_cpu_idle_prepare() in that case. A=
nd
> enabling FIQs has nothing to do with idling the CPU to start with.
>
> So let's introduce init_fiq_boot_cpu() to take care of FIQs on the bo=
ot
> CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlie=
r
> at late_initcall time but this shouldn't make a difference in practic=
e
> given that FIQs are not currently used on ARM64.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm64/kernel/process.c | 5 -----
>   arch/arm64/kernel/setup.c   | 7 +++++++
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.=
c
> index de17c89985..f6c733da67 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -84,11 +84,6 @@ EXPORT_SYMBOL_GPL(pm_power_off);
>   void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cm=
d);
>   EXPORT_SYMBOL_GPL(arm_pm_restart);
>
> -void arch_cpu_idle_prepare(void)
> -{
> -	local_fiq_enable();
> -}
> -
>   /*
>    * This is our default idle handler.
>    */
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index bd9bbd0e44..259557983a 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -255,6 +255,13 @@ static int __init arm64_device_init(void)
>   }
>   arch_initcall(arm64_device_init);
>
> +static int __init init_fiq_boot_cpu(void)
> +{
> +	local_fiq_enable();
> +	return 0;
> +}
> +late_initcall(init_fiq_boot_cpu);
> +
>   static DEFINE_PER_CPU(struct cpu, cpu_data);
>
>   static int __init topology_init(void)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

