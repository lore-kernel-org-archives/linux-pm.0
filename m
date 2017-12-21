From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu, 21 Dec 2017 16:00:22 +0530
Message-ID: <20171221103022.GA8312@vireshk-i7>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220154358.663yoodeoxkqghx7@hirez.programming.kicks-ass.net>
 <20171221091502.GE19815@vireshk-i7>
 <20171221102530.all2hqoyh77mffmf@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171221102530.all2hqoyh77mffmf@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 21-12-17, 11:25, Peter Zijlstra wrote:
> On Thu, Dec 21, 2017 at 02:45:02PM +0530, Viresh Kumar wrote:
> > On 20-12-17, 16:43, Peter Zijlstra wrote:
> > > The below makes more sense to me too; hmm?
> > > 
> > > @@ -335,12 +335,11 @@ static unsigned int sugov_next_freq_shar
> > >  
> > >  		j_max = j_sg_cpu->max;
> > >  		j_util = sugov_aggregate_util(j_sg_cpu);
> > > +		sugov_iowait_boost(j_sg_cpu, &util, &max);
> 
> This should 'obviously' have been:
> 
> 		sugov_iowait_boost(j_sg_cpu, &j_util, *j_max);

Actually it should be:

 		sugov_iowait_boost(j_sg_cpu, &j_util, &j_max);

and this is how it was in the commit I reviewed from your tree. But my query
still stands, what difference will it make ?

> > >  		if (j_util * max > j_max * util) {
> > >  			util = j_util;
> > >  			max = j_max;
> > >  		}
> > > -
> > > -		sugov_iowait_boost(j_sg_cpu, &util, &max);

-- 
viresh
