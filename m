From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu, 21 Dec 2017 11:25:30 +0100
Message-ID: <20171221102530.all2hqoyh77mffmf@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220154358.663yoodeoxkqghx7@hirez.programming.kicks-ass.net>
 <20171221091502.GE19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdLUKZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Dec 2017 05:25:39 -0500
Content-Disposition: inline
In-Reply-To: <20171221091502.GE19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Thu, Dec 21, 2017 at 02:45:02PM +0530, Viresh Kumar wrote:
> On 20-12-17, 16:43, Peter Zijlstra wrote:
> > The below makes more sense to me too; hmm?
> > 
> > @@ -335,12 +335,11 @@ static unsigned int sugov_next_freq_shar
> >  
> >  		j_max = j_sg_cpu->max;
> >  		j_util = sugov_aggregate_util(j_sg_cpu);
> > +		sugov_iowait_boost(j_sg_cpu, &util, &max);

This should 'obviously' have been:

		sugov_iowait_boost(j_sg_cpu, &j_util, *j_max);

> >  		if (j_util * max > j_max * util) {
> >  			util = j_util;
> >  			max = j_max;
> >  		}
> > -
> > -		sugov_iowait_boost(j_sg_cpu, &util, &max);
