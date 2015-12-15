From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Tue, 15 Dec 2015 12:41:38 +0900
Message-ID: <566F8BF2.20606@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
 <1450075104-13705-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47181 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285AbbLODlq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 22:41:46 -0500
In-reply-to: <1450075104-13705-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 14.12.2015 15:38, Chanwoo Choi wrote:
> This patch adds the generic exynos bus frequency driver for AMBA AXI bus
> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exynos SoC
> have the common architecture for bus between DRAM and sub-blocks in SoC.
> This driver can support the generic bus frequency driver for Exynos SoCs.
> 
> In devicetree, Each bus block has a bus clock, regulator, operation-point
> and devfreq-event devices which measure the utilization of each bus block.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [linux.amoon: Tested on Odroid U3]
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/devfreq/Kconfig             |  15 ++
>  drivers/devfreq/Makefile            |   1 +
>  drivers/devfreq/exynos/Makefile     |   1 +
>  drivers/devfreq/exynos/exynos-bus.c | 449 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 466 insertions(+)
>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 64281bb2f650..55ec774f794c 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -66,6 +66,21 @@ config DEVFREQ_GOV_USERSPACE
>  
>  comment "DEVFREQ Drivers"
>  
> +config ARM_EXYNOS_BUS_DEVFREQ
> +	bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
> +	depends on ARCH_EXYNOS
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	select DEVFREQ_EVENT_EXYNOS_PPMU
> +	select PM_DEVFREQ_EVENT
> +	select PM_OPP
> +	help
> +	  This adds the common DEVFREQ driver for Exynos Memory bus. Exynos
> +	  Memory bus has one more group of memory bus (e.g, MIF and INT block).
> +	  Each memory bus group could contain many memoby bus block. It reads
> +	  PPMU counters of memory controllers by using DEVFREQ-event device
> +	  and adjusts the operating frequencies and voltages with OPP support.
> +	  This does not yet operate with optimal voltages.
> +
>  config ARM_EXYNOS4_BUS_DEVFREQ
>  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
>  	depends on (CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412) && !ARCH_MULTIPLATFORM
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 5134f9ee983d..375ebbb4fcfb 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>  
>  # DEVFREQ Drivers
> +obj-$(CONFIG_ARCH_EXYNOS)		+= exynos/

Why limiting it to ARCH_EXYNOS? Are there real dependencies on exynos
mach code? Or on ARM code?

If not, then this probably should be obj-y to allow compile testing.
Particular objects would be selected by ARM_EXYNOS_BUS_DEVFREQ.

Best regards,
Krzysztof

