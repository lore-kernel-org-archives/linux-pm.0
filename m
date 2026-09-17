Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6C14C10E7;
	Thu, 17 Sep 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658305; cv=none; b=N5ESj1fcuAVp0AfAxpfZzfyiEulPLUp9fg33xE2iaoOGKpvf+1w6g007R6a/t76OEAzStkCLu9me4YA4dPQwzAEUiHX0Z6sqJxiLYmPajY+1qJhVtjOE9DxuEDOVvHnl/n79OWz9snAGEJ2zHFVTPag6F5lqUTiqpIPPJ2n5b4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658305; c=relaxed/simple;
	bh=c/AXftsjss0w3yM4Zoj6PPd6JQEbidt0kM4DrRd7sYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTb/n15umR3BqK9bNNONAS7mpXj27PA+NbfP2H4GB0Kqn9efinM4HeROsaOiIjTm7FkXdPwmFbndFMrCgDlo+ncG/T8idXLt0i2rtTyOsX/Hp3f4NW6buj3qdTze/rkchiN4syRiYJyS2E34LTXoIN07Bja3T0zC9O/gaLdpahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gMw7K2Ln; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gMw7K2Ln"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C7371476;
	Thu, 17 Sep 2026 08:18:07 -0700 (PDT)
Received: from [10.57.50.144] (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 159663F7B4;
	Thu, 17 Sep 2026 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789658290; bh=c/AXftsjss0w3yM4Zoj6PPd6JQEbidt0kM4DrRd7sYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gMw7K2LnYKoavTPB1GdM8GXs0BMxoaDKhCKTabpRqd6kATKABAs3c3Zg7K3dRAE1W
	 GUqnUWwtBzKuEwGJDGlYGJRn83g7FXlY4x6A2aoCKixUAMqzn1SlX1lq3gv0C1fjJh
	 RZ3xTMDTqX8XBSmkwf+OUiPD/SqqdHc6upY5gN+c=
Message-ID: <cd1a09fb-17e0-4d3b-9720-cdc28e90c030@arm.com>
Date: Thu, 17 Sep 2026 16:17:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path
 candidates
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Shubhang Kaushik
 <sh@gentwo.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260916100116.701206-1-christian.loehle@arm.com>
 <20260916100116.701206-3-christian.loehle@arm.com>
 <CAKfTPtCAaACP8A=AKGO3PdhZtA9SRM6e3ym+5d=Qfp-VpDa38g@mail.gmail.com>
 <f3912746-90f8-46de-a690-a840afa4a1d1@arm.com>
 <CAKfTPtAexsLhEb3hEnWvhFo3Z0+CsN41WQ8gfW+waLvxJQrb+A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtAexsLhEb3hEnWvhFo3Z0+CsN41WQ8gfW+waLvxJQrb+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 16:08, Vincent Guittot wrote:
> On Thu, 17 Sept 2026 at 16:22, Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 9/17/26 15:08, Vincent Guittot wrote:
>>> On Wed, 16 Sept 2026 at 12:01, Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
>>>> slow-path selectors can choose the same CPU before either task is enqueued.
>>>>
>>>> Use reservoir sampling in the tie branch, resetting the candidate count
>>>> when a lower advertised exit latency is found. Use the per-CPU scheduler
>>>> PRNG and reciprocal_scale() to avoid variable division or a second scan.
>>>>
>>>> This reduces deterministic convergence without reserving the chosen CPU.
>>>>
>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>> ---
>>>>  kernel/sched/fair.c | 11 ++++++++---
>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index ff5793bddc35..6836a8364440 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -24,6 +24,7 @@
>>>>  #include <linux/mmap_lock.h>
>>>>  #include <linux/hugetlb_inline.h>
>>>>  #include <linux/jiffies.h>
>>>> +#include <linux/math.h>
>>>>  #include <linux/mm_api.h>
>>>>  #include <linux/highmem.h>
>>>>  #include <linux/hrtimer.h>
>>>> @@ -8459,6 +8460,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>>>>  {
>>>>         unsigned long load, min_load = ULONG_MAX;
>>>>         unsigned int min_exit_latency = UINT_MAX;
>>>> +       unsigned int nr_candidates = 0;
>>>>         int least_loaded_cpu = this_cpu;
>>>>         int shallowest_idle_cpu = -1;
>>>>         int i;
>>>> @@ -8482,9 +8484,12 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>>>>                         if (idle && idle->exit_latency < min_exit_latency) {
>>>>                                 min_exit_latency = idle->exit_latency;
>>>>                                 shallowest_idle_cpu = i;
>>>> +                               nr_candidates = 1;
>>>
>>> You clear the number of candidate when you find a lower exit_latency
>>> but !idle CPUs that have already been checked will be cleared whereas
>>> they still get a chance if they are checked later.
>> That is correct. Is this a problem?
> 
> I would say we should try to be consistent

Ack

> 
>> (Again, mirroring what upstream currently does, let's say exit_latency(CPU0)=100, exit_latency(CPU2)=1
>> !idle at CPU3 trumps CPU2 (assuming recent idle_stamp), !idle at CPU1 doesn't trump CPU2, i.e.
>> the inconsistency around !idle is already there?)
> 
> Fair enough but the idle_stamp was also in the party
> 
>> And I'm assuming we really don't wanna keep a cpumask of !idle CPUs, if anything we may just ignore
>> them completely, given how unlikely it they are to be observed.
> 
> We must keep them when there is no cpuidle driver, i.e. until we find
> a CPU with an idle state

Alright let me make a it a U64_MAX reservoir.
Thanks for reviewing Vincent!
