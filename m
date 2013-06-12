From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 06/11] cpufreq: imx: select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 19:38:18 +0800
Message-ID: <20130612113817.GC13274@S2101-09.ap.freescale.net>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
 <7568bf22f9e40425bb0fe86cd6f44c4dc2d0c7c5.1371022830.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:51464
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756319Ab3FLLh7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 07:37:59 -0400
Content-Disposition: inline
In-Reply-To: <7568bf22f9e40425bb0fe86cd6f44c4dc2d0c7c5.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de

On Wed, Jun 12, 2013 at 01:45:13PM +0530, Viresh Kumar wrote:
> CPUFreq driver of this platform uses APIs from freq_table.c and so must select
> CPU_FREQ_TABLE.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 891dd1c..dc26303 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -72,6 +72,7 @@ config ARM_IMX6Q_CPUFREQ
>  	tristate "Freescale i.MX6Q cpufreq support"
>  	depends on SOC_IMX6Q
>  	depends on REGULATOR_ANATOP
> +	select CPU_FREQ_TABLE
>  	help
>  	  This adds cpufreq driver support for Freescale i.MX6Q SOC.
>  
> -- 
> 1.7.12.rc2.18.g61b472e
> 

