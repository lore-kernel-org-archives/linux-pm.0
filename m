From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Remove unselectable rule for arm-exynos-cpufreq.o
Date: Thu, 13 Aug 2015 16:05:16 +0530
Message-ID: <20150813103516.GS20238@linux>
References: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34786 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbHMKfV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 06:35:21 -0400
Received: by pdbfa8 with SMTP id fa8so17824729pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 03:35:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: "Rafael J. Wysocki\"" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 13-08-15, 12:32, Jonas Rabenstein wrote:
> With commit 2907ed4377d9 ("cpufreq: exynos: remove Exynos4x12 specific
> cpufreq driver support"), the last specific Exynos-cpufreq driver
> depending on ARM_EXYNOS_CPUFREQ was removed. As there is no
> Exynos-specific cpufreq driver depending on the code in
> drivers/cpufreq/exynos-cpufreq.c (selected by ARM_EXYNOS_CPUFREQ),
> this file was deleted and ARM_EXYNOS_CPUFREQ removed from Kconfig.
> After all, the rule in drivers/cpufreq/Makefile, to combine all
> specific cpufreq drivers depending on the generic code for Exynos into
> one objectfile is obsolete and can be removed.
> 
> Remove unselectable rule for arm-exynos-cpufreq.o from
> drivers/cpufreq/Makefile, which - if selectable - would generate an
> always empty objectfile.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
> I found this inconsistency using the undertaker and
> undertaker-checkpatch tools (https://undertaker.cs.fau.de/).
> 
>  drivers/cpufreq/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index bbc4a9f..958be2b 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -52,7 +52,6 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
>  
>  obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
>  obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= arm-exynos-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
>  obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
>  obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
