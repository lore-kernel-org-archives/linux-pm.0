Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38944BC92;
	Thu,  4 Jun 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580223; cv=none; b=PsUBxvbuq2SQtzTBLUqihPxG+gthET0iB4bXpDIFxQykGS2BH0avCVEqAafval2bwxrUcGsVNWC4u00onjL7LRx4Fo/09gQByX8g1aCIdSgvsOhznxKcIxPy7whe1emfG91nWaNMZB00OLUzIs0+5iWKVYxVpykrkbDHrIi+oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580223; c=relaxed/simple;
	bh=6zZ1C+HKFWCNqdUSedsKN9vLa/1dmflJd1NHxfG53GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw/nuyx+MeMnpmOs6x/U3BlmwhfjU/VxmBpm1SBc3HzfBzdPN3k1mcU5nz9A0DWQbSJUhXhA6dJin28BNe8tJBRh0UO0HxkxenkET6fz3T80RCGd119DGBgMhPPNWtLMSgcWY1QaTvfWoO9rrGr5dNYn0KitFvPksX//5IFNWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbdfQ7Ah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbdfQ7Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3041F00893;
	Thu,  4 Jun 2026 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580221;
	bh=xhxHYpcP5xU+30sYUujHC7DwMbxmJeYgd4kQm69Fvzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LbdfQ7AhR2KAnWjMbyVDv4niw78Q8n+uY/Ye29QHgADY80Zko4t46rKoaQWS9iNS1
	 o/wrGDSEn7VcB/zyWe8c3/n/lfoWNob5wXinhgBHhjxWjnkubgrSmlW1MThj/yuBcC
	 y+1luRmBYsPvfWCCKsjaOufFgdZwJXLCxu2C3s04bNZepa94qZQlumwe/5+frPnSpQ
	 hgR+gGR0xZr6XcYED74wXHRaWjoEfC9VMzPzl0DsGSpn5WEll4OYHqYg00VZ2mlJjc
	 zRWqT54iPjZP1ULgU7GUt4Qm5Na4jjTZENIRuJ1SmSoZNlD8zxdJX+ex0BIefcmAq6
	 oNP7jnJ2HuJOQ==
Date: Thu, 4 Jun 2026 15:36:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Sehee Jeong <sehee1.jeong@samsung.com>,
	Qais Yousef <qyousef@layalina.io>, John Stultz <jstultz@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/6] timers/migration: Handle heterogenous CPU capacities
Message-ID: <aiF_eqFOXI2xEUoF@localhost.localdomain>
References: <20260423165354.95152-1-frederic@kernel.org>
 <3b79338f-6cfc-4722-8062-9103db2c8ad1@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b79338f-6cfc-4722-8062-9103db2c8ad1@arm.com>

Le Wed, Jun 03, 2026 at 11:50:58PM +0100, Christian Loehle a écrit :
> On 4/23/26 17:53, Frederic Weisbecker wrote:
> > Hi,
> > 
> > This is a late follow-up after:
> > 
> > 	https://lore.kernel.org/lkml/20250910074251.8148-1-sehee1.jeong@samsung.com/
> > 
> > To summarize, heterogenous capacity CPUs migrate their timers
> > indifferently between big and little CPUs. And this happens to be often
> > migrated to big CPUs, increasing their idle target residency.
> > 
> > Thomas proposed to isolate the hierarchy between big and little CPUs.
> > So here is a try. Note I haven't tested on real heterogenous hardware
> > so if you have it, please test it!
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	timers/core
> > 
> > HEAD: f0a87af6dab6f3a6dd8a603a2b9d7dcc86fd50e4
> > Thanks,
> > 	Frederic
> > ---
> > 
> > Frederic Weisbecker (6):
> >       timers/migration: Fix another hotplug activation race
> >       timers/migration: Abstract out hierarchy to prepare for CPU capacity awareness
> >       timers/migration: Track CPUs in a hierarchy
> >       timers/migration: Split per-capacity hierarchies
> >       timers/migration: Handle capacity in connect tracepoints
> >       scripts/timers: Add timer_migration_tree.py
> > 
> >  include/trace/events/timer_migration.h |  24 ++--
> >  kernel/time/timer_migration.c          | 246 ++++++++++++++++++++++++---------
> >  kernel/time/timer_migration.h          |  19 +++
> >  scripts/timer_migration_tree.py        | 122 ++++++++++++++++
> >  4 files changed, 337 insertions(+), 74 deletions(-)
> 
> Hi Frederic,
> sorry for the late reaction to this, I completely missed it (CCing
> linux-pm would have helped :) ).

Good point, next time I'll do!

> 
> I'm not convinced that unconditionally splitting the timer migration
> hierarchy per-capacity is always the right tradeoff from a power point of
> view. On some asymmetric systems we only have one or two CPUs in a given
> capacity class. In that case the split can effectively remove most of the
> useful timer migration opportunity for that class, even though allowing
> migration across nearby capacities may still be better for idle residency.
> 
> I tested this on an Orion O6 system with the following topology:
> 
> online CPUs: 0-11
> 
> capacity 279:  CPUs 2,3,4,5
> capacity 866:  CPUs 8,9
> capacity 905:  CPUs 6,7
> capacity 984:  CPUs 10,11
> capacity 1024: CPUs 0,1
> 
> I compared the series up to and including the preparatory/refactoring
> patch 3 against the full series including the per-capacity hierarchy split.
> The numbers below are aggregate cpuidle residency deltas over a 600s run.
> 
> Idle workload:
> 
> variant    LPI-0     LPI-1     LPI-2     LPI-1+2
> base       2298.7s   1253.8s   2817.0s   4070.8s
> full       2298.8s   1306.1s   2758.7s   4064.7s
> delta      +0.1s     +52.3s    -58.3s    -6.1s
> 
> Grouped by capacity class, the LPI-2 loss is mostly on the lower-capacity
> CPUs:
> 
> group        base LPI-2   full LPI-2   delta full
> 279          1073.5s      1031.9s      -41.6s
> 866          502.5s       486.4s       -16.1s
> 905          499.7s       490.4s       -9.3s
> 984          488.8s       496.0s       +7.2s
> 1024         252.5s       254.0s       +1.5s
> 
> For a light tbench run (tbench -R 20 -t 600 4), the result is more mixed:
> 
> variant    LPI-0     LPI-1     LPI-2     LPI-1+2
> base       2593.5s   1483.4s   410.3s    1893.6s
> full       2605.3s   1446.5s   416.6s    1863.1s
> delta      +11.8s    -36.9s    +6.3s     -30.5s
> 
> So tbench gets a small increase in deepest idle, but loses more in
> LPI-1+2 overall.
> 
> If we do wanna keep the per-capacity hierarchy split, maybe it's sufficient to
> gate this behind there being either a small number of capacity classes or
> ensuring that they all have >=4 CPUs before splitting?

Ok I was afraid of something like that, ie: it works for some usages but not
on others.

And I don't know what to do. For example if I apply your suggested contraints,
on which hierarchy should go those capacities with < 4 CPUs ?

Thoughts?

> 
> Kind regards,
> Christian
> 

-- 
Frederic Weisbecker
SUSE Labs
