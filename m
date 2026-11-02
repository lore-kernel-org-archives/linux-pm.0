Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633265;
	b=d9RY3Zk7l5V+QRAI1c0e1zt69MXo2536l0H80n1lZdcIl9B1dF7IGPbx5E4uM+ThRKZN
	 MD6OUsbrrKI+2Txe6IElc2oyIQbRfyWG6EmQu5s62aHHXtvEbU2fZS2tt35Rn8mFro1jb
	 5Lq0DdUzE7wzJ9KRtGGjcNWaUjqgbzjnq/TqR6nKZWMZ4yv8dU597Ma9to2U2VRiPLQNS
	 5VcJT8R1+uAdI4iUTPImzK944YoETBsrzlvHsyUIxC4F26qTzpI/BJozseJz2PvF/wYun
	 d651z2HpXtmTiXcYJcMR43WNctp19IvTnofROL13/bPP+CAN5OZl9ROZiw3c8p+6R+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633265;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=E+WJCb0x545P4FxtH1E2h0wXkiVLDIgDYMHDkPKsf+0=;
	b=3CIVlpKqFxpEFUw6dYQ+/mALXIt+mcGySkm4+zXqPwIZYMKwhfxZfIkc6nZ/eJkKbQ9G
	 pqGIHkwJrsov8WNvoRjOtS0Rlq0bRhFfrQkPpmww0jEagFCU7bCXep5yHsrAEuJZdwW9g
	 5flAyj/QFDYXFT4oXKtJy2qHEBg5MmHSu4WhRyZH4rdOQ0o4IWSsgiiHlC0qowBTBXrck
	 Pw2bbfgAVnv42jZAAdf97gYZwOpG+NsULKDBpClrEU/wAxXWVQsLN1piuOJMz59sdVgTx
	 CLdmO+ELI199OGGG2mmPAXOXetFqqdY5jIA5rG32Ddb4PHhypKBH55gAAHsp7DrJPsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iUiEmSD4;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC61A6084404;
	Mon,  2 Nov 2026 15:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC61A6084404
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iUiEmSD4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D55611A2D;
	Mon,  2 Nov 2026 07:27:40 -0800 (PST)
Received: from [10.57.16.53] (unknown [10.57.16.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 771FF3F673;
	Mon,  2 Nov 2026 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793633264; bh=MA0wJktlelkcy3XBNiJpalBEAbq1IO+tK9N/ksbMS1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iUiEmSD4LfgWJt5/IwGClHilW1CH8h5590EKF8/yhxcYxyISGMw8UBeZneqeq9Wa4
	 C0nzCQZV2MMrnQqhhw5d3/WSqbJQ3uYxWsrIBNTs6GGL5rfF1w4x0Xy31E/FhNTMT/
	 HI5P1O9xWjevhZ8DHIjCYidriJwOdbEYnxWNglbk=
Message-ID: <3ed2a68b-d066-4a3a-b3ed-30a5ca00ae38@arm.com>
Date: Mon, 2 Nov 2026 15:28:12 +0000
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
Subject: Re: [PATCH] PM: EM: Rank boost and non-boost frequencies separately
To: Guo Chen <guo.chen@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>, Len Brown <lenb@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, xin.liu@oss.qualcomm.com,
 aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, Pavel Machek <pavel@kernel.org>
References: <20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/26 08:10, Guo Chen wrote:
> em_compute_costs() ranks all the frequencies of the table, boost ones
> included. A non-boost frequency can be marked inefficient only because
> a faster boost frequency has a lower or equal cost, e.g.
> 
>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
> 
> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
> skipped by governors rounding down to efficient frequencies (e.g.
> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
> the best selectable frequency. Several frequencies can be affected.
> 
> Rank boost and non-boost frequencies separately in em_compute_costs(),
> using the highest non-boost frequency of the CPUFreq table, returned by
> the new helper cpufreq_table_max_nonboost_freq(), as the boundary.
> 
> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
> ---
>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
>   kernel/power/energy_model.c | 15 +++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d3d0d9d02aa4..c93316141a11 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
>   	return -EINVAL;
>   }
>   
> +static inline unsigned int
> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *pos;
> +	unsigned int max = 0;
> +
> +	if (!policy->freq_table)
> +		return 0;
> +
> +	/* The table may be unsorted, scan all of it for the highest one. */
> +	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> +		if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos->frequency > max)
> +			max = pos->frequency;
> +	}
> +
> +	return max;
> +}
> +
>   static inline int parse_perf_domain(int cpu, const char *list_name,
>   				    const char *cell_name,
>   				    struct of_phandle_args *args)
> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
>   	return -EINVAL;
>   }
>   
> +static inline unsigned int
> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
>   						     const char *cell_name, struct cpumask *cpumask,
>   						     struct of_phandle_args *pargs)
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d19a65461ae8..253c53ca6a74 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -255,15 +255,30 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>   			    unsigned long flags)
>   {
>   	unsigned long prev_cost = ULONG_MAX;
> +	struct cpufreq_policy *policy;
> +	unsigned int max_nonboost = 0;
> +	bool prev_boost = false;
>   	int i, ret;
>   
>   	/* This is needed only for CPUs and EAS skip other devices */
>   	if (!_is_cpu_device(dev))
>   		return 0;
>   
> +	policy = cpufreq_cpu_get(dev->id);
> +	if (policy) {
> +		max_nonboost = cpufreq_table_max_nonboost_freq(policy);
> +		cpufreq_cpu_put(policy);
> +	}
> +
>   	/* Compute the cost of each performance state. */
>   	for (i = nr_states - 1; i >= 0; i--) {
>   		unsigned long power_res, cost;
> +		bool boost = table[i].frequency > max_nonboost;
> +
> +		if (boost != prev_boost) {

We expect in EM fwk that the frequencies are sorted ascending
and we return error during setup if the driver callback fails
to provide that.
Therefore, in this code we don't have to deal with random
'boost' labels with gaps between.

Let's make all OPPs which are 'boost' equally possible
to reach (at least in theory), so label them as
'efficient'. I think this is fair in 'boosting' case scenario
and energy has not that importance in it.

So simply something like, would be enough IMHO:

if (boost)
	prev_cost = ULONG_MAX;


> +			prev_boost = boost;
> +			prev_cost = ULONG_MAX;
> +		}
>   
>   		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>   			ret = cb->get_cost(dev, table[i].frequency, &cost);
> 
> ---
> base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> change-id: 20261029-em-rank-boost-separately-a7e7c7d78058
> 
> Best regards,
> --
> Guo Chen <guo.chen@oss.qualcomm.com>

