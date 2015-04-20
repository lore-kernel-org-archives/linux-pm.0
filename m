From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Mon, 20 Apr 2015 20:28:37 +0200
Message-ID: <1429554517.14597.38.camel@x220>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
	 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, fan.chen@mediatek.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-04-20 at 17:27 +0800, pi-cheng.chen wrote:
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
 
> +config ARM_MT8173_CPUFREQ
> +	bool "Mediatek MT8173 CPUFreq support"
> +	depends on ARCH_MEDIATEK && REGULATOR
> +	help
> +	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.

> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile

> +obj-$(CONFIG_ARM_MT8173_CPUFREQ)	+= mt8173-cpufreq.o

ARM_MT8173_CPUFREQ is a bool symbol, so mt8173-cpufreq.o will never be
part of a module.

(If that's incorrect you can stop reading here.)

> --- /dev/null
> +++ b/drivers/cpufreq/mt8173-cpufreq.c

> +#include <linux/module.h>

I guess this include is not needed. And, for what it's worth,
    make ARCH=arm CROSS_COMPILE=arm-linux-gnu- drivers/cpufreq/mt8173-cpufreq.o

compiles silently even if it's dropped.

> +module_init(mt8173_cpufreq_driver_init);

According to include/linux/init.h, for built-in only code, this is
equivalent to device_initcall([...]). And two runs of
    make ARCH=arm CROSS_COMPILE=arm-linux-gnu- drivers/cpufreq/mt8173-cpufreq.i

confirm that.

Thanks,


Paul Bolle
