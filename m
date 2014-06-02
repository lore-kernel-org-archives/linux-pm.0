From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 5/7] ARM: EXYNOS: PM: use c15resume firmware method
 if secure firmware is enabled
Date: Mon, 02 Jun 2014 15:07:46 +0200
Message-ID: <538C7722.8020706@gmail.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com> <1401712543-14281-6-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:54106 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbaFBNIB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 09:08:01 -0400
In-Reply-To: <1401712543-14281-6-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

Hi,

On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> Use c15resume firmware method instead of accessing the registers
> directly in exynos_cpu_restore_register() if secure firmware is
> enabled.  This affects both PM resume method and cpuidle AFTR mode.
> 
> This patch shouldn't cause any functionality changes on boards that
> don't use secure firmware.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index cf09383..aeff99e 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -26,6 +26,7 @@
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/smp_scu.h>
>  #include <asm/suspend.h>
> +#include <asm/firmware.h>
>  
>  #include <plat/pm-common.h>
>  #include <plat/pll.h>
> @@ -232,6 +233,9 @@ static void exynos_cpu_restore_register(void)
>  {
>  	unsigned long tmp;
>  
> +	if (call_firmware_op(c15resume, save_arm_register) == 0)
> +		return;
> +

As I mentioned in my comments to patch 2/7, instead of introducing
heavily SoC-specific operations, I'd rather add more general suspend and
resume firmware operations which would take care of both saving and
restoring those registers.

Best regards,
Tomasz
