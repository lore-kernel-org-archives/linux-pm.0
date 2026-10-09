Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD53CF02E;
	Fri,  9 Oct 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538839; cv=none; b=bDAkEWU8vksJWvkoYTWfTaPfOeb8r962OVQ8Ni8gr4PR4+9NGXAI8ZvMMaLm78eLzzhTIOn2etu7FMhwEXB9GNta5A2fJMhRNJZGEaXKnzv4f5WEAF1Ysvz1GHJSkA88b5GjxSpKJ4EPO0ite6ewTsQrR8y/j3yHxGOCM3tq7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538839; c=relaxed/simple;
	bh=9t2R2/V/GTyQMOc6PpXwcjM4hPBP1sboGSjSJYoDiu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM1wR3Ax7lo1hA+peShXwv8YNZhXj3zsPTo4eTZ5e95mEFlmXULZB4nIx79yLiuAzRZqi719APDlNVsEcXZ2j93OeP5NmO7ysdwTB+2iueaWF2vmGN9RtwSF4Yq2YOrjG3CdxHe38BAOJsy0y6gosuGSdPyHA++FO3p3PJU220Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mnq7i3HY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mnq7i3HY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E5061570;
	Fri,  9 Oct 2026 02:40:21 -0700 (PDT)
Received: from [10.57.87.202] (unknown [10.57.87.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009153F8C6;
	Fri,  9 Oct 2026 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791538824; bh=9t2R2/V/GTyQMOc6PpXwcjM4hPBP1sboGSjSJYoDiu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mnq7i3HYVNV2Kdu2uWFP/n9Heb6knlRmXTK42lahgc4MVuCji8dQ2PNJGsDg7psrJ
	 yjlI2HcrPujK7RtI7VIoIe88f99WmQEUXhzO01+Ao+RLIpi/EKK84UE3QrHekPyjVv
	 hrcBQzpOjCQtLYEzu3GtyFP947i+lgpVfo+CmLJs=
Message-ID: <32a250e5-0c56-43ce-ab80-8c4375542b59@arm.com>
Date: Fri, 9 Oct 2026 10:40:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Don't track pressure if policy->max equals top
 of freq_table
To: Giovanni Gherdovich <ggherdovich@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009082928.21847-1-ggherdovich@suse.cz>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261009082928.21847-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/26 09:29, Giovanni Gherdovich wrote:
> The acpi-cpufreq driver stores non-boost frequencies in
> policy->freq_table, but policy->cpuinfo.max_freq contains the max
> boost frequency.
> 
> policy->max is constrained to be, at most, the largest value in
> freq_table. This means that under nominal conditions, policy->max is
> substantially lower than policy->cpuinfo.max_freq, resulting in large
> values of cpufreq_pressure, on all CPUs, for no reason.
> The result is large performance regressions on compute/memory intensive
> benchmarks that use a limited number of CPUs; tasks migrate more and
> lose locality. My tests are with the "NAS Parallel Benchmarks" suite,
> limiting to 1/4 of available CPUs.
> 
> This change sets cpufreq_pressure to zero if policy->max is equal
> (or above) the maximum frequency in freq_table.
> 
> Here a concrete example from a 1st generation AMD EPYC (Naples) using
> acpi-cpufreq. Under nominal conditions (no capping, no throttling):
> 
> freq_table               : 1200 MHz, 1700 MHz, 2200 MHz
> policy->max              : 2200 MHz (maximum from freq_table)
> policy->cpuinfo.max_freq : 3200 MHz (max boost)
> 
> Before this change, in the example above we'd get a cpufreq_pressure
> value of 320 (32% pressure); with the change, the pressure is zero as
> it's expected to be.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
> Clarifying the recipients list, beyond the cpufreq maintainers:
> 
> Mario Limonciello, Huang Rui: the patch isn't for amd-pstate, but
>    AMD EPYC up to Genoa (Zen4) defaults to acpi-cpufreq, so they may come
>    across this if they haven't already.
> Vincent Guittot: for the cpufreq_pressure and scheduler load balancer
>    implications.
> Ricardo Neri: he's been looking at cpufreq_pressure on x86, albeit
>    this patch isn't for intel_pstate.
> Pierre Gondois: he looked at policy->max in freq_table.c earlier this year.


I'm assuming this isn't on top of
f341dc4d934a ("cpufreq: intel_pstate: Fix max_freq fallback in cpufreq_update_pressure()")
Care to retry?

> 
>  drivers/cpufreq/cpufreq.c    | 3 +++
>  drivers/cpufreq/freq_table.c | 1 +
>  include/linux/cpufreq.h      | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..aa652750f711 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2601,6 +2601,9 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>  	 */
>  	if (max_freq <= capped_freq) {
>  		pressure = 0;
> +	} else if (policy->freq_table && policy->max_table_freq &&
> +		   policy->max_table_freq <= capped_freq) {
> +		pressure = 0;
>  	} else {
>  		max_capacity = arch_scale_cpu_capacity(cpu);
>  		pressure = max_capacity -
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index ea994647abc8..55c3293685c2 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -50,6 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>  	}
>  
>  	policy->cpuinfo.min_freq = min_freq;
> +	policy->max_table_freq = max_freq;
>  	/*
>  	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>  	 * it as is.
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d3d0d9d02aa4..4a3316e47f4e 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -67,6 +67,7 @@ struct cpufreq_policy {
>  	unsigned int		max;    /* in kHz */
>  	unsigned int		cur;    /* in kHz, only needed if cpufreq
>  					 * governors are used */
> +	unsigned int		max_table_freq; /* max freq in the table */
>  	unsigned int		suspend_freq; /* freq to set during suspend */
>  
>  	unsigned int		policy; /* see above */

