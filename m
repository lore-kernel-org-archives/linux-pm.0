Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0B330B09;
	Thu, 26 Mar 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516898; cv=none; b=k96FzQ1XzAfwRUVzNLEksDL39VpeUgMBt6KMfD+mqudmt+/BpdSsz2YKxZOBl9vlyTGkqi037JZWBOc0Mw3WJKpp/V3eMMDjo+m6LwAp1cweuYzhGxpAttXhTeE3iF1fqEb/fN2d1fMuYtckw0ppR+1meW0Cqmn6iJqL8taRPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516898; c=relaxed/simple;
	bh=7OTVafjmyVnxgcgdn09d70Z6scwb+pRRb5oNN0xBKDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOWQI91ShqmHspRFF3DDRSg4WOhMoYbo7p8Adv3CNn8a+ztCyAtEVYJ5HLNL9CL7gYkLq7aSwdhTGSUlPLc/RbV5fludz3LC5ptLcXMqLgGeShDyGhTaoDakkBzcpCHQa1ilXm0TyUgWOPwL4dpc4yJP+7VSY+OW+wgDfkuKis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K/SgzzoL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K/SgzzoL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3146416F3;
	Thu, 26 Mar 2026 02:21:29 -0700 (PDT)
Received: from [10.57.16.191] (unknown [10.57.16.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4093F915;
	Thu, 26 Mar 2026 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774516895; bh=7OTVafjmyVnxgcgdn09d70Z6scwb+pRRb5oNN0xBKDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K/SgzzoLfTThcNqTZXvweRYslfrAC8Q1XtiQVRv0VuZeOfn57LcMS1+i/Jo8NbblY
	 DOvJ0InMup9wuuDAOIWkU3ZLDT0pv54mEuT4fIhIZ9l7TbBoXw7szUW6Fp+BpX3Mvl
	 lLQqkvRyjDlhsEUfGpJwt8jHykH69SVQ63vAk7vk=
Message-ID: <c816757a-3169-4d5f-942b-4c49be89ebe1@arm.com>
Date: Thu, 26 Mar 2026 09:21:49 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in
 get_load()
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Xuewen Yan <xuewen.yan@unisoc.com>,
 rui.zhang@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 amit.kachhap@gmail.com, daniel.lezcano@kernel.org,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com,
 jeson.gao@unisoc.com, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
 <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
 <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com>
 <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
 <2a71d446-3277-4b8e-9b29-b77ebd3a4381@arm.com>
 <CAB8ipk_7MGUza9_izMypMxPFUjAoB34ZZp0-ts4w6eJ+tr+MDw@mail.gmail.com>
 <35d472ac-8a58-44c5-a0b1-5e1de8ac6cfc@arm.com>
 <20260326090554.jerlaudbe3rkovsi@airbuntu>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260326090554.jerlaudbe3rkovsi@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/26/26 09:05, Qais Yousef wrote:
> On 03/24/26 10:46, Lukasz Luba wrote:
>>
>> On 3/24/26 02:20, Xuewen Yan wrote:
>>> On Mon, Mar 23, 2026 at 9:25 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/23/26 11:06, Viresh Kumar wrote:
>>>>> On 23-03-26, 10:52, Lukasz Luba wrote:
>>>>>>> How is that okay ? What am I missing ?
>>>>>
>>>>> I was missing !SMP :)
>>>>>
>>>>>> Right, there is a mix of two things.
>>>>>> The 'i' left but should be removed as well, since
>>>>>> this is !SMP code with only 1 cpu and i=0.
>>>
>>> That's also why we sent out patch 1/2; after all, it is always 0 on
>>> !SMP systems.
>>>
>>>>>>
>>>>>> The whole split which has been made for getting
>>>>>> the load or utilization from CPU(s) needs to be
>>>>>> cleaned. The compiled code looks different since
>>>>>> it knows there is non-SMP config used.
>>>>>
>>>>> Right, we are allocating that for num_cpus (which should be 1 CPU
>>>>> anyway). The entire thing must be cleaned.
>>>>>
>>>>>> Do you want to clean that or I should do this?
>>>>>
>>>>> It would be helpful if you can do it :)
>>>>>
>>>>
>>>> OK, I will. Thanks for your involvement Viresh!
>>>>
>>>> Xuewen please wait with your v2, I will send
>>>> a redesign of this left code today.
>>>
>>> Okay, and Qais's point is also worth considering: do we actually need
>>> sched_cpu_util()?
>>> The way I see it, generally speaking, the request_power derived from
>>> idle_time might be higher than what we get from sched_cpu_util().
>>> Take this scenario as an example:
>>> Consider a CPU running at the lowest frequency with 50% idle time,
>>> versus one running at the highest frequency with the same 50% idle
>>> time.
>>> In this case, using idle_time yields the same load value for both.
>>> However, sched_cpu_util() would report a lower load when the CPU
>>> frequency is low. This results in a smaller request_power...
> 
> Invariance will cause settling time to stretch longer, but it should settle to
> the correct value eventually. But generally another case against util is that
> it has grown to be a description of compute demand more than true idleness of
> the system.
> 
>>
>> Right, there are 2 things to consider:
>> 1. what is the utilization when the CPU still have idle time, e.g.
>>     this 50% that you mentioned
>> 2. what is the utilization when there is no idle time and CPU
>>     is fully busy (and starts throttling due to heat)
> 
> Hmm I think what you're trying to say here we need to distinguish between two
> cases 50% or fully busy? I think how idle the system is a better question to
> ask rather than what is the utilization (given the ubiquity of the signal
> nowadays)

Yes, these two cases, which are different and util signal is not the
best for that idleness one.


> 
>>
>> In this thermal fwk we are mostly in the 2nd case. In that case the
> 
> But from power allocator perspective (which I think is the context, right?),
> you want to know if you can shift power?

I would like to know the avg power in the last X ms window, then
allocate, shift, set.

> 
>> utilization on CPU's runqueue goes to 1024 no mater the CPU's frequency.
>> We know which highest frequency was allowed to run and we pick the power
>> value from EM for it. That's why the estimation is not that bad (apart
>> from power variation for different flavors of workloads: heavy SIMD vs.
>> normal integer/load).
>>
>> In 1st case scenario we might underestimate the power, but that
>> is not the thermal stress situation anyway, so the max OPP is
>> still allowed.
>>
>> So far it is hard to find the best power model to use and robust CPU
>> load mechanisms. Adding more complexity and creating some
>> over-engineered code in the kernel to maintain might not have sense.
>> The thermal solutions are solved in the Firmware nowadays since the
>> kernel won't react that fast for some rapid changes.
>>
>> We have to balance the complexity here.
> 
> I am not verse in all the details, so not sure what complexity you are
> referring to. IMHO the idle time is a more stable view for how much a breathing
> room the cpu has. It also deals better with long decay of blocked load
> over-estimating the utilization. AFAICS just sample the idle over a window when
> you need to take a decision and you'd solve several problems in one go.

We have issues in estimating power in that X ms window due to fast
frequency changes. You know how often we can change the frequency,
almost per-task enqueue (and e.g. uclamp pushes that even harder).

Simple approach for assuming that the frequency we see now on CPU
has been there for the whole Xms period is 'not the best'.
The util information w/o uclamp information is not helping
much (even we we would try to derive the freq out of it).

Now even more complex - the FW can change the freq way often
than the kernel. So the question is how far we have to push
the whole kernel and those frameworks to deal with those new
platforms.

Then add the power variation due to different computation types
e.g. SIMD heavy vs simple logging task (high power vs. low power
usage at the same OPP).

IMHO we have to find a balance since even more complex models
in kernel won't be able to handle that.

I have been experimenting with the Active Stats patch set for
quite a while, but then FW came into the equation and complicated
the situation. It will be still better for such platform
where FW doesn't change the freq, so this approach based on
idle stats is worth to add IMO.
