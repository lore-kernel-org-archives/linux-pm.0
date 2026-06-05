Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234563F58F5;
	Fri,  5 Jun 2026 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654228; cv=none; b=SpPEwti1hvR5afE2VNjp+n+20Ekt3qBZG7d1oa1OjP+t///TvVFzm6ZXS7Hl5TUZXWUPc5qx9++EtkeXNb8KrlWwi8alUat6CuvSctf7+fspLgikxoU8bOof/xNekYRhVdpdvoOpYSYwB4VNM8Z+DCPJEEiXBzH6PTC7zI0KGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654228; c=relaxed/simple;
	bh=d6ANYO/kQNBEpn4JwS0jiU2OliEb8Akv1slGCPTxbmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPshBYLMjVDaQDM25qySVlIPX8zrbRpc+9A5V7MyDKl4YtY6haVemerSsRJckOL0tDN/veaSJYVWt1zVrYcWaOYof90GuMgBwh4+ZgL7MLXByWUVvQsC/al4J6BKXJV3MnZx7YbTUPHp8GegccSifeXlmNIZR2ELagF9C5Wi95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R9i9znKo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R9i9znKo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D4334ACE;
	Fri,  5 Jun 2026 03:10:20 -0700 (PDT)
Received: from [10.1.38.38] (e127648.arm.com [10.1.38.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C15783F632;
	Fri,  5 Jun 2026 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780654225; bh=d6ANYO/kQNBEpn4JwS0jiU2OliEb8Akv1slGCPTxbmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R9i9znKojj+GxDejIHO6kAtKeUBv2E5VUBrpMgySvaYWDJobM7IMrfBARbAl4XQwQ
	 oW5MQpCHk/6DTktS8ifwHiDj+ISJvVSXXwqhUkag8ifv8brGc94+3Q75IBtmpc25dv
	 w163Gx9MS2E3oxq53cCnVx2M7zAy9K2ts6zSq0BI=
Message-ID: <7e2e21a3-6ed6-4b98-a5f0-1aef842084ce@arm.com>
Date: Fri, 5 Jun 2026 11:10:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] timers/migration: Handle heterogenous CPU capacities
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Sehee Jeong <sehee1.jeong@samsung.com>, Qais Yousef <qyousef@layalina.io>,
 John Stultz <jstultz@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, linux-pm <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20260423165354.95152-1-frederic@kernel.org>
 <3b79338f-6cfc-4722-8062-9103db2c8ad1@arm.com>
 <aiF_eqFOXI2xEUoF@localhost.localdomain>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aiF_eqFOXI2xEUoF@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/26 14:36, Frederic Weisbecker wrote:
> Le Wed, Jun 03, 2026 at 11:50:58PM +0100, Christian Loehle a écrit :
>> On 4/23/26 17:53, Frederic Weisbecker wrote:
>>> Hi,
>>>
>>> This is a late follow-up after:
>>>
>>> 	https://lore.kernel.org/lkml/20250910074251.8148-1-sehee1.jeong@samsung.com/
>>>
>>> To summarize, heterogenous capacity CPUs migrate their timers
>>> indifferently between big and little CPUs. And this happens to be often
>>> migrated to big CPUs, increasing their idle target residency.
>>>
>>> Thomas proposed to isolate the hierarchy between big and little CPUs.
>>> So here is a try. Note I haven't tested on real heterogenous hardware
>>> so if you have it, please test it!
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>>> 	timers/core
>>>
>>> HEAD: f0a87af6dab6f3a6dd8a603a2b9d7dcc86fd50e4
>>> Thanks,
>>> 	Frederic
>>> ---
>>>
>>> Frederic Weisbecker (6):
>>>       timers/migration: Fix another hotplug activation race
>>>       timers/migration: Abstract out hierarchy to prepare for CPU capacity awareness
>>>       timers/migration: Track CPUs in a hierarchy
>>>       timers/migration: Split per-capacity hierarchies
>>>       timers/migration: Handle capacity in connect tracepoints
>>>       scripts/timers: Add timer_migration_tree.py
>>>
>>>  include/trace/events/timer_migration.h |  24 ++--
>>>  kernel/time/timer_migration.c          | 246 ++++++++++++++++++++++++---------
>>>  kernel/time/timer_migration.h          |  19 +++
>>>  scripts/timer_migration_tree.py        | 122 ++++++++++++++++
>>>  4 files changed, 337 insertions(+), 74 deletions(-)
>>
>> Hi Frederic,
>> sorry for the late reaction to this, I completely missed it (CCing
>> linux-pm would have helped :) ).
> 
> Good point, next time I'll do!
> 
>>
>> I'm not convinced that unconditionally splitting the timer migration
>> hierarchy per-capacity is always the right tradeoff from a power point of
>> view. On some asymmetric systems we only have one or two CPUs in a given
>> capacity class. In that case the split can effectively remove most of the
>> useful timer migration opportunity for that class, even though allowing
>> migration across nearby capacities may still be better for idle residency.
>>
>> I tested this on an Orion O6 system with the following topology:
>>
>> online CPUs: 0-11
>>
>> capacity 279:  CPUs 2,3,4,5
>> capacity 866:  CPUs 8,9
>> capacity 905:  CPUs 6,7
>> capacity 984:  CPUs 10,11
>> capacity 1024: CPUs 0,1
>>
>> I compared the series up to and including the preparatory/refactoring
>> patch 3 against the full series including the per-capacity hierarchy split.
>> The numbers below are aggregate cpuidle residency deltas over a 600s run.
>>
>> Idle workload:
>>
>> variant    LPI-0     LPI-1     LPI-2     LPI-1+2
>> base       2298.7s   1253.8s   2817.0s   4070.8s
>> full       2298.8s   1306.1s   2758.7s   4064.7s
>> delta      +0.1s     +52.3s    -58.3s    -6.1s
>>
>> Grouped by capacity class, the LPI-2 loss is mostly on the lower-capacity
>> CPUs:
>>
>> group        base LPI-2   full LPI-2   delta full
>> 279          1073.5s      1031.9s      -41.6s
>> 866          502.5s       486.4s       -16.1s
>> 905          499.7s       490.4s       -9.3s
>> 984          488.8s       496.0s       +7.2s
>> 1024         252.5s       254.0s       +1.5s
>>
>> For a light tbench run (tbench -R 20 -t 600 4), the result is more mixed:
>>
>> variant    LPI-0     LPI-1     LPI-2     LPI-1+2
>> base       2593.5s   1483.4s   410.3s    1893.6s
>> full       2605.3s   1446.5s   416.6s    1863.1s
>> delta      +11.8s    -36.9s    +6.3s     -30.5s
>>
>> So tbench gets a small increase in deepest idle, but loses more in
>> LPI-1+2 overall.
>>
>> If we do wanna keep the per-capacity hierarchy split, maybe it's sufficient to
>> gate this behind there being either a small number of capacity classes or
>> ensuring that they all have >=4 CPUs before splitting?
> 
> Ok I was afraid of something like that, ie: it works for some usages but not
> on others.
> 
> And I don't know what to do. For example if I apply your suggested contraints,
> on which hierarchy should go those capacities with < 4 CPUs ?
> 
> Thoughts?
> 

I sure have some thoughts, but I'm unsure about the best solution is though.
A few things bothering me:
1. In the original report the problem was timers being migrated from
little to big CPU leads to a power regression, but of course they most
likely still benefit from the reverse migration, making static partitioning
seem counterintuitive to me in the first place? In particular because usually
#little CPUs > #big CPUs, so my intuition would be that that migration should
be more common, or is that not true? I'd also love to know with what workload
the original issue appeared.
2. While little->big timer migration might usually be bad for power, that's
not always true depending on SoC and workload, we don't really know without
consulting the energy model, for most timers though the energy model wouldn't
be that useful anyway as a good chunk of the decision comes from wasting
potential idle energy instead of active energy, energy model is unaware of
power savings of idle states.

For the static hierarchy split itself my ideas would be:

1. Don't do it if the resulting hierarchy is too awkward, e.g. single CPUs or
too many tiny groups. Obviously that risks excluding the system from the
original report.

2. Group only meaningfully different capacities, rather than exact
arch_scale_cpu_capacity() values. For example, use something like the
capacity_greater() margin so negligible capacity differences don't create
separate timer hierarchies. [1]

3. Have a limited number of buckets, fixed thresholds such as <512
and >=512 would probably work, but are arbitrary.

4. Only start a new bucket if last_capacity != current_capacity &&
last_bucket_cpus >= 4. This feels awkward because the resulting hierarchy then
depends on CPU/hotplug ordering.

If we allow for a more dynamic migration strategy, I think I'd prefer the
decision to be based on observed idle opportunity rather than capacity alone.
Something like rq->avg_idle, could make CPUs with shorter recent idle periods
more likely to handle timers, while avoiding CPUs that tend to get long/deep
idle residencies. Is that unreasonable from your end?

[1] nvidia grace e.g. has capacities of
994
997
1000
1002
1005
1008
1010
1013
1016
1018
1021
1024

This feels like it should all be one hierarchy bucket. On my Orion O6,
using the capacity_greater() margin would at least reduce the split to:

279 (4 CPUs)
866 + 905 (4 CPUs)
984 + 1024 (4 CPUs)

Nonetheless many SoCs are 4+2+1 or 4+3+1, so even that does not fully solve
the tiny hierarchy problem.
