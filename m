From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 4/7] qcom: pm: Add cpu low power mode functions
Date: Tue, 30 Sep 2014 10:03:10 -0600
Message-ID: <20140930160310.GC528@ilina-mac.local>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
 <5429ED1D.5060809@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:59397 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaI3QDP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 12:03:15 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so5436759pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 09:03:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5429ED1D.5060809@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org

On Mon, Sep 29 2014 at 17:37 -0600, Stephen Boyd wrote:
>On 09/26/14 17:58, Lina Iyer wrote:
>> Based on work by many authors, available at codeaurora.org
>>
>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> [lina: simplify the driver for an initial submission, add commit text
>> description of idle states]
>
>Maintainer tags don't really make sense unless there is another author.
>
Hmm.. Since this patch is a derivative work, I wanted to clarify, what
changed seems important. The work was done by many authors. Adding
signed-off from everybody who could have contributed to the patch
downstream is confusing.
I would be okay removing it.

> +
[...]
>> +static int qcom_pm_collapse(unsigned long int unused)
>> +{
>> +	int ret;
>> +	u32 flag;
>> +
>> +	ret = set_up_boot_address(cpu_resume, raw_smp_processor_id());
>
>Preemption better be off here, so why are we using raw_smp_processor_id()?
>
True, so raw_ returns without premeption disable, no?

>> +	if (ret) {
>> +		pr_err("Failed to set warm boot address for cpu %d\n",
>> +				raw_smp_processor_id());
>
>Stuff cpu into a local variable?
>
Yeah
>> +		return ret;
>> +	}
>> +
>> +	flag = SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
>> +	scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qcom_cpu_pm_enter_sleep(): Enter a low power mode on current cpu
>> + *
>> + * @mode - sleep mode to enter
>> + *
>> + * The code should be called with interrupts disabled and on the core on
>> + * which the low power mode is to be executed.
>> + *
>> + */
>> +static int qcom_cpu_pm_enter_sleep(enum pm_sleep_mode mode)
>> +{
>> +	int ret;
>> +
>> +	switch (mode) {
>> +	case PM_SLEEP_MODE_SPC:
>> +		qcom_spm_set_low_power_mode(SPM_MODE_POWER_COLLAPSE);
>
>Isn't it a one-to-one between PM_SLEEP_MODE_SPC and
>SPM_MODE_POWER_COLLAPSE? The enum to enum map seems overly complicated.
>
Not really. SPM modes, differ when the idle state has to notify RPM. It
does not have 2 enums for those modes, but uses an overloaded enum with
an additional flag.

>> +		ret = cpu_suspend(0, qcom_pm_collapse);
>> +		break;
>> +	default:
>> +	case PM_SLEEP_MODE_WFI:
>> +		qcom_spm_set_low_power_mode(SPM_MODE_CLOCK_GATING);
>> +		ret = cpu_do_idle();
>> +		break;
>> +	}
>> +
>> +	local_irq_enable();
>> +
>> +	return ret;
>> +}
>> +
>> +static struct platform_device qcom_cpuidle_device = {
>> +	.name              = "qcom_cpuidle",
>> +	.id                = -1,
>> +	.dev.platform_data = qcom_cpu_pm_enter_sleep,
>> +};
>
>This doesn't need to be static. Use platform_device_register_full() instead.
>
Okay
>> +
>> +static int __init qcom_pm_device_init(void)
>> +{
>> +	platform_device_register(&qcom_cpuidle_device);
>> +
>> +	return 0;
>> +}
>> +device_initcall(qcom_pm_device_init);
>
>modules?
>
Why? An earlier initialization helps with power saving

>> diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
>> new file mode 100644
>> index 0000000..563b9c3
>> --- /dev/null
>> +++ b/include/soc/qcom/pm.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef __QCOM_PM_H
>> +#define __QCOM_PM_H
>> +
>> +enum pm_sleep_mode {
>> +	PM_SLEEP_MODE_WFI,
>> +	PM_SLEEP_MODE_RET,
>> +	PM_SLEEP_MODE_SPC,
>> +	PM_SLEEP_MODE_PC,
>> +	PM_SLEEP_MODE_NR,
>> +};
>> +
>> +#endif  /* __QCOM_PM_H */
>
>Hopefully this header is not necessary.
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>hosted by The Linux Foundation
>
