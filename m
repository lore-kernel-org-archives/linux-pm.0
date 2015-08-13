From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] Remove unselectable rule for arm-exynos-cpufreq.o
Date: Thu, 13 Aug 2015 19:53:36 +0900
Message-ID: <CAJKOXPcr8SdXRse-oYzfyB=YULk=hCCWuL=AGoJcXrXX_dsnMg@mail.gmail.com>
References: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33412 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbHMKxh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 06:53:37 -0400
In-Reply-To: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

2015-08-13 19:32 GMT+09:00 Jonas Rabenstein
<jonas.rabenstein@studium.uni-erlangen.de>:
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

That's a lot, really a lot of words, just to say that
ARM_EXYNOS_CPUFREQ option was removed and we should get rid of any
left-overs. The patch is of course valid... but could you trim this to
a short sentence giving the reason? Mentioned commit ID comes from
linux-next (or maintainer branch which may rebase) so it won't work
long-term. I think you can just leave the title of the commit.

When re-spinning:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Viresh,
Do you want this to go through samsung-soc tree?

Best regards,
Krzysztof

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
> @@ -52,7 +52,6 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)               += arm_big_little_dt.o
>
>  obj-$(CONFIG_ARCH_DAVINCI)             += davinci-cpufreq.o
>  obj-$(CONFIG_UX500_SOC_DB8500)         += dbx500-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       += arm-exynos-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)   += exynos5440-cpufreq.o
>  obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)     += highbank-cpufreq.o
>  obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)    += hisi-acpu-cpufreq.o
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
