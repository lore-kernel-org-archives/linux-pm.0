From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: rockchip: add driver
Date: Wed, 23 Mar 2016 10:10:33 +0530
Message-ID: <20160323044033.GQ5272@vireshk-i7>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35406 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbcCWEki (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2016 00:40:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id n5so8418570pfn.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2016 21:40:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1458699487-58470-1-git-send-email-xf@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Feng Xiao <xf@rock-chips.com>
Cc: linux@arm.linux.org.uk, heiko@sntech.de, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com

On 23-03-16, 10:18, Feng Xiao wrote:
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 14b1f93..1786315 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -97,6 +97,16 @@ config ARM_OMAP2PLUS_CPUFREQ
>  	depends on ARCH_OMAP2PLUS
>  	default ARCH_OMAP2PLUS
>  
> +config ARM_ROCKCHIP_CPUFREQ
> +	tristate "Rockchip CPUfreq driver"

Since you are allowing it to be built as a module ...

> +	depends on ARCH_ROCKCHIP && CPUFREQ_DT
> +	select PM_OPP
> +	help
> +	  This adds the CPUFreq driver support for Rockchip SoCs.
> +	  The driver will directly use cpufreq-dt driver as backend.
> +
> +	  If in doubt, say N.

> +++ b/drivers/cpufreq/rockchip-cpufreq.c
> +static int __init rockchip_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rockchip_compat); i++) {
> +		if (of_machine_is_compatible(rockchip_compat[i])) {
> +			pdev = platform_device_register_simple("cpufreq-dt",
> +							       -1, NULL, 0);
> +			return PTR_ERR_OR_ZERO(pdev);
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +module_init(rockchip_cpufreq_driver_init);

You need a module exit as well to remove the device. Otherwise following
sequence will give you errors:

insmod rockchip-cpufreq.ko
rmmod rockchip-cpufreq.ko
insmod rockchip-cpufreq.ko //Errors on this..

So, either don't allow it to be built as a module or fix the module-exit path.

-- 
viresh
