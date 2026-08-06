Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE641F5C1;
	Thu,  6 Aug 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006932; cv=none; b=pWvLGxWyJDAauCaPoA7LXTp9suUQekSOXovJ8OmfTwDErmbSkWnE/c3s/kzvRnZQ0hdMx0WGtTfubDeMqkAqpbk0CHOG4Itj98zzCu8QQo8A0/RceJM1NckArv8x1Y4Gcr6zyNjBC6rj4mEp730EJaR+cWlzybx5DZY0/E9RaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006932; c=relaxed/simple;
	bh=m5NHGSN+QWQ8jGKH8m7qhVAsGzAtYJFkQ76VmJgsTDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhowiPvV9pDJCsN14bh6Y40QOxw7fdx44PAj0/BwQvqh+7H3OaksrC7BqZ0VI+7pjf/jHlzGr8AH6hR3nicwKRk8MJ0wH1oSGO9qUP6jb0+EEX19zH+mAH/XyKPBtYfNlDychdKew5vWtKzI9RMWeAmiU1a6Pj6HaC7Os1HOGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nHbm64lf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nHbm64lf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EFEA153B;
	Thu,  6 Aug 2026 02:02:05 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32153F632;
	Thu,  6 Aug 2026 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786006929; bh=m5NHGSN+QWQ8jGKH8m7qhVAsGzAtYJFkQ76VmJgsTDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nHbm64lfHdIi0J0dmQAmkTIhjYo1crK4cdBFSbfZpyrGGNMXAmRdw8/MhqmY+4A0U
	 yWqibBUr7FTRRN1mKfc7wnVdc8YbhfizL/Wv1UfJHWmlKDz7l8VLr1Oi/uPl3ryG0i
	 OT8xONLCw8KzRSpHBvjn/aiV1CNskCWtQyM479fo=
Message-ID: <7a4be9a1-4b00-49c4-bdbf-649268e78c7a@arm.com>
Date: Thu, 6 Aug 2026 10:02:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/cpufreq: Update schedutil's DVFS request to
 reach the boost frequencies
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
 linux-arm-msm@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 linux-pm@vger.kernel.org, Ionela Voinescu <Ionela.Voinescu@arm.com>,
 Beata Michalska <Beata.Michalska@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-3-sibi.sankar@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260806044230.909961-3-sibi.sankar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 05:42, Sibi Sankar wrote:
> capacity_freq_ref, exposed to schedutil via get_capacity_ref_freq(),
> was introduced by commit 9942cb22ea45 ("sched/topology: Add a new
> arch_scale_freq_ref() method") as a fixed anchor that does not move at
> runtime. However, schedutil uses that same fixed anchor as the reference
> plugged into map_util_freq() which saturates exactly at capacity_freq_ref.
> 
> As a result, a system with cpufreq boost enabled effectively never runs at
> boost frequencies under schedutil-governed load. Fix this by plugging in
> policy-max into the map_util_freq equation, so that the DVFS requests
> translates to the actual cpufreq driver ceiling.
> 
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a1782755efcc..dcefbeaa0702 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -195,10 +195,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  				  unsigned long util, unsigned long max)
>  {
>  	struct cpufreq_policy *policy = sg_policy->policy;
> -	unsigned int freq;
> +	unsigned int freq, ref;
>  
> -	freq = get_capacity_ref_freq(policy);
> -	freq = map_util_freq(util, freq, max);
> +	ref = get_capacity_ref_freq(policy);
> +
> +	/*
> +	 * That fixed anchor governs how utilization is interpreted, but
> +	 * the DVFS request is free to target the current policy ceiling.
> +	 * Using ref alone would saturate the util->freq map at ref so
> +	 * use policy->max to reach boost frequencies.

I'm not sure those two statements are compatible with the implementation below?
util / max is expressed in the capacity scale established using ref, multiplying
that ratio by policy->max changes the interpretation of every util value.


> +	 */
> +	freq = map_util_freq(util, max(ref, READ_ONCE(policy->max)), max);

Isn't the underlying problem that schedutil can't handle requests above capacity 1024?

effective_cpu_util() caps util at max, and sugov_effective_cpu_perf() applies
the 25% headroom before clipping the result back to that same value.
Therefore the input here cannot exceed 1024, and mapping it against ref
can never request a frequency above ref.
Using policy->max makes boost reachable, but also stretches the complete frequency range.
For example, with ref = 4454400, policy->max = 4723200, and effective util 640, the request
changes from 2784000 to 2952000.

Making 'boost frequencies' truly compatible with schedutil (or PELT/CAS for that matter)
is a discussion that is yet to be had?
See also
https://lore.kernel.org/lkml/20250626093018.106265-1-dietmar.eggemann@arm.com/

