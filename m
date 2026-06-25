Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94513C10B8;
	Thu, 25 Jun 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381355; cv=none; b=necEQly3gnjMX9vgmjv1iGQ1mVExMiUvlkoeB45vhT8cSBdVvkAWBf8VXKClE+N5sgviuYSO8Nl/qcuwVtsLSQlC9RuZhC1BNAshO33BhLAVhM1eEUsDxZdphqA9lzWbIZGb9+/DT0JSqfbbFBzLxB0sLusCSLYNJlL46ZlGHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381355; c=relaxed/simple;
	bh=AVzU6uhAKGmwZXLxbz3FqQFhpLlmuoveVJ13ywwKLWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CEKeXqnFeOX1PaakNZztOk8hngwsYOpbwwUWdH4mz6uRchGPJwvDlw9IYYkVOrDcLio9Qvm5mLGjxZZyLwNYFS93Xjdwr9RTXBYNktOWyL4SB2lFll9zF7lQp9p7FOX4LbG1b4TBB89KsOJNTdqRxmLogyogjt1C7f+nlcmJ9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gmDVH4lSpzcZyQ;
	Thu, 25 Jun 2026 17:47:03 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 1614A40363;
	Thu, 25 Jun 2026 17:55:43 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Jun
 2026 17:55:42 +0800
Message-ID: <e0090262-34ae-4419-aa9a-fd36901d0a05@hisilicon.com>
Date: Thu, 25 Jun 2026 17:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: Reduce cppc delivered perf sampling jitter
To: Jeremy Linton <jeremy.linton@arm.com>, <linux-pm@vger.kernel.org>
CC: <sumitg@nvidia.com>, <pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<viresh.kumar@linaro.org>, <leitao@debian.org>, <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260602212052.1278365-1-jeremy.linton@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260602212052.1278365-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Hi Jeremy,

On 6/3/2026 5:20 AM, Jeremy Linton wrote:
> CPPC uses a pair of registers cycling at different frequencies to
> determine an accumulated performance level. For userspace reporting we
> want to convert this to an instantaneous CPU frequency, but over short
> time periods small errors caused by CPPC counter reads can cause
> fairly significant reported frequency variations even when the core
> CPU clock isn't changing.
> 
> Reduce this by keeping a start sample fixed and retrying the end
> sample until the counter deltas are large enough to reduce short
> window error, or until adjacent delivered performance estimates are
> within the CPU's observed CPPC read noise floor.
> 
> To begin, resample the initial pair a small fixed number of times
> looking for matching delivered performance deltas.  This reduces the
> chance that a disturbed start sample anchors the rest of the
> calculation.
> 
> Then look for an end sample while updating the noise floor from the
> best error seen between samples.  The floor remains zero on systems
> with stable feedback reads, but lets noisy systems stop early once
> another retry is unlikely to improve the result.  The retry loop is
> capped at 200 iterations, giving an ~20 usec explicit delay budget
> derived from ndelay(100).
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 68 ++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..362c08def420 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -50,7 +50,7 @@ struct cppc_freq_invariance {
>  static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>  static struct kthread_worker *kworker_fie;
>  
> -static int cppc_perf_from_fbctrs(u64 reference_perf,
> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
>  
> @@ -750,7 +750,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
>  	return (u32)t1 - (u32)t0;
>  }
>  
> -static int cppc_perf_from_fbctrs(u64 reference_perf,
> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>  				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>  {
> @@ -771,19 +771,71 @@ static int cppc_perf_from_fbctrs(u64 reference_perf,
>  	return (reference_perf * delta_delivered) / delta_reference;
>  }
>  
> -static int cppc_get_perf_ctrs_sample(int cpu,
> +/* CPPC read noise floor for early retry exit. */
> +static DEFINE_PER_CPU(u64, err_floor);
> +
> +#define CPPC_SAMPLE_MAX_RETRIES	200
> +
> +static int cppc_get_perf_ctrs_sample(int cpu, u64 ref,
>  				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>  				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>  {
>  	int ret;
> +	s64 last_delivered = 0;
> +	u64 smallest_error = 0;
> +	int tries = 0;
> +	u64 min_counts = ref * 2000;
> +
> +	/* Two subsequent reads with the same offset avoids one off large jitter values */
> +	for (int x = 0; x < 10; x++) {
> +		ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
> +		if (ret)
> +			return ret;
> +
> +		ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
> +		if (ret)
> +			return ret;
> +
> +		if (last_delivered == cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1))
> +			break;
> +
> +		last_delivered = cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1);
> +	}
Actually I don't quite understand this hunk.
Is it trying to get two exactly same samples of delivered performance?
Isn't that very hard or impossible to meet?

> +	last_delivered = 0;
> +again:
> +	ndelay(100);
>  
> -	ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
> +	ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
>  	if (ret)
>  		return ret;
>  
> -	udelay(2); /* 2usec delay between sampling */
> +	/*
> +	 * We want at least two significant figures, if the counts are low, then there
> +	 * can be rounding errors that show up as frequency that is swinging around a few hundred
> +	 * Mhz. OTOH, if the delay gets too long the clock rate can be affected.
> +	 * So we want it exactly long enough to have sufficient counter turn over, and
> +	 * a repeatable low error value.
> +	 */
> +	if ((get_delta(fb_ctrs_t1->reference, fb_ctrs_t0->reference) < min_counts) ||
> +	    (get_delta(fb_ctrs_t1->delivered, fb_ctrs_t0->delivered) < min_counts)) {
> +		s64 delivered = cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1);
> +		u64 error = abs(last_delivered - delivered);
> +
> +		if (smallest_error == 0 || smallest_error > error)
> +			smallest_error = error;
> +
> +		if (error > per_cpu(err_floor, cpu)) {
> +			last_delivered = delivered;
> +			tries++;
> +			if (tries < CPPC_SAMPLE_MAX_RETRIES)
> +				goto again;
> +		}
> +	}
>  
> -	return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
> +	/* compute a running error */
> +	per_cpu(err_floor, cpu) = (per_cpu(err_floor, cpu) + smallest_error) / 2;
> +
> +	return ret;
Correct me if I'm wrong.  The key point is something like a self-adaptation
process to get an appropriate sampling delay for different platforms or
even each CPU?
>  }
>  
>  static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> @@ -799,7 +851,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  
>  	cpu_data = policy->driver_data;
>  
> -	ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
> +	ret = cppc_get_perf_ctrs_sample(cpu, cpu_data->perf_caps.reference_perf,
> +					&fb_ctrs_t0, &fb_ctrs_t1);
> +
>  	if (ret) {
>  		if (ret == -EFAULT)
>  			/* Any of the associated CPPC regs is 0. */
