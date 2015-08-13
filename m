From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] Remove unselectable rule for arm-exynos-cpufreq.o
Date: Thu, 13 Aug 2015 17:03:00 +0530
Message-ID: <20150813113300.GU20238@linux>
References: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <1439465318-18108-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34725 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbbHMLdH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 07:33:07 -0400
Received: by pawu10 with SMTP id u10so36387507paw.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 04:33:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1439465318-18108-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki\"" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 13-08-15, 13:28, Jonas Rabenstein wrote:
> Commit "cpufreq: exynos: remove Exynos4x12 specific cpufreq driver
> support" deleted option ARM_EXYNOS_CPUFREQ but missed to delete a rule
> in drivers/cpufreq/Makefile which depends on that option.
> 
> Remove unselectable rule for arm-exynos-cpufreq.o from
> drivers/cpufreq/Makefile.
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
