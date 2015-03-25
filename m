From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 6/8] ARM: cpuidle: Enable the ARM64 driver for both
 ARM32/ARM64
Date: Wed, 25 Mar 2015 21:54:10 +0100
Message-ID: <1427316850.10958.58.camel@x220>
References: <55127A53.8050206@linaro.org>
	 <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
	 <1427274436-21916-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427274436-21916-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, lina.iyer@linaro.org, Lorenzo.Pieralisi@arm.com
List-Id: linux-pm@vger.kernel.org

A few nits are all I spotted.

On Wed, 2015-03-25 at 10:07 +0100, Daniel Lezcano wrote:
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm

> +config ARM_CPUIDLE
> +        bool "Generic ARM/ARM64 CPU idle Driver"
> +        select DT_IDLE_STATES
> +        help
> +          Select this to enable generic cpuidle driver for ARM.
> +          It provides a generic idle driver whose idle states are configured
> +          at run-time through DT nodes. The CPUidle suspend backend is
> +          initialized by calling the CPU operations init idle hook
> +          provided by architecture code.

Start with a tab instead of 8 spaces, please.

> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-arm.c

> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Is this include actually needed? I haven't tried building this without
that include, but I spotted nothing obviously module related in this
file.

> +#include <linux/of.h>
> +
> +#include <asm/cpuidle.h>
> +
> +#include "dt_idle_states.h"

> +static struct cpuidle_driver arm_idle_driver = {
> +	.name = "arm_idle",
> +	.owner = THIS_MODULE,

Since this can only be built in, THIS_MODULE will (basically) be
equivalent to NULL according to include/linux/export.h. So I suppose
this line can be dropped.

> +	/*
> +	 * State at index 0 is standby wfi and considered standard
> +	 * on all ARM platforms. If in some platforms simple wfi
> +	 * can't be used as "state 0", DT bindings must be implemented
> +	 * to work around this issue and allow installing a special
> +	 * handler for idle state index 0.
> +	 */
> +	.states[0] = {
> +		.enter                  = arm_enter_idle_state,
> +		.exit_latency           = 1,
> +		.target_residency       = 1,
> +		.power_usage		= UINT_MAX,
> +		.name                   = "WFI",
> +		.desc                   = "ARM WFI",
> +	}
> +};

I did notice that these two nits are already present in
drivers/cpuidle/cpuidle-arm64.c. But since this patch is not just moving
that file's content around, you might as well look into those two nits.


Paul Bolle
