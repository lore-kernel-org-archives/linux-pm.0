Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE7302163;
	Fri,  1 May 2026 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657319; cv=none; b=tmaVkdmKgxzdfBdfAZumoL22AHpzqj//vB+tooXURZDzRAkLpi3SSiHeVCdhSpb8ZOO6nStfHlqtOpRquc9LGwo0zO8g/89ldi5SMJXvk/djroZE0rjklskQbvRPFE62OhATnfqHNiyNCvurhZ9xRIfeaW7Pf5BIy3+/ZkcsMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657319; c=relaxed/simple;
	bh=sFBYGono8pM+MS81Kfe9+/F0mfpEy/2ed8CZ6w24VJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgfZpHmvmx1EKt8Hye7HqR9fZr2KqDUF2Upmpdos5tGCU3TNp0QvOwE1cI5t1+ACingStbTxxlpSd57R+Nhpjx2iDusxsLeoL9HaxecTPtbX7WRMA62Dpc6vnEdkZMblS3RW2sMUH1QP5PyZv63ljyyQzq8RoaSDMpK1uAHQcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XwrgFjNj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XwrgFjNj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72B71713;
	Fri,  1 May 2026 10:41:51 -0700 (PDT)
Received: from [192.168.20.93] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E4A73F62B;
	Fri,  1 May 2026 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777657317; bh=sFBYGono8pM+MS81Kfe9+/F0mfpEy/2ed8CZ6w24VJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XwrgFjNjXSwioSmxjMAU4Rt5IkPMzimHiDRYGUa8TvAXJThKlU6XopLSF94Y0Hzec
	 6I8xmkLcb4Z+ElUTrh5XXo93BnH27uDKp+y1q4LQc+Xno1lNbwNPo9zo4QKxXa4b9I
	 vGVdg13r7S6mXbkGq1453ptoE5oY13WMPyPvTGtE=
Message-ID: <7e55dd1e-2841-4918-8e3d-82203a70451a@arm.com>
Date: Fri, 1 May 2026 12:41:45 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: discard out-of-range delivered_perf
 samples
To: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dcostantino@meta.com, pjaroszynski@nvidia.com, Al.Grant@arm.com,
 linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
References: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/1/26 11:32 AM, Breno Leitao wrote:
> cppc_cpufreq_get_rate() derives delivered_perf as:
> 
>      delivered_perf = reference_perf * delta_delivered / delta_reference
> 
> over a short udelay()-bounded window between two cppc_get_perf_ctrs()
> calls. Per-read latency jitter on the underlying CPC register access
> can skew the ratio, occasionally producing delivered_perf >
> highest_perf. cppc_perf_to_khz() then linearly extrapolates above
> (nominal_perf, nominal_freq), so the value reported via
> /sys/.../cpufreq/cpuinfo_cur_freq exceeds cpuinfo_max_freq.
> 
> Observed on an arm64 host (governor=performance,
> cpuinfo_max_freq=3339 MHz): 15 back-to-back reads returned values
> between 2997 and 4230 MHz.
> 
> Treat an out-of-range sample as invalid and reuse the existing
> out_invalid_counters fallback, which returns the platform's
> desired_perf. This keeps cpuinfo_cur_freq within
> [0, cpuinfo_max_freq] without reporting a value the hardware did
> not deliver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24c..dd92aa2bca464 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -814,6 +814,14 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>   	if (!delivered_perf)
>   		goto out_invalid_counters;
>   
> +	/*
> +	 * Sampling jitter on the CPC counter pair can produce
> +	 * delivered_perf > highest_perf, which cppc_perf_to_khz() would
> +	 * extrapolate to a frequency above cpuinfo_max_freq. Discard.
> +	 */
> +	if (delivered_perf > cpu_data->perf_caps.highest_perf)
> +		goto out_invalid_counters;
> +

A little jitter over, is probably expected. If that is what is happening 
then clamping to highest_perf makes sense instead. But then, this is 
really a sampling problem so does it go away if you double the udelay 
slightly. Maybe the udelay value should be proportional to the 
reference_perf value?

>   	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
>   
>   out_invalid_counters:
> 
> ---
> base-commit: 26fd6bff2c050196005312d1d306889220952a99
> change-id: 20260501-cur_freq-fix-d569cf1d1052
> 
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
> 
> 

