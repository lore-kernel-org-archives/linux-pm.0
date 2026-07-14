Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99FC3624B2
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041232; cv=none; b=HoIpKy1O38dFeHJOJ4CgK1QJFd0u9TScFnHLHpVrGvQTiy40WBsYRAs9Igr8vew7zkfgVnp9/jBD3gPm6cyj6H1n3e/BjgJ/fPEfyscyzBIOta/QFQyWYzwfKZURmJQcozkAPXZ7Cs75pdKIAv9XvAnhckWSfnM67k7TyZ3RJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041232; c=relaxed/simple;
	bh=KNymooo6pFrrV0pgopf1uLkUWo/vHxSbBQiLUMNGAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3pNkstFl20y+pAJOSUWqK2wQNl1PilD2uk5uAbjt9RMz1waaHgDlil9tz0CRaujUi6IjtXwL5Mof+s73wo939RnNTY+VNemF2jQe6ObGJGzLlEshwldM0ITtb6xQOljyt2uIM/gsIeu5NPwivQ7FlVMmRazpNIzqIahocRr7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=MgJl7rGm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="MgJl7rGm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f75f7172so29254335e9.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1784041227; x=1784646027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0sxwsAivRsb15uev9oE08Qk5pOQz/BnCnhJs5fBb2Mg=;
        b=MgJl7rGmv9TRNckg2Yc/XF3XeGgj6s74z2rrv+kaPZFmFg4Vt0VJeyhQ6cYLwdw3P7
         wwlkfK2I+rlhH8/5a/7U5bak+U0FK5/MzZTGMokB3iWKD+ITFHoYHXTV9XuS0gH4Nv87
         +C95G/JuFA7gbW+AGvVn5A0RrrVDW/hf7280/R3AhTw/wd4RFCa4zXkkmvXnKItbQOhf
         HR7rhWaqeUNIlkOtzmW0gHp/rYb6St+y7sx0fOmM467XfxKFEiyZmzj+DRRb7Z6S8+nQ
         3/2Z/aXWLuLfa0C9CKMxF21Yf6XSrnLyNCwXDlxRuJyFjGAFQ6tSL9ug7rZnhJ9R2aSg
         blfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784041227; x=1784646027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0sxwsAivRsb15uev9oE08Qk5pOQz/BnCnhJs5fBb2Mg=;
        b=Ms5DD4Ep2KvvzPm9a1bYMs+BUgnlM7k0wSWYkm1r8bGaM0Qe4VMXzzvf2O5wT3CYZQ
         tjXcchUbqTJ/jnLXqbY9d2c2mRUwK83Vls+2qedvZ09DVcy3ajh2VqWoj6KmhMv25zJF
         oGiRoIUL0cU21HA6Z9nXwm7jnwU9VwKXomFJ5PK4dFtfZRpRK3izzUpBBGHjlxBtpzIc
         HsAUgHKT+yNm3MvEFjSxO1S9sK2Jfx55Mw118AYnpM2mQDoUwu4JA7Y67mrBE1Kxzod1
         A1Su/gUEBNScImNjk0GPWRI1hPgpfNasRmo6+GhQV/CvHSO2j3P/Y+BjxjdSB4Z9BebW
         hjUA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6cBwc0ASzZvWwpWzYZfwzjwxPqvUZKbHGagmYiwHAK0mWaja/dgcTRUMeGUfw7h5t6cg8bWUs3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNs1LaT304EhuoEWBhkHkW4JtS2oiqRO6gbSE1j5xgDEjAIInD
	X6R4qO6YLuyGM2HSXAeGqmcWB9CaBVkzoRzHLBkELWICP+ZTkwNWZvByKkOq3j8qIew=
X-Gm-Gg: AfdE7cmnTUdKZnaqvDqBKgzvCkQ5Hr6PNIdj7VWzj325QJoF4IV6JxTg+Hqs0OELt+Y
	lvdi/6ngyyBhE6zhlVp4BkeKdyJykgxPuiVLxl8NVHwJpyZtt+XnIIdT/Lz1hZf+sIO838ktNMF
	SoY+zhaHb+pEjaSpnJPYLNbBN8KKOHHg5+KaqYxGgOqdlSXNJatUbPfNmplC8pBgm/VnKI3G5l7
	7k35QwLEGUTS4VUWPclaMKl3BB0qEEKRH/yTfdvvycPRwZ2dC57vCqSsxQXmgSHt59lGkqZ+86O
	kK5EIii7/khAul6kamyhwet++2bxYoKwzu/Tn8kWxv9vJBRXBt6KT/zYpE4LegFL8iYqgE+VB6X
	UX175KMg4dZgRrPF305EmwpCyON4XlA27T49rZ/Jis8zBTOFK0TiV8KVgP70P79AjBIL2Z0E+oM
	1tqJShRsM=
X-Received: by 2002:a05:600c:348e:b0:493:bd37:1cdf with SMTP id 5b1f17b1804b1-493f87d6219mr139993815e9.2.1784041226851;
        Tue, 14 Jul 2026 08:00:26 -0700 (PDT)
Received: from airbuntu ([149.50.209.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871cbd6sm94284365e9.3.2026.07.14.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:00:26 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:00:22 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Sehee Jeong <sehee1.jeong@samsung.com>,
	John Stultz <jstultz@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-pm <linux-pm@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/6] timers/migration: Handle heterogenous CPU capacities
Message-ID: <20260714150022.lifdys7c7czwmg63@airbuntu>
References: <20260423165354.95152-1-frederic@kernel.org>
 <3b79338f-6cfc-4722-8062-9103db2c8ad1@arm.com>
 <aiF_eqFOXI2xEUoF@localhost.localdomain>
 <7e2e21a3-6ed6-4b98-a5f0-1aef842084ce@arm.com>
 <ail8awnO9NgDgbi3@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ail8awnO9NgDgbi3@localhost.localdomain>

Thanks for the CC Christian.

On 06/10/26 17:02, Frederic Weisbecker wrote:
> Le Fri, Jun 05, 2026 at 11:10:20AM +0100, Christian Loehle a écrit :
> > On 6/4/26 14:36, Frederic Weisbecker wrote:
> > > Le Wed, Jun 03, 2026 at 11:50:58PM +0100, Christian Loehle a écrit :
> > >> On 4/23/26 17:53, Frederic Weisbecker wrote:
> > >>> Hi,
> > >>>
> > >>> This is a late follow-up after:
> > >>>
> > >>> 	https://lore.kernel.org/lkml/20250910074251.8148-1-sehee1.jeong@samsung.com/
> > >>>
> > >>> To summarize, heterogenous capacity CPUs migrate their timers
> > >>> indifferently between big and little CPUs. And this happens to be often
> > >>> migrated to big CPUs, increasing their idle target residency.

This is a real problem in practice. Not only they can migrate to big core, but
also can be stuck on that core.

> > >>>
> > >>> Thomas proposed to isolate the hierarchy between big and little CPUs.
> > >>> So here is a try. Note I haven't tested on real heterogenous hardware
> > >>> so if you have it, please test it!
> > >>>
> > >>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > >>> 	timers/core
> > >>>
> > >>> HEAD: f0a87af6dab6f3a6dd8a603a2b9d7dcc86fd50e4
> > >>> Thanks,
> > >>> 	Frederic
> > >>> ---
> > >>>
> > >>> Frederic Weisbecker (6):
> > >>>       timers/migration: Fix another hotplug activation race
> > >>>       timers/migration: Abstract out hierarchy to prepare for CPU capacity awareness
> > >>>       timers/migration: Track CPUs in a hierarchy
> > >>>       timers/migration: Split per-capacity hierarchies
> > >>>       timers/migration: Handle capacity in connect tracepoints
> > >>>       scripts/timers: Add timer_migration_tree.py
> > >>>
> > >>>  include/trace/events/timer_migration.h |  24 ++--
> > >>>  kernel/time/timer_migration.c          | 246 ++++++++++++++++++++++++---------
> > >>>  kernel/time/timer_migration.h          |  19 +++
> > >>>  scripts/timer_migration_tree.py        | 122 ++++++++++++++++
> > >>>  4 files changed, 337 insertions(+), 74 deletions(-)
> > >>
> > >> Hi Frederic,
> > >> sorry for the late reaction to this, I completely missed it (CCing
> > >> linux-pm would have helped :) ).
> > > 
> > > Good point, next time I'll do!
> > > 
> > >>
> > >> I'm not convinced that unconditionally splitting the timer migration
> > >> hierarchy per-capacity is always the right tradeoff from a power point of
> > >> view. On some asymmetric systems we only have one or two CPUs in a given
> > >> capacity class. In that case the split can effectively remove most of the
> > >> useful timer migration opportunity for that class, even though allowing
> > >> migration across nearby capacities may still be better for idle residency.

The ideal behavior is that timers are handles on little cores, spill to mid if
they get really busy handling timers, and to big if they get busy.

Which is what we do for task placement, we pack until we reach a point we need
to spill - or task get too busy to gets its perf demand satisfied on this core.
But I can't see the latter a factor for timer interrupts.

> > >>
> > >> I tested this on an Orion O6 system with the following topology:
> > >>
> > >> online CPUs: 0-11
> > >>
> > >> capacity 279:  CPUs 2,3,4,5
> > >> capacity 866:  CPUs 8,9
> > >> capacity 905:  CPUs 6,7
> > >> capacity 984:  CPUs 10,11
> > >> capacity 1024: CPUs 0,1
> > >>
> > >> I compared the series up to and including the preparatory/refactoring
> > >> patch 3 against the full series including the per-capacity hierarchy split.
> > >> The numbers below are aggregate cpuidle residency deltas over a 600s run.
> > >>
> > >> Idle workload:
> > >>
> > >> variant    LPI-0     LPI-1     LPI-2     LPI-1+2
> > >> base       2298.7s   1253.8s   2817.0s   4070.8s
> > >> full       2298.8s   1306.1s   2758.7s   4064.7s
> > >> delta      +0.1s     +52.3s    -58.3s    -6.1s

What is LPI?

> > >>
> > >> Grouped by capacity class, the LPI-2 loss is mostly on the lower-capacity
> > >> CPUs:
> > >>
> > >> group        base LPI-2   full LPI-2   delta full
> > >> 279          1073.5s      1031.9s      -41.6s
> > >> 866          502.5s       486.4s       -16.1s
> > >> 905          499.7s       490.4s       -9.3s
> > >> 984          488.8s       496.0s       +7.2s
> > >> 1024         252.5s       254.0s       +1.5s
> > >>
> > >> For a light tbench run (tbench -R 20 -t 600 4), the result is more mixed:
> > >>
> > >> variant    LPI-0     LPI-1     LPI-2     LPI-1+2
> > >> base       2593.5s   1483.4s   410.3s    1893.6s
> > >> full       2605.3s   1446.5s   416.6s    1863.1s
> > >> delta      +11.8s    -36.9s    +6.3s     -30.5s
> > >>
> > >> So tbench gets a small increase in deepest idle, but loses more in
> > >> LPI-1+2 overall.
> > >>
> > >> If we do wanna keep the per-capacity hierarchy split, maybe it's sufficient to
> > >> gate this behind there being either a small number of capacity classes or
> > >> ensuring that they all have >=4 CPUs before splitting?
> > > 
> > > Ok I was afraid of something like that, ie: it works for some usages but not
> > > on others.
> > > 
> > > And I don't know what to do. For example if I apply your suggested contraints,
> > > on which hierarchy should go those capacities with < 4 CPUs ?
> > > 
> > > Thoughts?
> > > 
> > 
> > I sure have some thoughts, but I'm unsure about the best solution is though.
> > A few things bothering me:
> > 1. In the original report the problem was timers being migrated from
> > little to big CPU leads to a power regression, but of course they most
> > likely still benefit from the reverse migration, making static partitioning

Yes moving timers back to little is important. I need to look at timers code
again, but any reason they should always be armed to the core the triggered the
request?

> > seem counterintuitive to me in the first place? In particular because usually
> > #little CPUs > #big CPUs, so my intuition would be that that migration should
> > be more common, or is that not true? I'd also love to know with what workload
> > the original issue appeared.
> > 2. While little->big timer migration might usually be bad for power, that's
> > not always true depending on SoC and workload, we don't really know without
> > consulting the energy model, for most timers though the energy model wouldn't
> > be that useful anyway as a good chunk of the decision comes from wasting
> > potential idle energy instead of active energy, energy model is unaware of
> > power savings of idle states.

I would say that timers on big is bad. I can't foresee in what situation this
can't be true.

> > 
> > For the static hierarchy split itself my ideas would be:
> > 
> > 1. Don't do it if the resulting hierarchy is too awkward, e.g. single CPUs or
> > too many tiny groups. Obviously that risks excluding the system from the
> > original report.
> > 
> > 2. Group only meaningfully different capacities, rather than exact
> > arch_scale_cpu_capacity() values. For example, use something like the
> > capacity_greater() margin so negligible capacity differences don't create
> > separate timer hierarchies. [1]
> > 
> > 3. Have a limited number of buckets, fixed thresholds such as <512
> > and >=512 would probably work, but are arbitrary.
> > 
> > 4. Only start a new bucket if last_capacity != current_capacity &&
> > last_bucket_cpus >= 4. This feels awkward because the resulting hierarchy then
> > depends on CPU/hotplug ordering.
> > 
> > If we allow for a more dynamic migration strategy, I think I'd prefer the
> > decision to be based on observed idle opportunity rather than capacity alone.
> > Something like rq->avg_idle, could make CPUs with shorter recent idle periods
> > more likely to handle timers, while avoiding CPUs that tend to get long/deep
> > idle residencies. Is that unreasonable from your end?
> 
> I guess it's feasible, but that doesn't take into account the capacity itself.
> The initial issue was about timers migrating too often to big cores and
> therefore keeping them alive too frequently. I guess the biggest issue is
> when the last core going idle is a big core. And it's the one that will handle
> all global timers for the whole system.
> 
> And perhaps it's a fundamental issue because big cores are probably busier by
> nature.

In contrary, although that can depend on systems. But even today's mid range
phones they are yesterday's flag ship SoCs and have pretty powerful mid cores.

I am not sure if this makes sense as I need to dig into timers code more, but
I'd say that trying to use CPU0, then spill to CPU1, then CPU2 etc is ideal.
You can give the user the option to pick the order of preference if you want to
handle potential weirdness where CPU0 is more expensive for whatever reason.
But safe to assume lower is cheaper by default IMHO.

I think this would not be useful for AMP systems only, but also on SMP ones by
confining timers to fewer cores.

Another alternative is allow irqbalance to control this somehow - but there's
no standard irqbalance implementation/interface.

FWIW the situation I saw more often is timer stuck on a core because the task
that woke up there armed it and by default it ends up on the same core. I am
not sure under what conditions we migrate timers, but I seem to remember it
wants to try to allow the core to enter idle state and looks for another one
that is active. I think a better logic is to nominate a core or set of cores to
handle timers always - which might be also the right thing to do rather than
come up with smart logic on how to migrate. Let the user 'affine' the handling
to specific cores only which might be the simplest thing to do. I can vouche
most folks will just say never run on these specific cores and current logic
might be good enough as-is then.

IOW, keep the current migration logic, but give the users the ability to
exclude cores from ever handling timers. I think the root cause of the problem
here is that you want to keep some cores really quite and handling any
interrupts, not just timers, is bad. But not sure timers can be controlled as
well like other interrupts and that what might be missing today.

(I haven't spent time to verify few things, so apologies for lack of accuracy
and making assumptions here and there)

> 
> That problem is not easy to solve...
> 
> > 
> > [1] nvidia grace e.g. has capacities of
> > 994
> > 997
> > 1000
> > 1002
> > 1005
> > 1008
> > 1010
> > 1013
> > 1016
> > 1018
> > 1021
> > 1024
> 
> Urgh, who needs that?

They are all the same uArch though no? i think important pre-condition to
distinguish between CPUs is that this is asymmetric system, not symmetric with
weird boost freqs availability.
