From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
Date: Fri, 22 Aug 2014 16:54:48 -0700
Message-ID: <7hbnrc6px3.fsf@paris.lan>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com> <53DA8D85.3050106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49676 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbaHVXyv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Aug 2014 19:54:51 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so17681153pad.10
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2014 16:54:50 -0700 (PDT)
In-Reply-To: <53DA8D85.3050106@gmail.com> (Tomasz Figa's message of "Thu, 31
	Jul 2014 20:40:05 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l.majewski@samsung.com, mturquette@linaro.org, heiko@sntech.de, viresh.kumar@linaro.org, t.figa@samsung.com, cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, amit.kucheria@linaro.org

Tomasz Figa <tomasz.figa@gmail.com> writes:

> Kukjin,
>
> On 31.07.2014 20:32, Kukjin Kim wrote:
>> On 07/30/14 17:07, Thomas Abraham wrote:
>>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>>> which did not have CPUfreq driver support, enable the use of generic
>>> CPUfreq driver.
>>>
>>> Suggested-by: Tomasz Figa<t.figa@samsung.com>
>>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>> 
>> Looks good to me,
>> 
>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>> 
>> BTW, who will handle this series? I hope see this series in 3.17.
>
> This series consists mostly of clock changes and it likely depends on
> patches already in my for-next, so I would be inclined toward taking it
> through samsung-clk tree. 

So has this series been picked up anywhere?  I don't see it in your
samsung-clk tree, nor in Kukjin's for-next.

Also, I'm curious whether or how this is has been tested on big.LITTLE
SoCs.  

I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
testing along with CPUidle, so there may be some untested interactions
there as it seems a bit more stable without CPUidle enabled.

I'd love to hear from anyone else that's testing CPUidle and CPUfreq
together big.LITTLE 5420/5800, with or without the switcher.

Also, the patch below[2] is needed for 5800.

FWIW, I have a temporary branch[1] based on the v3.17-rc branch of the
exynos-reference tree where I've added the DT patch needed for CPUidle,
this series (and it's dependencies) which is what I'm using for testing.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git wip/exynos/integ
[2]
>From 72ee00246c0fbdcf5dbb0bf910b8a427da4ac002 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@linaro.org>
Date: Fri, 22 Aug 2014 16:04:11 -0700
Subject: [PATCH] ARM: Exynos: use generic cpufreq driver for Exynos5800

As a derivative of the 5420, the 5800 SoC should use the generic
big.LITTLE driver for Exynos5800 as well.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 8923d37c3e85..debe50bf736a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -283,6 +283,7 @@ static void __init exynos_init_irq(void)
 
 static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
+	{ .compatible = "samsung,exynos5800", .data = "arm-bL-cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-cpu0" },
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-cpu0" },
 	{ .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
-- 
1.9.2

