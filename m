From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device creation support
Date: Tue, 29 Mar 2016 17:14:33 +0200
Message-ID: <5412084.gVvuDFzkvo@wuerfel>
References: <cover.1459233524.git.viresh.kumar@linaro.org> <2f2947872d41ecccc393d6ae95eafc72f205e03c.1459233524.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:63374 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbcC2PO5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 11:14:57 -0400
In-Reply-To: <2f2947872d41ecccc393d6ae95eafc72f205e03c.1459233524.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 29 March 2016 12:09:48 Viresh Kumar wrote:
> Multiple platforms are using the generic cpufreq-dt driver now, and all
> of them are required to create a platform device with name "cpufreq-dt",
> in order to get the cpufreq-dt probed.
> 
> Many of them do it from platform code, others have special drivers just
> to do that.
> 
> It would be more sensible to do this at a generic place, where all such
> platform can mark their entries.
> 
> This patch adds a separate file to get this device created. Currently
> the compat list of platforms that we support is empty, and will be
> filled in as and when we move platforms to use it.
> 
> It always compiles as part of the kernel and so doesn't need a
> module-exit operation.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/cpufreq/Kconfig              | 11 +++++++++
>  drivers/cpufreq/Makefile             |  1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c | 48 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/cpufreq/cpufreq-dt-platdev.c
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index a7f45853c103..08573d54105b 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -191,6 +191,7 @@ config CPUFREQ_DT
>  	depends on HAVE_CLK && OF
>  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
>  	depends on !CPU_THERMAL || THERMAL
> +	select CPUFREQ_DT_PLATDEV
>  	select PM_OPP
>  	help
>  	  This adds a generic DT based cpufreq driver for frequency management.
> @@ -199,6 +200,16 @@ config CPUFREQ_DT
>  
>  	  If in doubt, say N.
>  
> +config CPUFREQ_DT_PLATDEV
> +	bool
> +	depends on CPUFREQ_DT

The 'depends on' line is redundant as you always 'select' the code
from CPUFREQ_DT. Since they are always set together, you can also
just drop the new symbol, or put the new code into the same file.

> +struct cpufreq_dt_compat {
> +	const char *compatible;
> +	const void *data;
> +	size_t size;
> +};
> +
> +static struct cpufreq_dt_compat compat[] = {
> +};

The 'data' here is alway 'struct cpufreq_dt_platform_data' or NULL,
and the size can be derived from that. If we add this into the opp
platform interfaces, both can go away.

> +static int __init cpufreq_dt_platdev_init(void)
> +{
> +	struct platform_device *pdev;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(compat); i++) {
> +		if (!of_machine_is_compatible(compat[i].compatible))
> +			continue;
> +
> +		pdev = platform_device_register_data(NULL, "cpufreq-dt", -1,
> +						     compat[i].data,
> +						     compat[i].size);
> +

and then this can become 

	if (of_device_match(of_root, compat))
		platform_device_register_simple(NULL, "cpufreq-dt", 0, NULL, 0);

	Arnd
