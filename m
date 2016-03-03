From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/6] cpufreq: Reduce cpufreq_update_util() overhead a bit
Date: Thu, 3 Mar 2016 14:04:24 +0100
Message-ID: <20160303130424.GP6356@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <3575770.L1lplNLqVv@vostro.rjw.lan>
 <20160303114701.GT18792@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37887 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcCCNE2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 08:04:28 -0500
Content-Disposition: inline
In-Reply-To: <20160303114701.GT18792@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On Thu, Mar 03, 2016 at 11:47:01AM +0000, Juri Lelli wrote:

> > +#ifdef CONFIG_LOCKDEP
> > +	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
> > +#endif
> >  
> >  	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
> 
> I think you need to s/rcu_dereference/rcu_dereference_sched/ here or
> RCU will complain:

Ah, indeed ;-)
