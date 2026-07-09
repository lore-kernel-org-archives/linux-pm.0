Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F83D349E;
	Thu,  9 Jul 2026 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578973; cv=none; b=WBP6Nxnpr6UJb9Af+OQyxbzCkJtQL0JJVYlm0YvOcnSMTDdwAvhu9p5ipHSf8SSi0fpQuayZJ/R9+fPhm1nothEqyfjVcjNlzWeKlV7XPigvdAdazsQjKz6mxPn0cPjXGprHbOwbyLqDV9L/vMNSRjE/tyb5T0J+6f8A3w8bAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578973; c=relaxed/simple;
	bh=iEw1Vq3pIzfLiM41/YSF7kcvAVzrgd3SBDh+S2NKDcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3JjkEImyYm42GbfUNW7OinSYEhL3Cq0CEHpjyJ83qtafrxgyILj2IJ5jo8nMJxtkfHl0i+tdisnrD22maCF+kiSFOWxo54H9mcxMQOMlzk/K9o5bXGm8KT59I/pV7WC7y+oyd+9FBQveJObu7mmR/14E9+2QOePcidTMy6r20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mUDjcKGp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mUDjcKGp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F9D124C0;
	Wed,  8 Jul 2026 23:35:58 -0700 (PDT)
Received: from [192.168.20.93] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D92B3F7B4;
	Wed,  8 Jul 2026 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783578962; bh=iEw1Vq3pIzfLiM41/YSF7kcvAVzrgd3SBDh+S2NKDcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mUDjcKGp5bBXd3G3dy/sHzVG4n3nIgTJN3n4pDSG8CGtT8Ddgt5qUKR5u8Z1ctHhY
	 wLlr5yRPYsHCzXrU2hBWHxv/RYJgTxyuYlMOiMYcm2h7578Z0TCvfB/S63JT8T+PQJ
	 2GWbvJswAUS89xhIoROSPTAGLNjTZV7QCpsjqH+g=
Message-ID: <57dd4cfe-b90d-4077-8933-c7acfd073dce@arm.com>
Date: Thu, 9 Jul 2026 01:36:00 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: Reduce cppc delivered perf sampling jitter
To: Jie Zhan <zhanjie9@hisilicon.com>, linux-pm@vger.kernel.org
Cc: sumitg@nvidia.com, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 viresh.kumar@linaro.org, leitao@debian.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org, zhangpengjie2@huawei.com,
 Will Deacon <will.deacon@arm.com>
References: <20260602212052.1278365-1-jeremy.linton@arm.com>
 <e0090262-34ae-4419-aa9a-fd36901d0a05@hisilicon.com>
 <7b227c98-4ca9-4b2a-9a1d-31e9fc15b842@arm.com>
 <cf89b1dd-29cd-40ee-af58-04bbc8bfec53@hisilicon.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <cf89b1dd-29cd-40ee-af58-04bbc8bfec53@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/26/26 10:13 PM, Jie Zhan wrote:
> 
> 
> On 6/26/2026 4:27 AM, Jeremy Linton wrote:
>> Hi,
>>
>> On 6/25/26 4:55 AM, Jie Zhan wrote:
>>> Hi Jeremy,
>>>
>>> On 6/3/2026 5:20 AM, Jeremy Linton wrote:
>>>> CPPC uses a pair of registers cycling at different frequencies to
>>>> determine an accumulated performance level. For userspace reporting we
>>>> want to convert this to an instantaneous CPU frequency, but over short
>>>> time periods small errors caused by CPPC counter reads can cause
>>>> fairly significant reported frequency variations even when the core
>>>> CPU clock isn't changing.
>>>>
>>>> Reduce this by keeping a start sample fixed and retrying the end
>>>> sample until the counter deltas are large enough to reduce short
>>>> window error, or until adjacent delivered performance estimates are
>>>> within the CPU's observed CPPC read noise floor.
>>>>
>>>> To begin, resample the initial pair a small fixed number of times
>>>> looking for matching delivered performance deltas.  This reduces the
>>>> chance that a disturbed start sample anchors the rest of the
>>>> calculation.
>>>>
>>>> Then look for an end sample while updating the noise floor from the
>>>> best error seen between samples.  The floor remains zero on systems
>>>> with stable feedback reads, but lets noisy systems stop early once
>>>> another retry is unlikely to improve the result.  The retry loop is
>>>> capped at 200 iterations, giving an ~20 usec explicit delay budget
>>>> derived from ndelay(100).
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 68 ++++++++++++++++++++++++++++++----
>>>>    1 file changed, 61 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 7e7f9dfb7a24..362c08def420 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -50,7 +50,7 @@ struct cppc_freq_invariance {
>>>>    static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>>>>    static struct kthread_worker *kworker_fie;
>>>>    -static int cppc_perf_from_fbctrs(u64 reference_perf,
>>>> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>>>>                     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>>>>                     struct cppc_perf_fb_ctrs *fb_ctrs_t1);
>>>>    @@ -750,7 +750,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
>>>>        return (u32)t1 - (u32)t0;
>>>>    }
>>>>    -static int cppc_perf_from_fbctrs(u64 reference_perf,
>>>> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>>>>                     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>>>>                     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>>>>    {
>>>> @@ -771,19 +771,71 @@ static int cppc_perf_from_fbctrs(u64 reference_perf,
>>>>        return (reference_perf * delta_delivered) / delta_reference;
>>>>    }
>>>>    -static int cppc_get_perf_ctrs_sample(int cpu,
>>>> +/* CPPC read noise floor for early retry exit. */
>>>> +static DEFINE_PER_CPU(u64, err_floor);
>>>> +
>>>> +#define CPPC_SAMPLE_MAX_RETRIES    200
>>>> +
>>>> +static int cppc_get_perf_ctrs_sample(int cpu, u64 ref,
>>>>                         struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>>>>                         struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>>>>    {
>>>>        int ret;
>>>> +    s64 last_delivered = 0;
>>>> +    u64 smallest_error = 0;
>>>> +    int tries = 0;
>>>> +    u64 min_counts = ref * 2000;
>>>> +
>>>> +    /* Two subsequent reads with the same offset avoids one off large jitter values */
>>>> +    for (int x = 0; x < 10; x++) {
>>>> +        ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +
>>>> +        ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +
>>>> +        if (last_delivered == cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1))
>>>> +            break;
>>>> +
>>>> +        last_delivered = cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1);
>>>> +    }
>>> Actually I don't quite understand this hunk.
>>> Is it trying to get two exactly same samples of delivered performance?
>>> Isn't that very hard or impossible to meet?
>>
>> Short version, yes, but it seems like its not difficult on machines with lowish frequency delivered/ref registers.
> Ok, so the low resolution of a platform's CPPC performance range enlarges
> error tolerance and hence the above condition can be met.
> 
> That's an unreasonable assumption.  For a platform with a high resolution
> of CPPC performance, i.e. a large highest performance value (ACPI allows 32
> bits), the above approach would be purely overheads I think.

Hmmm, I'm going to reiterate and expand what I said. There seems to be 
three cases here, there is a case where the counter error seems to decay 
with repeat sampling and arrives at 0, or close before the 10th sample, 
ones where the values are hovering around single digits, so the samples 
look random and it will hit zero, usually before the 10th sample, and 
ones which are all over the place usually 10's to 100's of cycles 
different. The first two cases definitly benifit, from this loop. Adding 
https://lkml.org/lkml/2026/7/8/719 seems to make the first two cases 
more likely.

But that said, what helps everywhere is simply adding some "best sample" 
logic to the loop where the sample that is used is the one which 
reflects a minimum between last_delivered and the current sample pair.

With just that change and the above set the worst case error percent 
seems to consistently be less than a 0.2% on the sweep I just did. I've 
seen worse case sample errors but they are consistently off by a small 
but fixed amount that seems to be the result of fixed variation between 
the requested clocks and the AMU registers, and if the requested clock 
is adjusted to match (ex 2600 vs 2630Mhz) the errors fall to less than a 
percent again. I still think noisy systems could cause some largish 
errors but this set's resampling should avoid one off errors that can 
still happen with just the other one.


>>
>> So we are looking for two a-b samples that are equal under the assumption that interrupts/whatever won't have two identical offsets and the CPU can sample them faster than they roll over. If that isn't the case then the platform probably doesn't have a lot of issues with this code path because the counters are running at a fairly high frequency.
>>
>> If your curious, just add some debugging to print abs(last_delivered -cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1)) on your platform before last_delivered is re-assigned.
>>
>> So, this exits almost right away, sometimes, the rest of the time it just exits after the 10 iterations and we potentially we have a little jitter in the start sample. Although interestingly one platform I tried it on the jitter settles and the abs() value there goes down towards 0 later in the loop even when it doesn't reach it.
>>
> Interesting, no idea what hardware jitters can make such a pattern.
>>>
>>>> +    last_delivered = 0;
>>>> +again:
>>>> +    ndelay(100);
>>>>    -    ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
>>>> +    ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
>>>>        if (ret)
>>>>            return ret;
>>>>    -    udelay(2); /* 2usec delay between sampling */
>>>> +    /*
>>>> +     * We want at least two significant figures, if the counts are low, then there
>>>> +     * can be rounding errors that show up as frequency that is swinging around a few hundred
>>>> +     * Mhz. OTOH, if the delay gets too long the clock rate can be affected.
>>>> +     * So we want it exactly long enough to have sufficient counter turn over, and
>>>> +     * a repeatable low error value.
>>>> +     */
>>>> +    if ((get_delta(fb_ctrs_t1->reference, fb_ctrs_t0->reference) < min_counts) ||
>>>> +        (get_delta(fb_ctrs_t1->delivered, fb_ctrs_t0->delivered) < min_counts)) {
>>>> +        s64 delivered = cppc_perf_from_fbctrs(ref, fb_ctrs_t0, fb_ctrs_t1);
>>>> +        u64 error = abs(last_delivered - delivered);
>>>> +
>>>> +        if (smallest_error == 0 || smallest_error > error)
>>>> +            smallest_error = error;
>>>> +
>>>> +        if (error > per_cpu(err_floor, cpu)) {
>>>> +            last_delivered = delivered;
>>>> +            tries++;
>>>> +            if (tries < CPPC_SAMPLE_MAX_RETRIES)
>>>> +                goto again;
>>>> +        }
>>>> +    }
>>>>    -    return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
>>>> +    /* compute a running error */
>>>> +    per_cpu(err_floor, cpu) = (per_cpu(err_floor, cpu) + smallest_error) / 2;
>>>> +
>>>> +    return ret;
>>> Correct me if I'm wrong.  The key point is something like a self-adaptation
>>> process to get an appropriate sampling delay for different platforms or
>>> even each CPU?
>>
>> Yes, and one of the changes I've considered here was tracking what we think is the lowest error sample in these loops and picking that sample rather than the last one.
>>
>> This is a bit ugly and that makes it even worse.
>>
>> I was under the impression when I started this that the "CPPC: reduce FFH feedback-counter sampling skew on arm64" patch wasn't helping on one of the platforms, so I wrote this.
> For quick reference: https://lore.kernel.org/all/20260410094145.4132082-1-zhangpengjie2@huawei.com/
> 
> Yeah that patch only solves the issue of platforms with FFH counters, but
> that does quite well for FFH counters in my view --- less overhead (merge
> CPC reads) and less error (should be <1%).
> 
> Just curious, what's the register type of feedback counters on your platform
> that doesn't work?
>>
>> But I'm going to merge that one into my tree and rerun the across a couple platforms before reposting this one. I think they are vaguely complementary, but lets see.
> Yeah eventually we should have solutions for all register types, i.e. FFH,
> system memory, PCC, etc.
> 
> Sure look forward to the new version then.
>>
>> I'm also sitting on a cpupower patch that re-exposes this on arm64 via that tool if the results don't look wildly wrong most of the time.
>>
>>
>>>>    }
>>>>      static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>> @@ -799,7 +851,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>>          cpu_data = policy->driver_data;
>>>>    -    ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
>>>> +    ret = cppc_get_perf_ctrs_sample(cpu, cpu_data->perf_caps.reference_perf,
>>>> +                    &fb_ctrs_t0, &fb_ctrs_t1);
>>>> +
>>>>        if (ret) {
>>>>            if (ret == -EFAULT)
>>>>                /* Any of the associated CPPC regs is 0. */
>>
>>

