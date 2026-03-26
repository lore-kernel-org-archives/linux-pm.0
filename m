Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1AA3A3825;
	Thu, 26 Mar 2026 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513241; cv=none; b=XsSOVTjn3jbWcaKlB9PsjcbjCQDStyELVzih/i0jysRRwfOg8j9Vad1P75cKuKfC6CCr3PNz3puoXhl1lOgLvSzMArfckGvF+shdF/3lUMWtiRDwF8joJuTlIcJgsn/IgzngDn6uqf+fa3r0Qf/QBaDe1GXJMIsSZvqUjhx+3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513241; c=relaxed/simple;
	bh=W7gpNks9tv82qBK5S82alBm/96JDedyEI/JtHMPND5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uR9sNkvjqRKjgw1dLsS1VJOZoJh4zdzTdGM1lWcoyfSyoJ8gzLkzq/Esn0wmtURPSxbXL7+ZjyQwwcMJx9yFFHdyNeCyrBe+Mtsl02vr+xMewwm8U7HGPqjxxnywOQIcvMT879aB3FH0Oq42Lr2CQmq6T3dhVbNfqfv6oKcG1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LflUxfjj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LflUxfjj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 328131CDD;
	Thu, 26 Mar 2026 01:20:33 -0700 (PDT)
Received: from [10.57.83.185] (unknown [10.57.83.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D41B43FB90;
	Thu, 26 Mar 2026 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774513239; bh=W7gpNks9tv82qBK5S82alBm/96JDedyEI/JtHMPND5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LflUxfjjJHnyqEXmnNbYciagDxFRjY5xsmmaUtHm+dCPBFpVUsWDLLnr26f6KchJ9
	 WiaMOmrNbpD89wL36CJhF1RWENeaIUzpJOfRfz9k82nIA6BkhyHfF3PBl52NfwCx4E
	 f4PpAG4Qc1OP2v7s7M5StaT8IURPjzsX5/ZqXunk=
Message-ID: <71a93bba-b73d-44c1-910c-081205827362@arm.com>
Date: Thu, 26 Mar 2026 08:20:35 +0000
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 07:53, Vincent Guittot wrote:
> On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
>>
>> The scheduler currently handles CPU performance asymmetry via either:
>>
>> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
>> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
>>
>> On arm64, capacity-aware scheduling is used for any detected capacity
>> differences.
>>
>> Some systems expose small per-CPU performance differences via CPPC
>> highest_perf (e.g. due to chip binning), resulting in slightly different
>> capacities (<~5%). These differences are sufficient to trigger
>> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
>> symmetric.
>>
>> For such small deltas, capacity-aware scheduling is unnecessarily
>> complex. A simpler priority-based approach, similar to x86 ITMT, is
>> sufficient.
> 
> I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
> move forward.
> 
> 1st of all, do you target all kind of system or only SMT? It's not
> clear in your cover letter
> 
> Moving on asym pack for !SMT doesn't make sense to me. If you don't
> want EAS enabled, you can disable it with
> /proc/sys/kernel/sched_energy_aware
> 
> For SMT system and small capacity difference, I would prefer that we
> look at supporting SMT in SD_ASYM_CPUCAPACITY. Starting with
> select_idle_capacity

Quoting the cover letter below, I don't think SMT + SD_ASYM_CPUCAPACITY
can ever be theoretically sound and the results will become so wildly
different on a per-platform / uArch + workload basis, I'm not convinced
something useful would come out of it, but I'd be keen to see some
experiments on this.
IME a busy sibling steals so much more capacity than the difference I care
about here (<5%, busy SMT sibling is often 20-30%, sometimes up to 50% but
entirely dependent on workload and uarch as I've mentioned).
In any case, this series isn't (primarily) for SMT systems...

> [snip]
>> On platforms with SMT though asympacking makes a lot more sense than
>> capacity-aware scheduling, because arguing about capacity without
>> considering utilization of the sibling(s) (and the resulting potential
>> 'stolen' capacity we perceive) isn't theoretically sound.
>>
>> Christian Loehle (3):
>>   sched/topology: Introduce arch hooks for asympacking
>>   arch_topology: Export CPPC-based asympacking prios
>>   arm64/sched: Enable CPPC-based asympacking
>>
>>  arch/arm64/include/asm/topology.h |  6 +++++
>>  arch/arm64/kernel/topology.c      | 34 ++++++++++++++++++++++++++
>>  drivers/base/arch_topology.c      | 40 +++++++++++++++++++++++++++++++
>>  include/linux/arch_topology.h     | 24 +++++++++++++++++++
>>  include/linux/sched/topology.h    |  9 +++++++
>>  kernel/sched/fair.c               | 16 -------------
>>  kernel/sched/topology.c           | 34 ++++++++++++++++++++------
>>  7 files changed, 140 insertions(+), 23 deletions(-)
>>
>> --
>> 2.34.1
>>

