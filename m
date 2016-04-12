From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/5] cpufreq: Loongson1: Rename the file to
 loongson1-cpufreq.c
Date: Tue, 12 Apr 2016 10:47:32 +0530
Message-ID: <20160412051732.GO16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34003 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcDLFRh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 01:17:37 -0400
Received: by mail-pf0-f181.google.com with SMTP id c20so6662445pfc.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 22:17:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch renames the file to loongson1-cpufreq.c
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/Makefile                                | 2 +-
>  drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (100%)
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 9e63fb1..bebe9c8 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -100,7 +100,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
>  obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
>  obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
> -obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
> +obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
>  obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
>  obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
>  obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
> diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
> similarity index 100%
> rename from drivers/cpufreq/ls1x-cpufreq.c
> rename to drivers/cpufreq/loongson1-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
