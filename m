Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D1386426;
	Thu, 30 Jul 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403666; cv=none; b=BJTVt0coLo39Eb94hulKC7LHptO1+Oqalk4gWmK0NyclPfFq3uURtGsmhm8A0plzjJANvJCQfCLyk2ykf5zAlhIuQiAHytt3ZlbgWa7Qv4xADcuwHK6gJDZ8HPgiW2XTCWZyZlDWw3umVsYJAnMDqnfGoFMfU0vWeW/XeAXidxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403666; c=relaxed/simple;
	bh=X1iWcnkOhql0GiprHifQRKWI20qkUqHkCZbEvRsYlnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZAMIkExI6le/VB2uTDLtlfKnQogxVBLJyTPVsfOgapKcC3sRXvxHvn//0xugdtK4UvpqLqBN22Glp01/GlhAGuGYcAd2CGelPOe1t6fcSClu6I95RaucvAWAtrOL1ai+CjZxxPV+yzhlVEt0BOyqPWhr6MA4gLdngrvVK1I50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rq6FfkUS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rq6FfkUS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58D9E1684;
	Thu, 30 Jul 2026 02:27:33 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACFBB3F763;
	Thu, 30 Jul 2026 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785403657; bh=X1iWcnkOhql0GiprHifQRKWI20qkUqHkCZbEvRsYlnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rq6FfkUS1P32rjnOZTjgmt1DBYsE40GBdAnqFdrrmDzuYeDyclLH6eg1d8n+DgA2s
	 8VbLHEssLgCklGXNwsuMk92h/UKj73arUkCfqb4uPWY5oW6v6r9tEIjFngAzg73g0e
	 etSz1DjYBtzemScHWTOmIpw7MOIyi8+4669b1nXc=
Message-ID: <d2d0f828-6b47-4e1b-8588-2bbade8acfaf@arm.com>
Date: Thu, 30 Jul 2026 10:27:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] sched/idle: Sysbench threads regression after
 f4c31b07b136
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>,
 rafael.j.wysocki@intel.com, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, frederic@kernel.org,
 linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev
References: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
 <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
 <5f5cb821-92ae-4539-ae81-a43e33a7ded5@arm.com>
 <f5946a8a-43be-49d4-a827-25149112b21f@oracle.com>
 <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
 <CAJZ5v0iPonKR6CDykRr4soKFmRAcf3fUfaMA1WrZ8_gHKgukPw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0iPonKR6CDykRr4soKFmRAcf3fUfaMA1WrZ8_gHKgukPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/29/26 19:25, Rafael J. Wysocki (Intel) wrote:
> On Tue, Jul 28, 2026 at 10:30 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 7/24/26 18:20, Joseph Salisbury wrote:
>>> Hi Rafael, Christian,
>>>
>>> On 7/6/26 10:29 AM, Christian Loehle wrote:
>>>> On 7/2/26 19:47, Rafael J. Wysocki (Intel) wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Jul 2, 2026 at 6:30 PM Joseph Salisbury
>>>>> <joseph.salisbury@oracle.com> wrote:
>>>>>> Hi Rafael,
>>>>>>
>>>>>> We are seeing a reproducible MySQL Sysbench threads regression.  A
>>>>>> bisect indicated the following commit as the first bad commit:
>>>>>> f4c31b07b136 ("sched: idle: Consolidate the handling of two special cases")
>>>>>>
>>>>>> The regression was found in Oracle kernel performance testing on OCI VM
>>>>>> shapes:
>>>>>>
>>>>>> VM Details:
>>>>>> * VM.Standard2.1:
>>>>>>         x86 OCI VM shape, 1 OCPU / 2 hardware threads, about 14.5 GB RAM
>>>>>>
>>>>>>    * VM.Standard.A1.Flex.2:
>>>>>>         Arm/Ampere A1 flexible VM shape, 2 vCPU threads, about 10.9 GB RAM
>>>>>>
>>>>>>
>>>>>> The ResultsDB runs show the regression in the Sysbench threads metric:
>>>>>>
>>>>>>     - VM.Standard2.1:       333 -> 236  (-29.1%)
>>>>>>     - VM.Standard.A1.Flex.2: 1286 -> 1152 (-10.4%)
>>>>>>
>>>>>> A test kernel was built with f4c31b07b136 reverted and the performance
>>>>>> regression was recovered.
>>>>>>
>>>>>>   From the code, it is possible the regression is due to the new
>>>>>> previous-wakeup heuristic in the special idle cases.  Before the commit:
>>>>>>
>>>>>>     - no cpuidle driver:
>>>>>>         tick_nohz_idle_stop_tick()
>>>>>>         default_idle_call()
>>>>>>
>>>>>>     - one idle state:
>>>>>>         tick_nohz_idle_retain_tick()
>>>>>>         cpuidle state 0
>>>>> I think that this is your case and the tick stops for you sometimes
>>>>> now while it had never stopped before.
>>>>>
>>>>> Can you confirm?
>>> The guest-visible data does not show the single-idle-state cpuidle case.
>>> Both affected guests report:
>>>
>>> /sys/devices/system/cpu/cpuidle/current_driver = none
>>> /sys/devices/system/cpu/cpuidle/current_governor = menu
>>>
>>> There are also no /sys/devices/system/cpu/cpu*/cpuidle entries on either guest.  So from the guest data, this looks like the no-cpuidle-driver special case rather than the one-idle-state case.
>>>
>>> The full revert of f4c31b07b136 recovered the regression. I also tested Rafael's suggested one-line change, applied as:
>>>
>>>     -        idle_call_stop_or_retain_tick(stop_tick);
>>>    +        idle_call_stop_or_retain_tick(false);
>>>
>>> That test kernel still showed regressed performance on VM.Standard2.1.
>>>
>>>
>>>>>
>>>>> Overall, it would be good to know the idle state lists for both the VM
>>>>> and the host.
>>> For the VMs, there are no guest cpuidle state lists exposed because the cpuidle driver is "none".
>>>
>>> I do not currently have the host-side idle-state lists from the OCI hosts.  I can try to get that data if it would still be useful.
>>>>>
>>>> +1, but also which HZ are you using?
>>> VM.Standard2.1, x86_64:
>>>
>>> CONFIG_HZ_1000=y
>>> CONFIG_HZ=1000
>>>
>>> VM.Standard.A1.Flex.2, aarch64:
>>>
>>> CONFIG_HZ_250=y
>>> CONFIG_HZ=250
>>>
>>>> Both systems reported have 2 logical CPUs then?
>>>
>>> Yes:
>>>
>>> VM.Standard2.1:
>>>
>>> CPU(s): 2
>>> Thread(s) per core: 2
>>> Core(s) per socket: 1
>>> Socket(s): 1
>>>
>>> VM.Standard.A1.Flex.2:
>>>
>>> CPU(s): 2
>>> Thread(s) per core: 1
>>> Core(s) per socket: 2
>>> Socket(s): 1
>>>
>>>> Were higher core counts also
>>>> tested and how does it affect them?
>>> Yes. Higher-core-count runs were checked. The regression appears limited to the smaller core-count shapes.
>>>
>>> The current data shows regressions on:
>>>
>>> - VM.Standard2.1
>>> - VM.Standard.A1.Flex.2
>>> - VM.Standard.E4.Flex.1
>>>
>>> The larger tested shapes did not show the same regression pattern. The test runs use one sysbench thread per online CPU/core count as encoded in the metric name.
>>>
>>>
>>
>> Interesting, so your guests (no cpuidle) need the tick stopped at every
>> idle entry to not regress, i.e. the below?
>> Is there anything obvious that shows why that would be? Maybe in the
>> hypervisor behaviour?
> 
> Well, this is all unclear to me and it looks like the host is using
> the tick stopping in the guest to drive vCPU scheduling decisions or
> similar.
> 
> I'm guessing (but not sure at all) that arch_cpu_idle() in the x86
> version of the guest is just native_safe_halt() which then traps to
> the host which does something.  And that may depend on whether or not
> the tick has been stopped in the guest.
> 

Maybe some of my intuition, I'd be surprised if the slightly delayed
idle entry (because the vCPU stops the tick) explains the big difference,
so it's likely either:
- Hypervisor changes behaviour of a vCPU depending on when it's next
vtimer is armed (leaving the tick on means sooner of course)
- The tick wakeup itself is cause of the different observed behaviour.

To distinguish the two it would be helpful to know how many of the wakeups
are tick wakeups in the "leave tick enabled" case.
Also just to confirm, the reported metrics are just from a single workload
instance right? So we don't have to consider cases of "Leaving tick on doesn't
allow other system vCPUs to use the CPU as effectively", right? Or is this
possible here?

> I'm not going to apply any changes related to this without a clear
> understanding of what is really going on and there is too little
> information for that ATM.

Agreed.

> [snip]
