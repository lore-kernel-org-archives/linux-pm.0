Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20C32D452;
	Wed, 25 Mar 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427459; cv=none; b=kP6JC2BGclzR+XYnn97wQ28LSLKXKJEO9o5UQsS9FH1PsZscmJTdId0zfuFPb41yOuXeXpJiq5sBqBwq16o9okq1DA8CWx+nbVDuy5ke0gQHwd7P5MH1KQuA9EdNgOUBHdzJ6YHqmU58WvZc4Vi8Y2CRqij6MMc422Tjyvnk5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427459; c=relaxed/simple;
	bh=EqXSuD1lusRAIw+MCvdqKYnYl9VtMceezX3djiH5qKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Geq02lXBCnR66hv2As8RsuIQtAihY+u+cZBFAM9wOiluV7vZVBYfF1ETHQBpPcaxmu5NcdghhglqYZZ9dw61kTni2JQVeP0eohB0P74vz3itJyh9Rl5TxtuZKIC+V2Xx89wrPFOqSgBNgePpRobnUouD711gR+FTgzd2QtGVX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fGqw//Za; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fGqw//Za"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69AA614BF;
	Wed, 25 Mar 2026 01:30:46 -0700 (PDT)
Received: from [10.57.13.94] (unknown [10.57.13.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AD0E3FB90;
	Wed, 25 Mar 2026 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774427452; bh=EqXSuD1lusRAIw+MCvdqKYnYl9VtMceezX3djiH5qKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fGqw//ZaOB49H4UQyph6NIObP/iCkVdXsk7f75Y13TTn0iE+wMeb0jnYLp3WHdFRN
	 mOkOkz0/oeIixrwawckUoAaGRwJB/nePZDrjEb1XOjEt3AeO+k79VEUH3UuV36BpnJ
	 8/wQ9xymnjNQpLvwBWQxkqDGYEO9PumQ+uEUJKE4=
Message-ID: <fa386a12-cec1-426d-bca2-37e1c9badf91@arm.com>
Date: Wed, 25 Mar 2026 08:31:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in
 get_load()
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Xuewen Yan
 <xuewen.yan@unisoc.com>, rui.zhang@intel.com, rafael@kernel.org,
 linux-pm@vger.kernel.org, amit.kachhap@gmail.com, daniel.lezcano@kernel.org,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com,
 jeson.gao@unisoc.com
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
 <CAB8ipk_VftSn4U+Vzdv_ST7apiONVoYy4PTe7usRetXry6uSOQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk_VftSn4U+Vzdv_ST7apiONVoYy4PTe7usRetXry6uSOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/24/26 12:03, Xuewen Yan wrote:
> On Tue, Mar 24, 2026 at 6:45 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
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
>>
>> Right, there are 2 things to consider:
>> 1. what is the utilization when the CPU still have idle time, e.g.
>>      this 50% that you mentioned
>> 2. what is the utilization when there is no idle time and CPU
>>      is fully busy (and starts throttling due to heat)
>>
>> In this thermal fwk we are mostly in the 2nd case. In that case the
>> utilization on CPU's runqueue goes to 1024 no mater the CPU's frequency.
> 
> Haha, indeed. When we debug IPA, we also keep the CPU constantly
> running with basically no idle time.
> In this scenario, we tested using both sched_cpu_util() and idle_time,
> and for thermal control purposes, there was basically no difference
> (likely because the load was at 100%).
> Maybe we can cook up a test case where the CPU is overheating despite
> having some idle time? That way we can compare how the two interfaces
> perform.

I wish we could involve the GPU in those stress scenarios. Then we could
have some load (e.g. 70% on CPUs) and heavy computation on GPU which
heats up the whole silicon. In such experiment you could observe the
difference from those two methods of input power estimation.

Unfortunately, for the GPU it's hard to craft such benchmark
(at least for me lacking GPU programming experience at that level).
Ideally we could have something which controls the amount of GPU
computation and created heat...


> 
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
>> Let's improve the situation a bit. It would be very much appreciated if
>> you could share information if those changes help your platform
>> (some older boards might not show any benefit with the new code).
>>
> Understood. We appreciate the balance between complexity and accuracy.
> We could test these changes on our platforms and let you know if we
> see any improvements in thermal stability or power estimation. Expect
> an update from us in a few days.
> 

Sounds great, thanks!
