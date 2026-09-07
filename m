Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826F448B8A;
	Mon,  7 Sep 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770621; cv=none; b=h5j888dNQeFqTvJ8iWLRCwPLC1o06edgGNp4S0yCjjBNFP2DQar5AlL+dxiiqgvTJ7F538ZLRp4q+5mitns5oQ63P5xNRvKdriX3JlNkz63mVHbgHEf93XWv6k+FcL0cYQXHokwJnOwg7j4ZS3sNLsNsPFLg9K8iK1rNuN4HZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770621; c=relaxed/simple;
	bh=qlsiU5m0Vd7b370vVIEaEUez+m5Jb2nv6IPuPBiL5TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A5bFhWivi77yyynLNJUzpGf2XrGIjDjPFq16guhyQrnYsIMZau3DpmaYQubBNMA/JxL0T/UHDiaznsiz6gwCQvX+5iKMMIRrDB9ZjWXGKPzridClELvZWjmboDWYAsyGbyPMpkwu5zefr8lUOtsl/2wqHjbQYyYWvKOXVjHxi5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hdgLK1gYfz1K96b;
	Mon,  7 Sep 2026 16:32:41 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 7606F40565;
	Mon,  7 Sep 2026 16:43:34 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 7 Sep
 2026 16:43:33 +0800
Message-ID: <0e7f0226-7e57-414c-8815-9f02d7165e26@hisilicon.com>
Date: Mon, 7 Sep 2026 16:43:33 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] cpufreq: cppc: Add update_limits support for
 Highest Performance changes
To: Xueqin Luo <luoxueqin@kylinos.cn>, Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-pm@vger.kernel.org>
References: <20260807060848.832929-1-luoxueqin@kylinos.cn>
 <20260807060848.832929-2-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260807060848.832929-2-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 8/7/2026 2:08 PM, Xueqin Luo wrote:
> ACPI CPPC specification requires OSPM to re-evaluate the Highest
> Performance register when Notify(0x85) is received for a processor
> device.
> 
> Implement cppc_cpufreq_update_limits() to refresh the cached
> highest_perf capability through cppc_get_highest_perf() and update
> policy->cpuinfo.max_freq from Highest Performance. Use
> refresh_frequency_limits() so policy->max follows the standard
> cpufreq_set_policy() path.
> 
> cpuinfo.max_freq always tracks Highest Performance. When boost is
> disabled but still supported, constrain policy->max by updating the
> existing boost_freq_req (created in cpufreq_policy_init_qos) to
> nominal, instead of hiding the hardware maximum in cpuinfo.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 98 ++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 6fe0e972952a..089f734f851b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -855,6 +855,103 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  	return 0;
>  }
>  
> +/**
> + * cppc_cpufreq_sync_boost_limits - Sync boost flag, cpuinfo max and boost QoS
> + * @policy: cpufreq policy
> + * @boost_supported: whether highest_perf currently exceeds nominal_perf
> + *
> + * Highest Performance can appear or disappear at runtime via Notify(0x85).
> + *
> + * cpuinfo.max_freq always tracks the hardware maximum derived from Highest
> + * Performance so that sysfs reflects Notify(0x85) updates. Boost being off
> + * is enforced by updating the existing boost_freq_req to nominal (capping
> + * policy->max) rather than by hiding the hardware max in cpuinfo.
> + * boost_freq_req itself is only created at policy init, not here.
> + */
This comment seems excessive or redundant for an internal function.
> +static void cppc_cpufreq_sync_boost_limits(struct cpufreq_policy *policy,
> +					   bool boost_supported)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	unsigned int highest_freq, nominal_freq, qos_freq;
> +	int ret;
> +
> +	if (!boost_supported && policy->boost_enabled)
> +		policy->boost_enabled = false;
> +
> +	policy->boost_supported = boost_supported;
> +
> +	highest_freq = cppc_perf_to_khz(caps, caps->highest_perf);
> +	nominal_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
> +
> +	/*
> +	 * Report the current hardware maximum. If Highest dropped below
> +	 * Nominal (unusual, but possible with test overrides), never
> +	 * advertise more than Highest allows.
> +	 */
That's a weird error case.  Highest should never be less than Nominal.
Do we really need to handle that?

What I'm worried about are:
1. We can't handle that cleanly because that violates the basic assumption
of CPPC and things may go wrong everywhere.
2. That creates dead code that may never run.
> +	policy->cpuinfo.max_freq = highest_freq;
> +
> +	if (boost_supported && !policy->boost_enabled)
> +		qos_freq = min(nominal_freq, highest_freq);
> +	else
> +		qos_freq = highest_freq;
> +
> +	/*
> +	 * boost_freq_req is created in cpufreq_policy_init_qos() when
> +	 * boost_supported is true at policy init. Runtime Highest changes
> +	 * only update that existing request; they do not add or remove it.
> +	 */
Redundant comment, I think.
> +	if (freq_qos_request_active(&policy->boost_freq_req)) {
> +		ret = freq_qos_update_request(&policy->boost_freq_req,
> +					      qos_freq);
> +		if (ret < 0)
> +			pr_debug("CPU%d: failed to sync boost QoS: %d\n",
> +				 policy->cpu, ret);
pr_err?
> +	}
> +
> +	pr_debug("CPU%d: highest_perf=%u boost_en=%d cpuinfo_max=%u qos_max=%u\n",
> +		 policy->cpu, caps->highest_perf, policy->boost_enabled,
> +		 policy->cpuinfo.max_freq, qos_freq);
This looks like a test print rather than a useful debug print that we may
need to enable sometimes.
> +}
> +
> +static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data;
> +	struct cppc_perf_caps *caps;
> +	u64 prev_highest_perf;
> +	u64 highest_perf;
> +	int ret;
> +
> +	guard(cpufreq_policy_write)(policy);
> +
> +	cpu_data = policy->driver_data;
> +	caps = &cpu_data->perf_caps;
> +
> +	prev_highest_perf = caps->highest_perf;
> +
> +	ret = cppc_get_highest_perf(policy->cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	if (highest_perf == prev_highest_perf)
> +		return;
> +
> +	caps->highest_perf = highest_perf;
> +
> +	/*
> +	 * Re-evaluate boost capability/status based on the updated Highest
> +	 * Performance. Boost is supported when highest_perf exceeds
> +	 * nominal_perf.
> +	 */
> +	cppc_cpufreq_sync_boost_limits(policy,
> +				       highest_perf > caps->nominal_perf);
> +
> +	refresh_frequency_limits(policy);
> +
> +	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
> +		 policy->cpu, prev_highest_perf, highest_perf);
> +}
> +
>  static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> @@ -1048,6 +1145,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.init = cppc_cpufreq_cpu_init,
>  	.exit = cppc_cpufreq_cpu_exit,
>  	.set_boost = cppc_cpufreq_set_boost,
> +	.update_limits = cppc_cpufreq_update_limits,
>  	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",
>  };
