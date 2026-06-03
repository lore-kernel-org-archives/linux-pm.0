Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DC4A2E0A;
	Wed,  3 Jun 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527073; cv=none; b=XZW2Q7yvUOg3puSqaShJZDnG4yFNlP6Clhl3veMJyBdWRnPgLaSZGbeSq0Z16xXbrfsro3fFXjbwuxDctwaDXUKPA/bII+7ogfqsQMX0Z18U126GOKWoiITeit5jq9wewFl8A381A56h44X4aIEU3K6o4RqjYWbueXHMIegiyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527073; c=relaxed/simple;
	bh=VL+JJI7PsUvrSmc1ocjOQCbJ91s/aMQXvKGieeMh9X0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cvoc/0x7VeTpS3kt4+pyU455Dxwk7z2RUnkit2EkYH0B0hzyzH0t5CAVAgn2mGZhkN+LdY93/MlXNPXHSQq8QtZjqMUpPJieETGIR5kk3pzM1SuJcSRwgch6YcuhIo1P+eg5qf1euEJdAYnxMZIK5M0bnaRqjcobZd/o+XGmXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WahN0xG0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WahN0xG0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028544837;
	Wed,  3 Jun 2026 15:50:58 -0700 (PDT)
Received: from [10.57.72.117] (unknown [10.57.72.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB303F632;
	Wed,  3 Jun 2026 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780527062; bh=VL+JJI7PsUvrSmc1ocjOQCbJ91s/aMQXvKGieeMh9X0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=WahN0xG0qiJ0LH3fb0Jsl6b2ZISP2ZvLBmNgWwMtt4RekTKDLy0b4geyadYmW42wB
	 h3q1Z+6il78Tn4ghECvzuE6jgIYa2ERy+1fpGO8YJbpyq6RfknNJ5eQoR9C/rz/FD3
	 CumTBDVNl5aG2YsJwJZbiex9EEXQPoMefrnWe+C4=
Message-ID: <3b79338f-6cfc-4722-8062-9103db2c8ad1@arm.com>
Date: Wed, 3 Jun 2026 23:50:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 0/6] timers/migration: Handle heterogenous CPU capacities
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Sehee Jeong <sehee1.jeong@samsung.com>, Qais Yousef <qyousef@layalina.io>,
 John Stultz <jstultz@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, linux-pm <linux-pm@vger.kernel.org>
References: <20260423165354.95152-1-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20260423165354.95152-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/26 17:53, Frederic Weisbecker wrote:
> Hi,
> 
> This is a late follow-up after:
> 
> 	https://lore.kernel.org/lkml/20250910074251.8148-1-sehee1.jeong@samsung.com/
> 
> To summarize, heterogenous capacity CPUs migrate their timers
> indifferently between big and little CPUs. And this happens to be often
> migrated to big CPUs, increasing their idle target residency.
> 
> Thomas proposed to isolate the hierarchy between big and little CPUs.
> So here is a try. Note I haven't tested on real heterogenous hardware
> so if you have it, please test it!
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	timers/core
> 
> HEAD: f0a87af6dab6f3a6dd8a603a2b9d7dcc86fd50e4
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (6):
>       timers/migration: Fix another hotplug activation race
>       timers/migration: Abstract out hierarchy to prepare for CPU capacity awareness
>       timers/migration: Track CPUs in a hierarchy
>       timers/migration: Split per-capacity hierarchies
>       timers/migration: Handle capacity in connect tracepoints
>       scripts/timers: Add timer_migration_tree.py
> 
>  include/trace/events/timer_migration.h |  24 ++--
>  kernel/time/timer_migration.c          | 246 ++++++++++++++++++++++++---------
>  kernel/time/timer_migration.h          |  19 +++
>  scripts/timer_migration_tree.py        | 122 ++++++++++++++++
>  4 files changed, 337 insertions(+), 74 deletions(-)

Hi Frederic,
sorry for the late reaction to this, I completely missed it (CCing
linux-pm would have helped :) ).

I'm not convinced that unconditionally splitting the timer migration
hierarchy per-capacity is always the right tradeoff from a power point of
view. On some asymmetric systems we only have one or two CPUs in a given
capacity class. In that case the split can effectively remove most of the
useful timer migration opportunity for that class, even though allowing
migration across nearby capacities may still be better for idle residency.

I tested this on an Orion O6 system with the following topology:

online CPUs: 0-11

capacity 279:  CPUs 2,3,4,5
capacity 866:  CPUs 8,9
capacity 905:  CPUs 6,7
capacity 984:  CPUs 10,11
capacity 1024: CPUs 0,1

I compared the series up to and including the preparatory/refactoring
patch 3 against the full series including the per-capacity hierarchy split.
The numbers below are aggregate cpuidle residency deltas over a 600s run.

Idle workload:

variant    LPI-0     LPI-1     LPI-2     LPI-1+2
base       2298.7s   1253.8s   2817.0s   4070.8s
full       2298.8s   1306.1s   2758.7s   4064.7s
delta      +0.1s     +52.3s    -58.3s    -6.1s

Grouped by capacity class, the LPI-2 loss is mostly on the lower-capacity
CPUs:

group        base LPI-2   full LPI-2   delta full
279          1073.5s      1031.9s      -41.6s
866          502.5s       486.4s       -16.1s
905          499.7s       490.4s       -9.3s
984          488.8s       496.0s       +7.2s
1024         252.5s       254.0s       +1.5s

For a light tbench run (tbench -R 20 -t 600 4), the result is more mixed:

variant    LPI-0     LPI-1     LPI-2     LPI-1+2
base       2593.5s   1483.4s   410.3s    1893.6s
full       2605.3s   1446.5s   416.6s    1863.1s
delta      +11.8s    -36.9s    +6.3s     -30.5s

So tbench gets a small increase in deepest idle, but loses more in
LPI-1+2 overall.

If we do wanna keep the per-capacity hierarchy split, maybe it's sufficient to
gate this behind there being either a small number of capacity classes or
ensuring that they all have >=4 CPUs before splitting?

Kind regards,
Christian

