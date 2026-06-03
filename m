Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E643E5ED7;
	Wed,  3 Jun 2026 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505218; cv=none; b=mZvJFpwEXFzTWN04euxkiNy6YqOxPF6t3HIrGwwkmsT/iGgmF3yFNxbNCTGoSkBXZn/iViSX4YeSj/l7nuV+MoTKgcJu5KwT0pGYk2IVn1E/YIYnlLYn2WObbjewYoNXpQTM+c2C5NZJ2uYsc0FLDnzTBfO7M9UgXAKVhZscafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505218; c=relaxed/simple;
	bh=Tfx4LyDsj7PXNXaX6d+aSPDijizf4f2s8CV9h+iZEos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqIZkZUOpOagLjZXSvpsUoCEyzxxkR8bpAQv/CVYSnrLuQMu36vwVSCGpsufeH1ysP5AjkA4011auyw8LgcV8gFS+0EkntotKxOjx2HPZ3/4Gqc5rw3nSKHsDEju2CmnlwCZIVnAbXNvR9xCZ0D/0CSbCFU+70BN6pkc04/jAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eF6MnDEg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eF6MnDEg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DEB535D5;
	Wed,  3 Jun 2026 09:46:51 -0700 (PDT)
Received: from [192.168.122.164] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFCE13F86F;
	Wed,  3 Jun 2026 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780505216; bh=Tfx4LyDsj7PXNXaX6d+aSPDijizf4f2s8CV9h+iZEos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eF6MnDEgcYPYjnjBR9jsmYW0GKk+o6EQA2IuPqjAR9631MIcAyrOx2HaA9QYrpYYE
	 TgxNa1CvufywnuU10YneAOwgGCYwpD0A7LzyJZ4mEoEtr2HFOalbdLPUMDdobMrZ0F
	 nwzCe/nQcPLKH40P3jbCWJrsbmPzsRQaw2/mQzdM=
Message-ID: <f047de36-5d0a-489e-84ee-4bab0a1fd8d4@arm.com>
Date: Wed, 3 Jun 2026 11:46:51 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: Reduce cppc delivered perf sampling jitter
To: Breno Leitao <leitao@debian.org>
Cc: linux-pm@vger.kernel.org, sumitg@nvidia.com, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, viresh.kumar@linaro.org,
 rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20260602212052.1278365-1-jeremy.linton@arm.com>
 <aiAGtKDKTVy2e4ds@gmail.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <aiAGtKDKTVy2e4ds@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for looking at this.

On 6/3/26 5:54 AM, Breno Leitao wrote:
> On Tue, Jun 02, 2026 at 04:20:52PM -0500, Jeremy Linton wrote:
>> CPPC uses a pair of registers cycling at different frequencies to
>> determine an accumulated performance level. For userspace reporting we
>> want to convert this to an instantaneous CPU frequency, but over short
>> time periods small errors caused by CPPC counter reads can cause
>> fairly significant reported frequency variations even when the core
>> CPU clock isn't changing.
>>
>> Reduce this by keeping a start sample fixed and retrying the end
>> sample until the counter deltas are large enough to reduce short
>> window error, or until adjacent delivered performance estimates are
>> within the CPU's observed CPPC read noise floor.
>>
>> To begin, resample the initial pair a small fixed number of times
>> looking for matching delivered performance deltas.  This reduces the
>> chance that a disturbed start sample anchors the rest of the
>> calculation.
>>
>> Then look for an end sample while updating the noise floor from the
>> best error seen between samples.  The floor remains zero on systems
>> with stable feedback reads, but lets noisy systems stop early once
>> another retry is unlikely to improve the result.  The retry loop is
>> capped at 200 iterations, giving an ~20 usec explicit delay budget
>> derived from ndelay(100).
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 68 ++++++++++++++++++++++++++++++----
>>   1 file changed, 61 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 7e7f9dfb7a24..362c08def420 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -50,7 +50,7 @@ struct cppc_freq_invariance {
>>   static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>>   static struct kthread_worker *kworker_fie;
>>   
>> -static int cppc_perf_from_fbctrs(u64 reference_perf,
>> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>>   				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>>   				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
>>   
>> @@ -750,7 +750,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
>>   	return (u32)t1 - (u32)t0;
>>   }
>>   
>> -static int cppc_perf_from_fbctrs(u64 reference_perf,
>> +static u64 cppc_perf_from_fbctrs(u64 reference_perf,
>>   				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>>   				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>>   {
>> @@ -771,19 +771,71 @@ static int cppc_perf_from_fbctrs(u64 reference_perf,
>>   	return (reference_perf * delta_delivered) / delta_reference;
>>   }
>>   
>> -static int cppc_get_perf_ctrs_sample(int cpu,
>> +/* CPPC read noise floor for early retry exit. */
>> +static DEFINE_PER_CPU(u64, err_floor);
>> +
>> +#define CPPC_SAMPLE_MAX_RETRIES	200
> 
> Could the remaining tuning literals get the same treatment?
> Specifically:
> 
> - the 10 initial-resample iteration count
> - the 2000 multiplier in ref * 2000
> - the 100 ns in ndelay(100)

Sure. A few of these were personal judgment from the platforms I tried 
it on. I had some instrumentation at the bottom which was printing loop 
counts and error values and largely I picked those values based on how 
they were behaving, or back of the evelope estimates. For example, that 
200 is afaik overkill, its usually settles down around 20 or less, which 
makes this faster than the old method on at least one platform I tried 
it on. And they are all intended to be "upper bound" exit the loop 
because something isn't working right values.


I'm interested in whether this patch stabilizes the frequency reporting 
in some of the cases I've heard people talking about.




