Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489265;
	b=pyyBRtzelAu7Z5R5moYLBdGEpotSd9r0cKYqR5h3NYsn0otNi9QxykKjMp1ADhEnZynl
	 3NrxwXiGI7tOmncmZAOF1d/jZh3LIP7vqS400P1PTaSBMitexORl2Gq5g/k3jZZOZjNdF
	 rtfGUG/aLfuz3HmOyRtPunoPETXasA05M1ne0P8uqTtOrV6F4IAv2ISBRc4yx07jhiqef
	 Js0lpN411Ug2HRrBlj8613H+sic3cfk9xFiFXjdkw4kabWAlL3Znel+fYi2JBAt4rktD8
	 oZQmaramDDB3Xckb3mV03xBPDRFhU/KNro8efQyHae9YVsupKufZNRCprTl7sda58BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489265;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9mxKg6PFH2mKgwRlY7JWxXK8RldI6RUjgfddAJpwc7I=;
	b=UrLA8vjS8hsmaNvbyRYqEN4ChKTSBSK/qGmxiK3Q5mmu6FzhHOggwGyP9CaQ4oUXkTio
	 8LEWhvkc/Hc25oeQIxipuOSTp6/3yULxIrfA/bt4m9iTjs5fVE6TKqJe9YB21OxMOUp6f
	 tqE3MTLxblEl9kuiiaM0eDtUWc+yMPT6B05Hz5XQK/c7KQZBpua3dBVWBtSylCPPDkL/Q
	 z/Vi6a5CeYyknjm6QhuJ/e8JviTWR305v5PFEBkVzfTPGxL8c6SRX39eX6OsxW5NoMjn/
	 oxbnP7CqD9kz3B7FF4cWHXnhdWR9zVBLYyWvL/W3PiS5Uxl5P6ZftG7S3PU1u2nz1CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eTo2jkKY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E560A2627;
	Thu, 12 Nov 2026 13:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C02E560A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eTo2jkKY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D3981477;
	Thu, 12 Nov 2026 05:14:21 -0800 (PST)
Received: from [10.0.130.226] (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4913F632;
	Thu, 12 Nov 2026 05:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794489264; bh=sJI57U+WQOiBy+zdKsRY1/z8s+X/kd45XllUmlTevYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eTo2jkKY3U51csyMMrfFFecVyff9fAh9wtLCDpLVnzECVxAuLlgP6dRXs3hc9xvT1
	 HnmFmYqbfi2H67ZLhTUvZnjQ1xOhfn/mNez+PQo06bYMt1d1YHpgd7q99t+tuhgW/O
	 smFX5zUsYOoS8bP4A869wo2NHR9ZF2gmtUcPXuLk=
Message-ID: <8d335175-7d1e-4e12-b28b-d6f2ee13edee@arm.com>
Date: Thu, 12 Nov 2026 13:14:16 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESEND] cpufreq: CPPC: Add autonomous mode boot
 parameter support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 pierre.gondois@arm.com, ionela.voinescu@arm.com, mario.limonciello@amd.com,
 maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
 lenb@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20261112080442.4007723-1-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261112080442.4007723-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 08:04, Sumit Gupta wrote:
> Configuring autonomous selection and Energy Performance Preference (EPP)
> at every boot currently requires per-policy sysfs writes.
> 
> Add the 'cppc_cpufreq.auto_sel_mode' boot parameter to enable autonomous
> selection during policy initialization and optionally set EPP. In
> autonomous mode, the platform selects the performance level within the
> MIN and MAX limits, which the driver sets from the policy limits. The EPP
> hint guides that selection.
> 
> The parameter accepts:
> - performance: enable autonomous selection and set EPP to 0x00
> - balance_performance: enable it and set EPP to 0x80
> - balance_power: enable it and set EPP to 0xc0
> - power: enable it and set EPP to 0xff
> - default_epp: enable it and preserve firmware EPP
> - disabled: preserve the firmware configuration (default)
> 
> Warn about unrecognized values and ignore them.
> 
> Skip policies without autonomous-selection support. The driver enables
> autonomous selection before writing EPP, as the platform may ignore EPP
> while autonomous selection is disabled.
> 
> Record successful writes so the existing online and resume paths reapply
> the requested values. The offline and suspend paths restore the saved
> firmware values, including during driver unload.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> Resending v6 with base-commit info and Pierre added to Cc.
> No changes to the code or commit message.
> 
> This is based on the "Preserve OSPM-set registers" [1] and
> "ospm_nominal_perf" [2] series, which are applied for 7.5.

I've sent out
https://lore.kernel.org/lkml/20261112113204.778904-1-christian.loehle@arm.com/
as a follow up, if it looks sound to you, feel free to pick it up
as a series to go in before $SUBJECT?

> 
> v5 -> v6:
> - Split "Set CPPC Enable register in cpu_init" into a separate fix [3].
> - Accept strings only (Pierre [4]).
> - Move the setup into cppc_cpufreq_setup_auto_sel_mode() and check
>   autonomous selection support first (Pierre [4]).
> - Drop the last_governor check, as init() now runs only for a new
>   policy (Pierre [4]).
> - Drop the MIN/MAX seeding, Desired hint and policy->min/max override,
>   as init() and the governor already set valid values (Pierre [4]).
> - Apply the parameter at the end of init(), after the usual
>   performance controls write.
> - Save auto_sel and EPP through the saved-register code from [1]
>   (Sashiko [5]).
> - Drop the cppc_cpufreq_exit() loop that cleared auto_sel on all
>   present CPUs (Pierre [4], Sashiko [5]).
> - Enable autonomous selection before writing EPP.
> - Set EPP also when firmware has already enabled autonomous selection.
> - Add the balance_power (0xc0) and power (0xff) modes.
> - Ignore an unrecognized value instead of treating it as disabled.
> 
> v5: https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
> [1] https://lore.kernel.org/lkml/20261106193304.3347374-1-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/20261109195400.3600561-1-sumitg@nvidia.com/
> [3] https://lore.kernel.org/lkml/20261110101246.3665797-1-sumitg@nvidia.com/
> [4] https://lore.kernel.org/lkml/f61f592a-bc9c-4a83-bde1-e999c8101c36@nvidia.com/
> [5] https://sashiko.dev/#/patchset/20260623080652.3353386-1-sumitg@nvidia.com
> 
>  .../admin-guide/kernel-parameters.txt         |  26 ++++
>  drivers/cpufreq/cppc_cpufreq.c                | 120 ++++++++++++++++++
>  include/acpi/cppc_acpi.h                      |   2 +
>  3 files changed, 148 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd9..5714c0d30fce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1015,6 +1015,32 @@ Kernel parameters
>  			Format:
>  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>  
> +	cppc_cpufreq.auto_sel_mode=
> +			[ACPI,CPU_FREQ] Enable ACPI CPPC autonomous performance
> +			selection on all CPUs at boot. In autonomous mode, the
> +			platform selects the performance level within the CPPC
> +			Minimum and Maximum Performance limits. The driver sets
> +			these limits from scaling_min_freq and scaling_max_freq.
> +			The Energy Performance Preference (EPP) hint guides the
> +			platform toward performance (0x00) or energy efficiency
> +			(0xff).
> +			Requires the ACPI CPPC Autonomous Selection Enable
> +			register. EPP is set only if the platform implements it.
> +			Format: <string>
> +			  performance:
> +				  enable autonomous selection, set EPP to 0x00
> +			  balance_performance:
> +				  enable autonomous selection, set EPP to 0x80
> +			  balance_power:
> +				  enable autonomous selection, set EPP to 0xc0
> +			  power:
> +				  enable autonomous selection, set EPP to 0xff
> +			  default_epp:
> +				  enable autonomous selection, keep firmware EPP
> +			  disabled:
> +				  keep the firmware configuration (default)
> +			An unrecognized value is ignored with a warning.
> +
>  	cpuidle.off=1	[CPU_IDLE]
>  			disable the cpuidle sub-system
>  
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a62589c0674f..c9bed93cf0c9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -238,6 +238,58 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
>  					     saved_type);
>  }
>  
> +/* Autonomous Selection boot parameter modes */
> +enum {
> +	AUTO_SEL_MODE_DISABLED,
> +	AUTO_SEL_MODE_PERFORMANCE,
> +	AUTO_SEL_MODE_BALANCE_PERFORMANCE,
> +	AUTO_SEL_MODE_BALANCE_POWER,
> +	AUTO_SEL_MODE_POWER,
> +	AUTO_SEL_MODE_DEFAULT_EPP,
> +};
> +
> +static const char * const auto_sel_mode_names[] = {
> +	[AUTO_SEL_MODE_DISABLED]		= "disabled",
> +	[AUTO_SEL_MODE_PERFORMANCE]		= "performance",
> +	[AUTO_SEL_MODE_BALANCE_PERFORMANCE]	= "balance_performance",
> +	[AUTO_SEL_MODE_BALANCE_POWER]		= "balance_power",
> +	[AUTO_SEL_MODE_POWER]			= "power",
> +	[AUTO_SEL_MODE_DEFAULT_EPP]		= "default_epp",
> +};
> +
> +static int auto_sel_mode;
> +
> +static int auto_sel_mode_set(const char *val, const struct kernel_param *kp)
> +{
> +	int *mode = kp->arg;
> +	int ret;
> +
> +	ret = sysfs_match_string(auto_sel_mode_names, val);
> +	if (ret < 0) {
> +		pr_warn("Invalid auto_sel_mode \"%s\", ignoring it\n", val);
> +		return 0;
> +	}
> +
> +	*mode = ret;
> +	return 0;
> +}
> +
> +static int auto_sel_mode_get(char *buffer, const struct kernel_param *kp)
> +{
> +	int *mode = kp->arg;
> +
> +	return sysfs_emit(buffer, "%s\n", auto_sel_mode_names[*mode]);
> +}
> +
> +static const struct kernel_param_ops auto_sel_mode_ops = {
> +	.set = auto_sel_mode_set,
> +	.get = auto_sel_mode_get,
> +};
> +
> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
> +MODULE_PARM_DESC(auto_sel_mode,
> +		 "Autonomous selection mode: performance, balance_performance, balance_power, power, default_epp, disabled");
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -938,6 +990,72 @@ static u32 cppc_cpufreq_effective_nominal(struct cpufreq_policy *policy)
>  	return (u32)ospm_nominal;
>  }
>  
> +/*
> + * Apply the auto_sel_mode boot parameter in init(). Enable autonomous
> + * selection unless it is already enabled. Then set EPP for the selected mode.
> + *
> + * Enable auto_sel before writing EPP, as the platform may ignore EPP while
> + * autonomous selection is disabled. Save each value written, so that online()
> + * and resume() write it again.
> + */
> +static void cppc_cpufreq_setup_auto_sel_mode(struct cpufreq_policy *policy)
> +{
> +	struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	u64 auto_sel, epp;
> +	int ret;
> +
> +	if (auto_sel_mode == AUTO_SEL_MODE_DISABLED)
> +		return;
> +
> +	/* U64_MAX means the platform does not implement the register. */
> +	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][CPPC_SAVED_FIRMWARE];
> +	if (auto_sel == U64_MAX) {
> +		pr_info_once("Autonomous selection is not supported, ignoring auto_sel_mode\n");
> +		return;
> +	}
> +
> +	if (!auto_sel) {
> +		ret = cppc_set_auto_sel(cpu, true);
> +		if (ret) {
> +			pr_warn("Failed to enable auto_sel for CPU%u (%d)\n",
> +				cpu, ret);
> +			return;
> +		}
> +		cppc_cpufreq_save_requested(policy, CPPC_SAVED_AUTO_SEL, true);
> +	}
> +	cpu_data->perf_ctrls.auto_sel = true;
> +
> +	switch (auto_sel_mode) {
> +	case AUTO_SEL_MODE_PERFORMANCE:
> +		epp = CPPC_EPP_PERFORMANCE_PREF;
> +		break;
> +	case AUTO_SEL_MODE_BALANCE_PERFORMANCE:
> +		epp = CPPC_EPP_BALANCE_PERFORMANCE_PREF;
> +		break;
> +	case AUTO_SEL_MODE_BALANCE_POWER:
> +		epp = CPPC_EPP_BALANCE_POWER_PREF;
> +		break;
> +	case AUTO_SEL_MODE_POWER:
> +		epp = CPPC_EPP_ENERGY_EFFICIENCY_PREF;
> +		break;
> +	default:
> +		/* default_epp keeps the EPP value set by firmware. */
> +		return;
> +	}
> +
> +	/* EPP is optional. */
> +	ret = cppc_set_epp(cpu, epp);
> +	if (ret) {
> +		if (ret != -EOPNOTSUPP)
> +			pr_warn("Failed to set EPP for CPU%u (%d)\n", cpu, ret);
> +		return;
> +	}
> +	cpu_data->perf_ctrls.energy_perf = epp;

So EPP is also allowed to be 4 or 6 bits wide and we might wanna account
for that either here or in acpi-cppc.
That being said that's already not working, I usually think all these
technically compliant platforms should just be filtered out on
acpi-cppc probe and we don't support EPP then and not worry about it.
That being said amd-pstate requires EPP for active mode and in this case
just handling the read/writes seems the pass of less resistance:
https://lore.kernel.org/all/20261112131316.827708-1-christian.loehle@arm.com/


> +	cppc_cpufreq_save_requested(policy, CPPC_SAVED_EPP, epp);
> +}
> +
>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;
> @@ -1058,6 +1176,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  	cpu_data->perf_limits_valid = true;
>  
> +	cppc_cpufreq_setup_auto_sel_mode(policy);
> +
>  	cppc_cpufreq_cpu_fie_init(policy);
>  	return 0;
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 2cec54b4d2e2..3d47c07f494b 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -42,6 +42,8 @@
>  #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>  
>  #define CPPC_EPP_PERFORMANCE_PREF		0x00
> +#define CPPC_EPP_BALANCE_PERFORMANCE_PREF	0x80
> +#define CPPC_EPP_BALANCE_POWER_PREF		0xC0
>  #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>  
>  #define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
> 
> base-commit: a917b5968c17196b98b514158de800194d09e505

Actual $SUBJECT looks okay to me, I'd wait with the R-b for the
series, though.
