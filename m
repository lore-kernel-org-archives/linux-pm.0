From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix qoriq uniprocessor build
Date: Sat, 11 Apr 2015 08:32:58 +0530
Message-ID: <CAKohpomGUfYsuFnCN3y_=WOG44sbVNy4OFTQ6VFy+69dOhj9kw@mail.gmail.com>
References: <8186394.6fcP6P730e@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32980 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbDKDC7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2015 23:02:59 -0400
Received: by qkx62 with SMTP id 62so58514214qkx.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2015 20:02:58 -0700 (PDT)
In-Reply-To: <8186394.6fcP6P730e@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tang Yuantian <Yuantian.Tang@freescale.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11 April 2015 at 03:47, Arnd Bergmann <arnd@arndb.de> wrote:
> The qoriq-cpufreq driver contains a hack for powerpc to include
> asm/smp.h on uniprocessor builds so it can get the hardware CPU
> number. On ARM, it does not require this hack, but instead gets
> a compile error:
>
> In file included from drivers/cpufreq/qoriq-cpufreq.c:24:0:
> arch/arm/include/asm/smp.h:18:3: error: #error "<asm/smp.h> included in non-SMP build"
> arch/arm/include/asm/smp.h:21:0: warning: "raw_smp_processor_id" redefined
>
> This adds an #ifdef to mirror the one in its get_cpu_physical_id()
> function.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2f249358eedaf ("cpufreq: qoriq: rename the driver")
> Cc: Tang Yuantian <Yuantian.Tang@freescale.com>
>
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 9fd51c860308..88b21ae0d6b0 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -21,7 +21,9 @@
>  #include <linux/slab.h>
>  #include <linux/smp.h>
>
> +#if !defined(CONFIG_ARM)
>  #include <asm/smp.h>   /* for get_hard_smp_processor_id() in UP configs */
> +#endif

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
