From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH v1] ARM: tango: add Suspend-to-RAM support
Date: Wed, 29 Jun 2016 18:48:18 +0100
Message-ID: <577409E2.7020106@arm.com>
References: <5773D3FB.4030101@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55866 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbcF2RsX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jun 2016 13:48:23 -0400
In-Reply-To: <5773D3FB.4030101@sigmadesigns.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Sebastian Frias <sf84@laposte.net>, Robin Murphy <robin.murphy@arm.com>



On 29/06/16 14:58, Marc Gonzalez wrote:
> Ask firmware to put RAM in self-refresh mode and power system down.
>
>      echo mem > /sys/power/state
>
> See Documentation/power/states.txt
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> This is a RFC because I have a few doubts:
> 1) return value when tango_suspend() fails and unexpectedly returns (I used -EIO)
> 2) conditionally building pm.c (using CONFIG_SUSPEND? CONFIG_PM_SLEEP? other?)
> 3) .valid is required, right?
> ---
>   arch/arm/mach-tango/Makefile |  1 +
>   arch/arm/mach-tango/pm.c     | 37 +++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-tango/smc.h    |  1 +
>   3 files changed, 39 insertions(+)
>   create mode 100644 arch/arm/mach-tango/pm.c
>
> diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
> index 7ca753aa9fb6..822b7ca803c6 100644
> --- a/arch/arm/mach-tango/Makefile
> +++ b/arch/arm/mach-tango/Makefile
> @@ -3,3 +3,4 @@ AFLAGS_smc.o := -Wa,-march=armv7-a$(plus_sec)
>
>   obj-y += setup.o smc.o xenv.o
>   obj-$(CONFIG_SMP) += platsmp.o
> +obj-$(CONFIG_SUSPEND) += pm.o
> diff --git a/arch/arm/mach-tango/pm.c b/arch/arm/mach-tango/pm.c
> new file mode 100644
> index 000000000000..08a39beaea09
> --- /dev/null
> +++ b/arch/arm/mach-tango/pm.c
> @@ -0,0 +1,37 @@
> +#include <linux/init.h>
> +#include <linux/suspend.h>
> +#include <asm/suspend.h>
> +#include "smc.h"
> +
> +static int tango_pm_powerdown(unsigned long arg)
> +{
> +	tango_suspend(virt_to_phys(cpu_resume));
> +
> +	return -EIO; /* tango_suspend has failed */
> +}
> +
> +static int tango_pm_enter(suspend_state_t state)
> +{
> +	if (state == PM_SUSPEND_MEM)
> +		return cpu_suspend(0, tango_pm_powerdown);
> +
> +	return -EINVAL;
> +}
> +
> +static int tango_pm_valid(suspend_state_t state)
> +{
> +	return state == PM_SUSPEND_MEM;
> +}
> +
> +static const struct platform_suspend_ops tango_pm_ops = {
> +	.enter = tango_pm_enter,
> +	.valid = tango_pm_valid,

You can use suspend_valid_only_mem instead which does exactly same thing.

-- 
Regards,
Sudeep

-- 
Regards,
Sudeep
