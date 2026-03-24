Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116F314B9A;
	Tue, 24 Mar 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349159; cv=none; b=cFhOre+FjDGTafmEmb+Ekdi0Hzggkpy9KTtU6GAvDr8z9dVUq0QdcgwrYeHennwFGLYZnNfnGaaOr+b+ljVSOcA1lswx1QmFFOER6SNoOGKS07fXe2UgckoEp7u3KGROZJryTfAsHIXGAW6eDZygBP3FKHy4a3zjCEzDcUEZlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349159; c=relaxed/simple;
	bh=kl5JpWSEg1Bcj0sTVtfuhTNbit5VChhfxAfy/A6iJbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hu5/1xXniFxeVI9x9FiPJWqKy3zsDNpBoCq7Q0tf4T3F226xBTULwmpK2KvdAh6GUMeoaUQmFSmrThh4mju0Yj/tiLfwBlziZEPP+j91Ds5QPEWniIi3FaN6IHNMIlTkHa9Lk6HBROicxlyP1y+/maZ6w+oDOpaRBUzVOBlFX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE1351476;
	Tue, 24 Mar 2026 03:45:50 -0700 (PDT)
Received: from [10.57.20.186] (unknown [10.57.20.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CCCC3FDF5;
	Tue, 24 Mar 2026 03:45:54 -0700 (PDT)
Message-ID: <35d472ac-8a58-44c5-a0b1-5e1de8ac6cfc@arm.com>
Date: Tue, 24 Mar 2026 10:46:11 +0000
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
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk_7MGUza9_izMypMxPFUjAoB34ZZp0-ts4w6eJ+tr+MDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/24/26 02:20, Xuewen Yan wrote:
> On Mon, Mar 23, 2026 at 9:25 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 3/23/26 11:06, Viresh Kumar wrote:
>>> On 23-03-26, 10:52, Lukasz Luba wrote:
>>>>> How is that okay ? What am I missing ?
>>>
>>> I was missing !SMP :)
>>>
>>>> Right, there is a mix of two things.
>>>> The 'i' left but should be removed as well, since
>>>> this is !SMP code with only 1 cpu and i=0.
> 
> That's also why we sent out patch 1/2; after all, it is always 0 on
> !SMP systems.
> 
>>>>
>>>> The whole split which has been made for getting
>>>> the load or utilization from CPU(s) needs to be
>>>> cleaned. The compiled code looks different since
>>>> it knows there is non-SMP config used.
>>>
>>> Right, we are allocating that for num_cpus (which should be 1 CPU
>>> anyway). The entire thing must be cleaned.
>>>
>>>> Do you want to clean that or I should do this?
>>>
>>> It would be helpful if you can do it :)
>>>
>>
>> OK, I will. Thanks for your involvement Viresh!
>>
>> Xuewen please wait with your v2, I will send
>> a redesign of this left code today.
> 
> Okay, and Qais's point is also worth considering: do we actually need
> sched_cpu_util()?
> The way I see it, generally speaking, the request_power derived from
> idle_time might be higher than what we get from sched_cpu_util().
> Take this scenario as an example:
> Consider a CPU running at the lowest frequency with 50% idle time,
> versus one running at the highest frequency with the same 50% idle
> time.
> In this case, using idle_time yields the same load value for both.
> However, sched_cpu_util() would report a lower load when the CPU
> frequency is low. This results in a smaller request_power...

Right, there are 2 things to consider:
1. what is the utilization when the CPU still have idle time, e.g.
    this 50% that you mentioned
2. what is the utilization when there is no idle time and CPU
    is fully busy (and starts throttling due to heat)

In this thermal fwk we are mostly in the 2nd case. In that case the
utilization on CPU's runqueue goes to 1024 no mater the CPU's frequency.
We know which highest frequency was allowed to run and we pick the power
value from EM for it. That's why the estimation is not that bad (apart
from power variation for different flavors of workloads: heavy SIMD vs.
normal integer/load).

In 1st case scenario we might underestimate the power, but that
is not the thermal stress situation anyway, so the max OPP is
still allowed.

So far it is hard to find the best power model to use and robust CPU
load mechanisms. Adding more complexity and creating some
over-engineered code in the kernel to maintain might not have sense.
The thermal solutions are solved in the Firmware nowadays since the
kernel won't react that fast for some rapid changes.

We have to balance the complexity here.
Let's improve the situation a bit. It would be very much appreciated if
you could share information if those changes help your platform
(some older boards might not show any benefit with the new code).

Regards,
Lukasz

