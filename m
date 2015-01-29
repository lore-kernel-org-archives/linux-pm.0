From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Thu, 29 Jan 2015 13:42:32 +0100
Message-ID: <1642077.OrkdxhO2uI@wuerfel>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de> <2157802.ranbh8xTdL@wuerfel> <CAKohpo=An5Jm4qfhWaE96hPKyKVQfsZPdvrgxKH2ymvyvgQ_pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54945 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbbA2Mmp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 07:42:45 -0500
In-Reply-To: <CAKohpo=An5Jm4qfhWaE96hPKyKVQfsZPdvrgxKH2ymvyvgQ_pQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Eduardo Valentin <edubezval@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Thursday 29 January 2015 15:40:15 Viresh Kumar wrote:
>  obj-$(CONFIG_ARCH_DAVINCI)             += davinci-cpufreq.o
>  obj-$(CONFIG_UX500_SOC_DB8500)         += dbx500-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       += exynos-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos-cpufreq.o exynos4210-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos-cpufreq.o exynos4x12-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos-cpufreq.o exynos5250-cpufreq.o
> 

I'd have to try it, but this might fail if one of the three drivers
is built-in and another one is a module.

	Arnd
