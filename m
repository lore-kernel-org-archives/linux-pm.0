From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2 3/7] driver/core: cpu: initialize opp table
Date: Wed, 21 May 2014 18:26:28 +0100
Message-ID: <537CE1C4.9050008@arm.com>
References: <cover.1400670427.git.viresh.kumar@linaro.org> <b59df199b373191791afcccd627d900ce07afa71.1400670427.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36910 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaEUR00 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 13:26:26 -0400
In-Reply-To: <b59df199b373191791afcccd627d900ce07afa71.1400670427.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <Arvind.Chauhan@arm.com>, "inderpal.s@samsung.com" <inderpal.s@samsung.com>, "nm@ti.com" <nm@ti.com>, "chander.kashyap@linaro.org" <chander.kashyap@linaro.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>



On 21/05/14 12:10, Viresh Kumar wrote:
> All drivers expecting CPU's OPPs from device tree initialize OPP table using
> of_init_opp_table() and there is nothing driver specific in that. They all do it
> in the same way adding to code redundancy.
>
> It would be better if we can get rid of code redundancy by initializing CPU OPPs
> from core code for all CPUs that have a "operating-points" property defined in
> their node.
>
> This patch initializes OPPs as soon as CPU device is registered in
> register_cpu().
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/base/cpu.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 006b1bc..853e99e 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -16,6 +16,7 @@
>   #include <linux/acpi.h>
>   #include <linux/of.h>
>   #include <linux/cpufeature.h>
> +#include <linux/pm_opp.h>
>
>   #include "base.h"
>
> @@ -322,6 +323,25 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
>   }
>   #endif
>
> +#if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
> +static inline void of_init_cpu_opp_table(struct cpu *cpu)
> +{
> +	int error;
> +
> +	/* Initialize CPU's OPP table */
> +	error = of_init_opp_table(&cpu->dev);
> +	if (!error)
> +		dev_info(&cpu->dev, "%s: created OPP table for cpu: %d\n",
> +			 __func__, cpu->dev.id);
> +	/* Print error only if there is an issue with OPP table */
> +	else if (error != -ENOSYS && error != -ENODEV)
> +		dev_err(&cpu->dev, "%s: failed to init OPP table for cpu%d, err: %d\n",
> +			__func__, cpu->dev.id, error);
> +}
> +#else
> +static inline void of_init_cpu_opp_table(struct cpu *cpu) {}

Sorry I missed this earlier, main idea of this wrapper is not to have any
config dependency and hide error handling details for non-DT platforms. Since
of_init_opp_table has dummy implementation, you really don't need this dummy
implementation again here.

Regards,
Sudeep

