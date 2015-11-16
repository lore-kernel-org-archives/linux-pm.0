From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: mediatek: fix build error
Date: Mon, 16 Nov 2015 23:35:46 +0100
Message-ID: <4657866.VKIEhOptFQ@vostro.rjw.lan>
References: <3905943.jgsUmEgmnP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63836 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751905AbbKPWGS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 17:06:18 -0500
In-Reply-To: <3905943.jgsUmEgmnP@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Monday, November 16, 2015 10:27:55 PM Arnd Bergmann wrote:
> The recently added mt8173 cpufreq driver relies on the cpu topology
> that is always present on ARM64 but optional on ARM32:
> 
> drivers/cpufreq/mt8173-cpufreq.c: In function 'mtk_cpufreq_init':
> drivers/cpufreq/mt8173-cpufreq.c:441:30: error: 'cpu_topology' undeclared (first use in this function)
>   cpumask_copy(policy->cpus, &cpu_topology[policy->cpu].core_sibling);
> 
> This refines the Kconfig dependencies so that we can still build on
> ARM32, but only if COMPILE_TEST is selected and the CPU topology
> code is present.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1582c1c016b0..8014c2307332 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -84,6 +84,7 @@ config ARM_KIRKWOOD_CPUFREQ
>  config ARM_MT8173_CPUFREQ
>  	bool "Mediatek MT8173 CPUFreq support"
>  	depends on ARCH_MEDIATEK && REGULATOR
> +	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
>  	depends on !CPU_THERMAL || THERMAL=y
>  	select PM_OPP
>  	help
> 

Applied, thanks!

Rafael

