From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Tue, 11 Jul 2017 18:02:12 +0100
Message-ID: <20170711170212.htpx5zz7kaiqc5pf@e106622-lin>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-4-juri.lelli@arm.com>
 <20170711161816.pqlrkziya6gu5hms@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755585AbdGKRCS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 13:02:18 -0400
Content-Disposition: inline
In-Reply-To: <20170711161816.pqlrkziya6gu5hms@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 11/07/17 18:18, Peter Zijlstra wrote:
> On Wed, Jul 05, 2017 at 09:59:00AM +0100, Juri Lelli wrote:
> > @@ -4065,6 +4067,9 @@ static int __sched_setscheduler(struct task_struct *p,
> >  	}
> >  
> >  	if (user) {
> > +		if (attr->sched_flags & SCHED_FLAG_SPECIAL)
> > +			return -EPERM;
> 
> Should be -EINVAL I think, as if the bit didn't exist at all (it
> doesn't, from a userspace perspective).
> 

Makes sense. I'll change it.

Thanks,

- Juri
