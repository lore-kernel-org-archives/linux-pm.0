From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 4/4] ARM: exynos: cpuidle: Remove useless headers
Date: Wed, 24 Jul 2013 10:35:01 +0200
Message-ID: <4079574.R74GCppML0@flatron>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org> <1374152070-21008-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:41489 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab3GXIfG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 04:35:06 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so49161bkc.14
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2013 01:35:04 -0700 (PDT)
In-Reply-To: <1374152070-21008-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, kgene.kim@samsung.com, rjw@sisk.pl, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Thursday 18 of July 2013 14:54:30 Daniel Lezcano wrote:
> The headers:
> 
> #include <linux/kernel.h>
> #include <linux/export.h>
> #include <linux/time.h>
> #include <asm/unified.h>
> 
> are not needed. Removed them.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c
> b/arch/arm/mach-exynos/cpuidle.c index 8d06128..027f5e7 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -8,18 +8,14 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/io.h>
> -#include <linux/export.h>
> -#include <linux/time.h>
> 
>  #include <asm/proc-fns.h>
>  #include <asm/smp_scu.h>
>  #include <asm/suspend.h>
> -#include <asm/unified.h>
>  #include <asm/cpuidle.h>
>  #include <mach/regs-clock.h>
>  #include <mach/regs-pmu.h>

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

