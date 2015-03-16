From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC PATCH v15 02/11] ARM: qcom: Add Subsystem Power Manager
 (SPM) driver
Date: Mon, 16 Mar 2015 16:51:27 -0600
Message-ID: <20150316225127.GC501@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-3-git-send-email-lina.iyer@linaro.org>
 <5507506B.6060201@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37367 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854AbbCPWv2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 18:51:28 -0400
Received: by igcqo1 with SMTP id qo1so57133453igc.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2015 15:51:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5507506B.6060201@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Mon, Mar 16 2015 at 15:51 -0600, Stephen Boyd wrote:
>On 03/09/15 08:16, Lina Iyer wrote:
>> +
>> +static int qcom_idle_enter(int cpu, unsigned long index)
>> +{
>> +	if (!per_cpu(qcom_idle_ops, cpu)[index])
>> +		return -EOPNOTSUPP;
>
>Is this case still happening?
>
I think, I can remove it safely now.
>> +
>> +	return per_cpu(qcom_idle_ops, cpu)[index](cpu);
>> +}
>> +
>> +const struct of_device_id qcom_idle_state_match[] __initconst = {
>
>static?
>
Ok

>> +	{ .compatible = "qcom,idle-state-stby", .data = qcom_cpu_standby },
>> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_cpu_spc },
>> +	{ },
>> +};
>> +
>> +static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
>> +{
>> +	const struct of_device_id *match_id;
>> +	struct device_node *state_node;
>> +	int i;
>> +	int state_count = 0;
>> +	idle_fn idle_fns[CPUIDLE_STATE_MAX];
>> +	idle_fn *fns;
>> +	cpumask_t mask;
>> +	bool use_scm_power_down = false;
>> +
>> +	for (i = 0; ; i++) {
>> +		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
>> +		if (!state_node)
>> +			break;
>> +
>> +		if (!of_device_is_available(state_node))
>> +			continue;
>> +
>> +		if (i == CPUIDLE_STATE_MAX) {
>> +			pr_warn("%s: cpuidle states reached max possible\n",
>> +					__func__);
>> +			break;
>> +		}
>> +
>> +		match_id = of_match_node(qcom_idle_state_match, state_node);
>> +		if (!match_id)
>> +			return -ENODEV;
>> +
>> +		idle_fns[state_count] = match_id->data;
>> +
>> +		/* Check if any of the states allow power down */
>> +		if (match_id->data == qcom_cpu_spc)
>> +			use_scm_power_down = true;
>> +
>> +		state_count++;
>> +	}
>> +
>> +	if (!state_count) {
>> +		pr_warn("No idle ops founds for cpu %d\n", cpu);
>
>Maybe pr_debug? It's not the end of the world that we don't have cpuidle.
>
Sure.

>> +		return -ENODEV;
>> +	}
>> +
>> +	fns = kcalloc(state_count, sizeof(*fns), GFP_KERNEL);
>> +	if (!fns)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < state_count; i++)
>> +		fns[i] = idle_fns[i];
>> +
>> +	if (use_scm_power_down) {
>> +		/* We have atlease one power down mode */
>
>s/atlease/at least/
>
Thanks!

>> +		cpumask_clear(&mask);
>> +		cpumask_set_cpu(cpu, &mask);
>> +		qcom_scm_set_warm_boot_addr(cpu_resume, &mask);
>> +	}
>> +
>> +	per_cpu(qcom_idle_ops, cpu) = fns;
>> +
>> +	/*
>> +	 * Condition: cpuidle_driver_register() needs to happen before
>> +	 * cpuidle_register_device().
>> +	 * Check if the SPM probe has happened -
>> +	 * - If SPM probed successfully before arm_idle_init(), then defer
>> +	 *   the registration of cpuidle_device back to arm_idle_init()
>> +	 * - If the SPM probe happens in the future, then let the SPM probe
>> +	 *   register the cpuidle device, return -ENOSYS.
>> +	 */
>> +	return per_cpu(cpu_spm_drv, cpu) ? 0 : -ENOSYS;
>> +}
>> +
>> +struct cpuidle_ops qcom_kpss_v1_cpuidle_ops __initdata = {
>> +	.name = "qcom,kpss-acc-v1",
>> +	.suspend = qcom_idle_enter,
>> +	.init = qcom_cpuidle_init,
>> +};
>> +
>> +struct cpuidle_ops qcom_kpss_v2_cpuidle_ops __initdata = {
>> +	.name = "qcom,kpss-acc-v2",
>> +	.suspend = qcom_idle_enter,
>> +	.init = qcom_cpuidle_init,
>> +};
>> +
>>
>
>This just looks weird because of the macro magic in Daniel's series. Any
>reason we can't use the linker instead of doing preprocessor magic so
>that it looks like these structures are actually used?
>
Hmm.. Will wait on Daniel's response to your other mail.

>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
