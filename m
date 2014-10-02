From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 4/7] qcom: pm: Add cpu low power mode functions
Date: Thu, 2 Oct 2014 10:50:36 +0100
Message-ID: <20141002095036.GA1938@e102568-lin.cambridge.arm.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 27, 2014 at 01:58:12AM +0100, Lina Iyer wrote:

[...]

> diff --git a/drivers/soc/qcom/pm.c b/drivers/soc/qcom/pm.c
> new file mode 100644
> index 0000000..a2f7d72
> --- /dev/null
> +++ b/drivers/soc/qcom/pm.c
> @@ -0,0 +1,109 @@
> +/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> +
> +#include <soc/qcom/pm.h>
> +#include <soc/qcom/scm.h>
> +#include <soc/qcom/scm-boot.h>
> +#include <soc/qcom/spm.h>
> +
> +#define SCM_CMD_TERMINATE_PC	(0x2)
> +#define SCM_FLUSH_FLAG_MASK	(0x3)
> +#define SCM_L2_ON 		(0x0)
> +#define SCM_L2_OFF		(0x1)
> +
> +
> +static int set_up_boot_address(void *entry, int cpu)
> +{
> +	static int flags[NR_CPUS] = {
> +		SCM_FLAG_WARMBOOT_CPU0,
> +		SCM_FLAG_WARMBOOT_CPU1,
> +		SCM_FLAG_WARMBOOT_CPU2,
> +		SCM_FLAG_WARMBOOT_CPU3,
> +	};
> +	static DEFINE_PER_CPU(void *, last_known_entry);
> +
> +	if (entry == per_cpu(last_known_entry, cpu))
> +		return 0;
> +
> +	per_cpu(last_known_entry, cpu) = entry;
> +	return scm_set_boot_addr(virt_to_phys(entry), flags[cpu]);
> +}
> +
> +static int qcom_pm_collapse(unsigned long int unused)
> +{
> +	int ret;
> +	u32 flag;
> +
> +	ret = set_up_boot_address(cpu_resume, raw_smp_processor_id());
> +	if (ret) {
> +		pr_err("Failed to set warm boot address for cpu %d\n",
> +				raw_smp_processor_id());
> +		return ret;
> +	}
> +
> +	flag = SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
> +	scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);

Function call above does not return IIUC (ie it returns through cpu_resume),
add a comment to clarify please.

> +
> +	return 0;
> +}
> +
> +/**
> + * qcom_cpu_pm_enter_sleep(): Enter a low power mode on current cpu
> + *
> + * @mode - sleep mode to enter
> + *
> + * The code should be called with interrupts disabled and on the core on
> + * which the low power mode is to be executed.
> + *
> + */
> +static int qcom_cpu_pm_enter_sleep(enum pm_sleep_mode mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case PM_SLEEP_MODE_SPC:
> +		qcom_spm_set_low_power_mode(SPM_MODE_POWER_COLLAPSE);
> +		ret = cpu_suspend(0, qcom_pm_collapse);
> +		break;
> +	default:
> +	case PM_SLEEP_MODE_WFI:
> +		qcom_spm_set_low_power_mode(SPM_MODE_CLOCK_GATING);
> +		ret = cpu_do_idle();

Hmmm...are we sure the ret value you get from cpu_do_idle() is correct ?

Maybe I am missing something but I do not think that the cpu_do_idle
implementation (in assembly files mm/proc-* called through cpu_do_idle()
macro) returns a proper value, it seems to me that it "returns" whatever is
present in r0 at the time of the call, which might not be what you want.

Am I missing something here ? I do not think you should rely on the
cpu_do_idle() return value, at least for the moment.

> +		break;
> +	}
> +
> +	local_irq_enable();

This looks wrong to me. You end up running the CPU PM notifiers with irqs
enabled, among other issues.

Lorenzo
