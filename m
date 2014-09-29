From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 4/7] qcom: pm: Add cpu low power mode functions
Date: Mon, 29 Sep 2014 16:37:01 -0700
Message-ID: <5429ED1D.5060809@codeaurora.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 09/26/14 17:58, Lina Iyer wrote:
> Based on work by many authors, available at codeaurora.org
>
> Add interface layer to abstract and handle hardware specific
> functionality for executing various cpu low power modes in QCOM
> chipsets.
>
> QCOM cpus support multiple low power modes. The C-States are defined as -
>
>     * WFI (clock gating)
>     * Retention (clock gating at lower power)
>     * Standalone Power Collapse (Standalone PC or SPC) - The power to
>     	the cpu is lost and the cpu warmboots.
>     * Power Collapse (PC) - Same as SPC, but is a cognizant of the fact
>     	that the SoC may do deeper sleep modes.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [lina: simplify the driver for an initial submission, add commit text
> description of idle states]

Maintainer tags don't really make sense unless there is another author.

> ---
>  drivers/soc/qcom/Makefile |   2 +-
>  drivers/soc/qcom/pm.c     | 109 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/pm.h     |  26 +++++++++++
>  3 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/qcom/pm.c
>  create mode 100644 include/soc/qcom/pm.h
>
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 20b329f..19900ed 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,4 +1,4 @@
>  obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
> -obj-$(CONFIG_QCOM_PM)	+=	spm.o
> +obj-$(CONFIG_QCOM_PM)	+=	spm.o pm.o
>  CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
>  obj-$(CONFIG_QCOM_SCM) += scm.o scm-boot.o
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

Preemption better be off here, so why are we using raw_smp_processor_id()?

> +	if (ret) {
> +		pr_err("Failed to set warm boot address for cpu %d\n",
> +				raw_smp_processor_id());

Stuff cpu into a local variable?

> +		return ret;
> +	}
> +
> +	flag = SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
> +	scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);
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

Isn't it a one-to-one between PM_SLEEP_MODE_SPC and
SPM_MODE_POWER_COLLAPSE? The enum to enum map seems overly complicated.

> +		ret = cpu_suspend(0, qcom_pm_collapse);
> +		break;
> +	default:
> +	case PM_SLEEP_MODE_WFI:
> +		qcom_spm_set_low_power_mode(SPM_MODE_CLOCK_GATING);
> +		ret = cpu_do_idle();
> +		break;
> +	}
> +
> +	local_irq_enable();
> +
> +	return ret;
> +}
> +
> +static struct platform_device qcom_cpuidle_device = {
> +	.name              = "qcom_cpuidle",
> +	.id                = -1,
> +	.dev.platform_data = qcom_cpu_pm_enter_sleep,
> +};

This doesn't need to be static. Use platform_device_register_full() instead.

> +
> +static int __init qcom_pm_device_init(void)
> +{
> +	platform_device_register(&qcom_cpuidle_device);
> +
> +	return 0;
> +}
> +device_initcall(qcom_pm_device_init);

modules?

> diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
> new file mode 100644
> index 0000000..563b9c3
> --- /dev/null
> +++ b/include/soc/qcom/pm.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __QCOM_PM_H
> +#define __QCOM_PM_H
> +
> +enum pm_sleep_mode {
> +	PM_SLEEP_MODE_WFI,
> +	PM_SLEEP_MODE_RET,
> +	PM_SLEEP_MODE_SPC,
> +	PM_SLEEP_MODE_PC,
> +	PM_SLEEP_MODE_NR,
> +};
> +
> +#endif  /* __QCOM_PM_H */

Hopefully this header is not necessary.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
