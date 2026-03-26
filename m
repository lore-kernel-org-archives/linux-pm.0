Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60D2F6922;
	Thu, 26 Mar 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517051; cv=none; b=keP3/lk6qiMGLyasv5VzzrnaKrCs8v2v6aRPB1+3SVNI0uIVemIF39GsUaA+gi4gpSOCfvRr8Mcc8OJK8P9/R6S0EStUHwdb1tiM7u9M2feUpFUox2JZjJ123jdCknxb8W5Uy4DHvb3zCP6aB39LwJ0V4VXTlSnNQTwywtaGALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517051; c=relaxed/simple;
	bh=1k/f6P6g6/rTaH7YRnpmFbR/xe5ixPQdd2Bf2f8rbqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD9GYp2hIaP1iin/gYOmW5f4ETMi/3wmxP4wONiujJphjypvn77lmcS6YvFUI3avmWKEUrRPRUN97Tuk8cufeHIi8CrDhbXd4r8A+wxVxKcVA26O/rVdoq9AeSiSNl6j5CNXyvgbtgmw/zGWUfk4IBwC8P7pzTD+g1tydLGeKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eQCjYsNu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eQCjYsNu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B2116F3;
	Thu, 26 Mar 2026 02:24:03 -0700 (PDT)
Received: from [10.1.33.38] (unknown [10.1.33.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22EFF3F915;
	Thu, 26 Mar 2026 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774517048; bh=1k/f6P6g6/rTaH7YRnpmFbR/xe5ixPQdd2Bf2f8rbqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eQCjYsNu5LkhnGC7d6GjRpbYwfzlhgLUqTXqAq3knEeiV6whdpQKcgnNc4FSPzU6t
	 ppJBgZfUUWG9EmN4tM3P9VcWWcC+FPi+cctfgb0AnV+N85qjH6U7RCl+2OWiVseaqH
	 dyCWoCO7WhExjjom7u8LB7nSghIMdSJnfysC6xOI=
Message-ID: <7eccf54f-5a99-40ce-8fbc-b755b4e2d312@arm.com>
Date: Thu, 26 Mar 2026 09:24:03 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC
 asymmetry
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: arighi@nvidia.com, peterz@infradead.org, dietmar.eggemann@arm.com,
 valentin.schneider@arm.com, mingo@redhat.com, rostedt@goodmis.org,
 segall@google.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 juri.lelli@redhat.com, kobak@nvidia.com, fabecassis@nvidia.com
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
 <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com>
 <CAKfTPtA+rcVCLe5XOKwu+0bsc8_ZXc1TH4qrYo4x5tNwz9ZO5Q@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtA+rcVCLe5XOKwu+0bsc8_ZXc1TH4qrYo4x5tNwz9ZO5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 08:24, Vincent Guittot wrote:
> On Thu, 26 Mar 2026 at 09:16, Christian Loehle <christian.loehle@arm.com> wrote:
>>
>> On 3/26/26 07:53, Vincent Guittot wrote:
>>> On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>
>>>> The scheduler currently handles CPU performance asymmetry via either:
>>>>
>>>> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
>>>> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
>>>>
>>>> On arm64, capacity-aware scheduling is used for any detected capacity
>>>> differences.
>>>>
>>>> Some systems expose small per-CPU performance differences via CPPC
>>>> highest_perf (e.g. due to chip binning), resulting in slightly different
>>>> capacities (<~5%). These differences are sufficient to trigger
>>>> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
>>>> symmetric.
>>>>
>>>> For such small deltas, capacity-aware scheduling is unnecessarily
>>>> complex. A simpler priority-based approach, similar to x86 ITMT, is
>>>> sufficient.
>>>
>>> I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
>>> move forward.
>>> t
>>> 1st of all, do you target all kind of system or only SMT? It's not
>>> clear in your cover letter
>>
>> AFAIK only Andrea has access to an unreleased asymmetric SMT system,
>> I haven't done any tests on such a system (as the cover-letter mentions
>> under RFT section).
>>
>>>
>>> Moving on asym pack for !SMT doesn't make sense to me. If you don't
>>> want EAS enabled, you can disable it with
>>> /proc/sys/kernel/sched_energy_aware
>>
>> Sorry, what's EAS got to do with it? The system I care about here
>> (primarily nvidia grace) has no EM.
> 
> I tried to understand the end goal of this patch
> 
> SD_ASYM_CPUCAPACITY works fine with !SMT system so why enabling
> SD_ASYM_PACKING for <5% diff ?
> 
> That doesn't make sense to me
I don't know if "works fine" describes the situation accurately.
I guess I should've included the context in the cover letter, but you
are aware of them (you've replied to them anyway):
https://lore.kernel.org/lkml/20260324005509.1134981-1-arighi@nvidia.com/
https://lore.kernel.org/lkml/20260318092214.130908-1-arighi@nvidia.com/

Andrea sees an improvement even when force-equalizing CPUs to remove
SD_ASYM_CPUCAPACITY, so I'd argue it doesn't "work fine" on these platforms.
To me it seems more reasonable to attempt to get these minor improvements
of minor asymmetries through asympacking and leave SD_ASYM_CPUCAPACITY
to the actual 'true' asymmetry (e.g. different uArch or vastly different
performance levels).
SD_ASYM_CPUCAPACITY handling is also arguably broken if no CPU pair in
the system fulfills capacity_greater(), the call sites in fair.c give
a good overview.
Is $subject the right approach to deal with these platforms instead?
I don't know, that's why it's marked RFC and RFT.
