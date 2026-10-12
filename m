Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B66139C00F;
	Mon, 12 Oct 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830776; cv=none; b=F7FhlKjLAyX0l4Yz6YzlimxzD18MZNACUTjqNLz+3bi41v8dWvmrEAMDyeKrKcFXY9CCjmpkqxOtA/6vkzSzFflEimy9Nc9VtkOqoBteTmkfT8Gco+AmxLNphzDEmRPT1bfSwrlLzCxAV1Hfn125/nZ8rKiwv3b3D9Tf0/7LWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830776; c=relaxed/simple;
	bh=+ujaKplCQ6++6KLPen6z7I1XFJ/cgkXPDvWY7vBUhn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB8vGvZ0NLGEgwJVoUibjg+aSLKyF0M3Q96R5l9k7Biha25XrPlqIsBVUkdLhYeuWJqx1KCW3VphIZJSLvU29be6Ix5AL+m4IWj15nrpIU5h5Qep5Wq6j/Tk50zffpJznk4CXH7SlyeTKHfenZN+mhOroDk4raIs5dj5o7HA770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z59FemzO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z59FemzO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 259E51476;
	Mon, 12 Oct 2026 11:45:59 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA543F673;
	Mon, 12 Oct 2026 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791830762; bh=+ujaKplCQ6++6KLPen6z7I1XFJ/cgkXPDvWY7vBUhn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z59FemzOQpc7bqIkoHYIOOp9K/vNSa/eqDkQbHH6IFLUA759VRS6nY5jOnWNNRqm3
	 iYPMcoiFgtuixtbW/RtzEA9LswFuGIuZ3xlgkq94y1GklNcztyYdU+m//046l3JEUF
	 GpXNa9XPVz18n6ql+X6+j9sHuRe+Vw5Ib9nZOMAg=
Message-ID: <cfb79ffe-41b7-4e58-b3f5-fc9a28a4e413@arm.com>
Date: Mon, 12 Oct 2026 20:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arch_topology: seed capacity_freq_ref with highest
 available frequency
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Ananthu C V <ananthu.cv@oss.qualcomm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jie Zhan <zhanjie9@hisilicon.com>,
 Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Oleg Keri <okerixx@gmail.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-1-68de169498c7@oss.qualcomm.com>
 <fbd7fe35-5e14-4589-a072-909e49a92e76@oss.qualcomm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-GB
In-Reply-To: <fbd7fe35-5e14-4589-a072-909e49a92e76@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.10.26 16:16, Zhongqiu Han wrote:
> On 9/29/2026 7:38 PM, Ananthu C V wrote:

[...]

> Besides, could you comment patch v2 Dietmar's comments? It seems that
> patch 1/2 exposes a pre-existing ordering issue. On DT systems,
> cpu_scale is normalized only from the CPUFREQ_CREATE_POLICY notification
> of the last policy, so the cpufreq pressure of every other policy is
> computed in cpufreq_init_policy() from the raw, not yet normalized,
> capacity, and stays cached until the next cpufreq_set_policy() for that
> policy. So far this was harmless because capacity_freq_ref == policy-
>>max at boot, so the pressure was 0 regardless of the capacity. With
> 1/2, capacity_freq_ref covers the boost frequencies while boost is
> disabled at boot, so policy->max < capacity_freq_ref becomes the common
> case and the stale value becomes visible (102 vs 79 on Juno R0, as
> reported by Dietmar). Perhaps the limits of all policies could be
> refreshed once from parsing_done_workfn(), after the capacities have
> been normalized?
> 
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -454,9 +454,27 @@ core_initcall(register_cpufreq_notifier);
> 
>  static void parsing_done_workfn(struct work_struct *work)
>  {
> +    int cpu;
> +
>      cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
>                       CPUFREQ_POLICY_NOTIFIER);
>      free_cpumask_var(cpus_to_visit);
> +
> +    /*
> +     * The cpufreq pressure of all policies but the last one has been
> +     * computed before topology_normalize_cpu_scale(), so refresh it now
> +     * that cpu_scale is final.
> +     */
> +    for_each_possible_cpu(cpu) {
> +        struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +            cpufreq_cpu_get(cpu);
> +
> +        if (!policy || cpu != policy->cpu)
> +            continue;
> +
> +        guard(cpufreq_policy_write)(policy);
> +        refresh_frequency_limits(policy);
> +    }
Yes, IMHO, something like this is needed.

[    1.169158] cpufreq_notifier_max(): current=[kworker/u26:0 46] policy->related_cpus=[]												(1)
[    1.169209] init_cpu_capacity_callback(): current=[kworker/u26:0 46] policy->related_cpus=[0,3-5]
[    1.169992] cpufreq_update_pressure(): current=[kworker/u26:0 46] policy->related_cpus=[0,3-5] policy->max=700000 pressure=102 max_capacity=578 capped_freq=700000 max_freq=850000
[    1.170203] cpufreq_update_pressure(): current=[kworker/2:2 67] policy->related_cpus=[0,3-5] policy->max=700000 pressure=102 max_capacity=578 capped_freq=700000 max_freq=850000 	(2)
[    1.170835] cpufreq_notifier_max(): current=[kworker/u26:0 46] policy->related_cpus=[]												(1)
[    1.170872] init_cpu_capacity_callback(): current=[kworker/u26:0 46] policy->related_cpus=[1-2]
[    1.174516] cpufreq_update_pressure(): current=[kworker/u26:0 46] policy->related_cpus=[1-2] policy->max=800000 pressure=280 max_capacity=1024 capped_freq=800000 max_freq=1100000
[    1.175261] cpufreq_update_pressure(): current=[kworker/2:2 67] policy->related_cpus=[1-2] policy->max=800000 pressure=280 max_capacity=1024 capped_freq=800000 max_freq=1100000	(2)
[    1.187698] cpufreq_update_pressure(): current=[kworker/2:0 28] policy->related_cpus=[0,3-5] policy->max=700000 pressure=79 max_capacity=446 capped_freq=700000 max_freq=850000	(3)
[    1.187847] cpufreq_update_pressure(): current=[kworker/2:0 28] policy->related_cpus=[1-2] policy->max=800000 pressure=280 max_capacity=1024 capped_freq=800000 max_freq=1100000	(3)

The work scheduled in (1) also still operates on raw capacity (2).

(3) shows your extension in parsing_done_workfn() work function which
    gets scheduled when all CPUs are initialised, so
    topology_normalize_cpu_scale() had been called.

Not sure whether we can call cpufreq_update_limits(cpu) there instead
(maybe extended with a 'only do this for policy->cpu'?). So we won't
have to expose cpufreq internals in /drivers/base/arch_topology.c.
