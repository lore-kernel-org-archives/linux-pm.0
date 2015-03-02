From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 3/3] firmware: qcom: scm: Support cpu power down
 through SCM
Date: Mon, 2 Mar 2015 13:58:05 -0700
Message-ID: <20150302205805.GC1160@linaro.org>
References: <1425328207-58415-1-git-send-email-lina.iyer@linaro.org>
 <1425328207-58415-4-git-send-email-lina.iyer@linaro.org>
 <D48129A5-15F4-47BF-BA16-8B9308E3AD13@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D48129A5-15F4-47BF-BA16-8B9308E3AD13@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org, Stephen Boyd <sboyd@codeauraro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 02 2015 at 13:52 -0700, Kumar Gala wrote:
>
>On Mar 2, 2015, at 2:30 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> Support powering down the calling cpu, by trapping into SCM. This
>> termination function triggers the ARM cpu to execute WFI instruction,
>> causing the power controller to safely power the cpu down.
>>
>> Caches may be flushed before powering down the cpu. If cache controller
>> is set to turn off when the cpu is powered down, then the flags argument
>> indicates to the secure mode to flush its cache lines before executing
>> WFI.The warm boot reset address for the cpu should be set before the
>> calling into this function for the cpu to resume.
>>
>> The original code for the qcom_scm_call_atomic1() comes from a patch by
>> Stephen Boyd [1]. The function scm_call_atomic1() has been cherry picked
>> and renamed to match the convention used in this file. Since there are
>> no users of scm_call_atomic2(), the function is not included.
>>
>> [1]. https://lkml.org/lkml/2014/8/4/765
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeauraro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>> drivers/firmware/qcom_scm.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
>> include/linux/qcom_scm.h    |  6 ++++-
>> 2 files changed, 62 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 4d8ede4..994b50f 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -311,6 +311,45 @@ out:
>> 	return ret;
>> }
>>
>> +#define SCM_CLASS_REGISTER	(0x2 << 8)
>> +#define SCM_MASK_IRQS		BIT(5)
>> +#define SCM_ATOMIC(svc, cmd, n) (((((svc) << 10)|((cmd) & 0x3ff)) << 12) | \
>> +				SCM_CLASS_REGISTER | \
>> +				SCM_MASK_IRQS | \
>> +				(n & 0xf))
>> +
>> +/**
>> + * qcom_scm_call_atomic1() - Send an atomic SCM command with one argument
>> + * @svc_id: service identifier
>> + * @cmd_id: command identifier
>> + * @arg1: first argument
>> + *
>> + * This shall only be used with commands that are guaranteed to be
>> + * uninterruptable, atomic and SMP safe.
>> + */
>> +static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
>> +{
>> +	int context_id;
>> +
>> +	register u32 r0 asm("r0") = SCM_ATOMIC(svc, cmd, 1);
>> +	register u32 r1 asm("r1") = (u32)&context_id;
>> +	register u32 r2 asm("r2") = arg1;
>> +
>> +	asm volatile(
>> +			__asmeq("%0", "r0")
>> +			__asmeq("%1", "r0")
>> +			__asmeq("%2", "r1")
>> +			__asmeq("%3", "r2")
>> +#ifdef REQUIRES_SEC
>> +			".arch_extension sec\n"
>> +#endif
>> +			"smc    #0      @ switch to secure world\n"
>> +			: "=r" (r0)
>> +			: "r" (r0), "r" (r1), "r" (r2)
>> +			: "r3");
>> +	return r0;
>> +}
>> +
>> u32 qcom_scm_get_version(void)
>> {
>> 	int context_id;
>> @@ -435,3 +474,21 @@ int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
>> 	return ret;
>> }
>> EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
>> +
>> +#define QCOM_SCM_CMD_TERMINATE_PC	0x2
>> +#define QCOM_SCM_FLUSH_FLAG_MASK	0x3
>
>why is the mask 0x3 and not 0x1?
>
Per the secure code, this is a 2 bit entity, hence a 0x3 for the mask.

>> +
>> +/**
>> + * qcom_scm_cpu_power_down() - Power down the cpu
>> + * @flags - Flags to flush cache
>> + *
>> + * This is an end point to power down cpu. If there was a pending interrupt,
>> + * the control would return from this function, otherwise, the cpu jumps to the
>> + * warm boot entry point set for this cpu upon reset.
>> + */
>> +void qcom_scm_cpu_power_down(u32 flags)
>> +{
>> +	qcom_scm_call_atomic1(QCOM_SCM_SVC_BOOT, QCOM_SCM_CMD_TERMINATE_PC,
>> +			flags & QCOM_SCM_FLUSH_FLAG_MASK);
>> +}
>> +EXPORT_SYMBOL(qcom_scm_cpu_power_down);
>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>> index 95ef72a..0f26f44 100644
>> --- a/include/linux/qcom_scm.h
>> +++ b/include/linux/qcom_scm.h
>> @@ -1,4 +1,4 @@
>> -/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
>> +/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
>>  * Copyright (C) 2015 Linaro Ltd.
>>  *
>>  * This program is free software; you can redistribute it and/or modify
>> @@ -13,8 +13,12 @@
>> #ifndef __QCOM_SCM_H
>> #define __QCOM_SCM_H
>>
>> +#define QCOM_SCM_L2_ON		0x0
>> +#define QCOM_SCM_L2_OFF		0x1
>
>One, can you move this below qcom_scm_set_warm_boot_addr so they are closer to qcom_scm_cpu_power_down.  Also, we probably need to prefix the names to be clear the flags are associated with qcom_scm_cpu_power_down.  QCOM_SCM_CPU_PWR_DOWN_{L2_ON,L2_OFF}?
>

Okay.

>> +
>> extern int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
>> extern int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus);
>> +extern void qcom_scm_cpu_power_down(u32 flags);
>>
>> #define QCOM_SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
>>
>> --
>> 2.1.0
>>
>
>- k
>
>-- 
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
