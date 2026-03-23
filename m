Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251D387371;
	Mon, 23 Mar 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257634; cv=none; b=THvY/xPUtqBSkUN1RkfT2lhDW1KdYoe1776FiYe691mn25yDQBSzA8u5+8vnqkFfzJkKZEr/UCZ5EuhPTB5/1Xtgcm5oyyxcwUyecth8hS4uY12TzkZo+SbuDhtcfiGKl+ptIpc8D6vA4gAjIXDCF0NTMScRGZwDGMSuC/YcNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257634; c=relaxed/simple;
	bh=iVUSSd7ssbGwFm3ZYJXyowu6VgSYWkKDPL/9Ad8FaXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGyYJXiU5d5QSi2jvWT3g3xFihfQZDwjwu6SirGvQYa3VDXbUniTd/l6fUBLkL9UJ+Qnltp4k5tAb+Um2QT1vYdXrZkqnUYhPOYk+ONkxBYH4vfRtRu3RGM5KNK5emk+hnjOdZrIu5d0+3+s0951vdhBd894k4AP5PF941rM/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D3AB1516;
	Mon, 23 Mar 2026 02:20:25 -0700 (PDT)
Received: from [10.57.17.171] (unknown [10.57.17.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 987C73F885;
	Mon, 23 Mar 2026 02:20:28 -0700 (PDT)
Message-ID: <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
Date: Mon, 23 Mar 2026 09:20:45 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in
 get_load()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com,
 rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
 di.shen@unisoc.com, jeson.gao@unisoc.com, xuewen.yan94@gmail.com
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Viresh,

On 3/23/26 05:34, Viresh Kumar wrote:
> On 20-03-26, 12:32, Lukasz Luba wrote:
>> Hi Xuewen,
>>
>> On 3/20/26 11:31, Xuewen Yan wrote:
>>> From: Di Shen <di.shen@unisoc.com>
>>>
>>> The cpu_idx variable in the get_load function is now
>>> unused and can be safely removed.
>>>
>>> No code logic is affected.
>>>
>>> Signed-off-by: Di Shen <di.shen@unisoc.com>
>>> ---
>>>    drivers/thermal/cpufreq_cooling.c | 13 +++++--------
>>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
>>> index 32bf5ab44f4a..d030dbeb2973 100644
>>> --- a/drivers/thermal/cpufreq_cooling.c
>>> +++ b/drivers/thermal/cpufreq_cooling.c
>>> @@ -151,26 +151,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>>>     * get_load() - get load for a cpu
>>>     * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
>>>     * @cpu: cpu number
>>> - * @cpu_idx: index of the cpu in time_in_idle array
>>>     *
>>>     * Return: The average load of cpu @cpu in percentage since this
>>>     * function was last called.
>>>     */
>>>    #ifdef CONFIG_SMP
>>> -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>>> -		    int cpu_idx)
>>> +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
>>>    {
>>>    	unsigned long util = sched_cpu_util(cpu);
>>>    	return (util * 100) / arch_scale_cpu_capacity(cpu);
>>>    }
>>>    #else /* !CONFIG_SMP */
>>> -static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>>> -		    int cpu_idx)
>>> +static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu)
>>>    {
>>>    	u32 load;
>>>    	u64 now, now_idle, delta_time, delta_idle;
>>> -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
>>> +	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu];
>>
>> This is a bug. We allocate 'num_cpus' size of array based on
>> number of CPU in the cpumask for a given cpufreq policy.
>> If there are 4 cpus in the CPU cluster but CPUs have ids:
>> CPU4-7 then accessing it with this change would explode.
> 
> I think following commit introduced a bug by removing `i++`.
> 
> commit 3f7ced7ac9af ("drivers/thermal/cpufreq_cooling : Refactor thermal_power_cpu_get_power tracing")
> 

Thanks for monitoring the development (it's always good
to have extra engineer opinion)!

I've checked the commit that you referred to and the 'i++' there.
It's safe. That commit removed the heavy operation for only
tracing purpose, namely:
- allocate buffer for N CPUs for 'load_cpu' pointer
- populate CPUs' load from the idle fwk
- put that info into the trace
- free the 'load_cpu' buffer

That has been redesigned since it was just for tracing
and introducing extra time spent for code run in the
throttling phase.

The code in get_load() is OK with the commit that you
mentioned.

Regards,
Lukasz


