From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Wed, 20 Dec 2017 19:16:08 +0100
Message-ID: <20171220181608.ztar2d5vrthclhc5@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171220173814.GC22246@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 20, 2017 at 06:38:14PM +0100, Juri Lelli wrote:
> On 20/12/17 16:30, Peter Zijlstra wrote:
> 
> [...]
> 
> > @@ -327,12 +331,7 @@ static unsigned int sugov_next_freq_shar
> >  		if (delta_ns > TICK_NSEC) {
> >  			j_sg_cpu->iowait_boost = 0;
> >  			j_sg_cpu->iowait_boost_pending = false;
> > -			j_sg_cpu->util_cfs = 0;
> > -			if (j_sg_cpu->util_dl == 0)
> > -				continue;
> >  		}
> 
> This goes away because with Brendan/Vincent fix we don't need the
> workaround for stale CFS util contribution for idle CPUs anymore?

Oh, good point, no I took that out because of:

@@ -314,6 +315,9 @@ static unsigned int sugov_next_freq_shar

                unsigned long j_util, j_max;
                s64 delta_ns;

+               if (j_sg_cpu != sg_cpu)
+                       sugov_get_util(j_sg_cpu);
+
                /*
                 * If the CFS CPU utilization was last updated before the
                 * previous frequency update and the time elapsed between the


which recomputes the util value all the time. But yes, that still needs
those other patches to stay relevant.
