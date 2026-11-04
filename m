Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804972;
	b=B1wgv8kzSNhIjXmrXgim5ZIAZn0YCUoBGj2GkHliNl1PipJuveFHr9zqePa6qlTE3BOC
	 D5X4D0i7DbrIeX+l5e6h993V2DFQgE2p7ROofRnWb3Pr49/lp9z9ZKj05tnQ3WOCQbt/I
	 urBAEEKVUooPjqeZIR1bMs10u9mwc1ebGvrEgX+ZB0yshF8/sD7bHghIMzDIIpwlV/PtS
	 Bti1ZpXdxTKqXERUscCAzjxnnme2L6bBfzx5P3qNAhDzPodis0SHtxCms4ThxZUC9eVht
	 vWnJsfbUmbtGq68BsNCXHv21Ziey6tqZm3Yx0bqv03sQl4HAKyErAkynPoTkXsfCeDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804972;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VLWahV266QOSDuhAT7p+yZvqfgeyvZg5t4mEncPYO54=;
	b=kqq7lo6dSv9agQWo6mfrHEDqmh0QHfKHr73vhfHtDRxSDpTd+fkcs+XbHkQ9zcaXSai/
	 gMMnXLHbr9q6dAJOmG6OvYmrtviHp/PcNqFiCdZ4Epn8pkzRAKIiR6JXlAnVc284QuVDc
	 np4TvssGpdlvnwpWnbhiRMU5a/SYP8k8KmHi/c6ifV6oVxTOxvSIniWVYmfLZ+WGo0Xsu
	 oOUvbLeWN0EGNxum11qVyLgMa+LUNiLzQ/cQnl2Uk6JmztMbpSnKdl231bSyIunuyALPD
	 v13Nqi3S0Hjc2bc/H3UJFsdz0I3j3uNiCJLlkly4Om6rSjQr/YOU+psBqAFW0ya868A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Kbda1jK9;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40415606A336
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 15:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40415606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Kbda1jK9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B28C1576;
	Wed,  4 Nov 2026 07:09:27 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669B53F632;
	Wed,  4 Nov 2026 07:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793804970; bh=Hlk0MKESAm1ihdnF1sRqBNYloYsm/l6Xq1AmYwalUl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kbda1jK9h8FGhjsYs5WzOi2mw1/bCU1LnwcwtbAI6hwcb4Kk0CfoMMzlXbU7WfNR9
	 AWHWjQmnBKgenP5OSPSw+k+G5ZYto3X0eFz4+zOjhZAHwRF7WvjzhIXwggsiAcszqD
	 evItU3h0k/uglHolRjAzAg4bvnIuNUZ2stRKnHjg=
Message-ID: <defdec33-3006-4ecd-a5d9-c323af70047c@arm.com>
Date: Wed, 4 Nov 2026 15:09:25 +0000
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
Subject: Re: [PATCH v2 2/3] cpufreq: Force passing target frequency to driver
 during resume
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>,
 Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
 <1995295.tdWV9SEqCh@rafael.j.wysocki>
 <f6e8c9b9-3bda-4001-a08e-8484b58575ea@arm.com>
 <CAJZ5v0hQOjNP8tWfyKKV9UPUDSFWFsKVpcc_HZjpi8WHO6p_1Q@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hQOjNP8tWfyKKV9UPUDSFWFsKVpcc_HZjpi8WHO6p_1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/26 13:44, Rafael J. Wysocki (Intel) wrote:
> On Wed, Nov 4, 2026 at 12:56 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/3/26 19:47, Rafael J. Wysocki wrote:
>>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>
>>> The policy->cur value preserved across a system suspend-resume cycle
>>> may become stale in some cases and it may prevent the CPU performance
>>> scaling logic from being updated due to the target_freq == policy->cur
>>> check in __cpufreq_driver_target() [1].
>>>
>>> To address this, adjust the existing mechanism to force the invocation
>>> of the driver .target() callback in __cpufreq_driver_target() and make
>>> cpufreq_resume_policy() use it.
>>>
>>> This involves renaming update_limits in struct cpufreq_policy to
>>> force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag check
>>> from __cpufreq_driver_target() to cpufreq_set_policy(), where it is used
>>> as a condition for setting policy->force_target.
>>>
>>> In cpufreq_resume_policy(), policy->force_target is set for drivers that
>>> implement the .target() callback, but don't implement the .get() one,
>>> which is the case when the driver callback needs to run if policy->cur
>>> becomes stale while suspended.
>>>
>>> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
>>> Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
>>> Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
>>> Reported-by: Doug Smythies <dsmythies@telus.net>
>>> Cc: All applicable <stable@vger.kernel.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v1 -> v2:
>>>    * Always clear policy->force_target if set in __cpufreq_driver_target()
>>>      to avoid forcing the driver callback next time unnecessarily (Sashiko)
>>>
>>>    * Replace an outdated comment in __cpufreq_driver_target()
>>>
>>>    * Set policy->force_target only if .target() is present and .get() is not
>>>      present because that is the only case in which it may matter
>>>
>>>    * Update changelog
>>>
>>> ---
>>>  drivers/cpufreq/cpufreq.c |   33 +++++++++++++++++++++------------
>>>  include/linux/cpufreq.h   |    4 ++--
>>>  2 files changed, 23 insertions(+), 14 deletions(-)
>>>
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -2023,6 +2023,15 @@ static void cpufreq_resume_policy(struct
>>>       if (!start)
>>>               return;
>>>
>>> +     /*
>>> +      * Force executing the driver .target() callback, if present, in the
>>> +      * next invocation of __cpufreq_driver_target() in case policy->cur has
>>> +      * become stale while suspended, but do it only for drivers without a
>>> +      * .get() callback for which cpufreq_verify_current_freq() is a NOP.
>>> +      */
>>> +     if (cpufreq_driver->target && !cpufreq_driver->get)
>>> +             policy->force_target = true;
>>> +
>>>       if (cpufreq_start_governor(policy))
>>>               pr_err("%s: Failed to start governor for CPU%u's policy\n",
>>>                      __func__, policy->cpu);
>>> @@ -2400,17 +2409,14 @@ int __cpufreq_driver_target(struct cpufr
>>>               policy->cpu, policy->cur, target_freq, old_target_freq, relation);
>>>
>>>       /*
>>> -      * This might look like a redundant call as we are checking it again
>>> -      * after finding index. But it is left intentionally for cases where
>>> -      * exactly same freq is called again and so we can save on few function
>>> -      * calls.
>>> +      * Unless invoking the target callback is forced, skip the update if the
>>> +      * frequency is not really changing.
>>>        */
>>> -     if (target_freq == policy->cur) {
>>> -             if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
>>> -                 !policy->update_limits)
>>> -                     return 0;
>>> -
>>> -             policy->update_limits = false;
>>> +     if (policy->force_target) {
>>> +             /* Avoid forcing the driver callback unnecessarily next time. */
>>> +             policy->force_target = false;
>>> +     } else if (target_freq == policy->cur) {
>>> +             return 0;
>>>  [snip]
>>
>> This is too early though? Should be something like:
> 
> I don't think so.
> 
> If the driver has a problem, there is not much the core can do about it.
> 
> Do you have any specific drivers in mind here?

Well drivers cppc_cpufreq is certainly possible with PCC.
I don't have a platform where this would likely be an issue, but MPAR limits
is an obvious one. For resume specifically, interestingly enough, MPAR limits
uses ktime_get() instead of _boottime, so it might not be entirely unreasonable
that we would hit this.
That being said cppc_cpufreq implements .get() making the above moot for resume.
Nonetheless the old update_limits path retained the update_limits flag on the write
failure and now we drop force_target?

> [snip]
