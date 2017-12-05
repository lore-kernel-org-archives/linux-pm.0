From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v2 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Tue, 5 Dec 2017 16:26:49 +0100
Message-ID: <20171205152649.GD15085@localhost.localdomain>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
 <20171204102325.5110-5-juri.lelli@redhat.com>
 <20171205151734.GM31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171205151734.GM31247@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, alessio.balsini@arm.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 05/12/17 15:17, Patrick Bellasi wrote:
> Hi Juri,
> 
> On 04-Dec 11:23, Juri Lelli wrote:
> > From: Juri Lelli <juri.lelli@arm.com>
> > 
> > To be able to treat utilization signals of different scheduling classes
> > in different ways (e.g., CFS signal might be stale while DEADLINE signal
> > is never stale by design) we need to split sugov_cpu::util signal in two:
> > util_cfs and util_dl.
> > 
> > This patch does that by also changing sugov_get_util() parameter list.
> > After this change, aggregation of the different signals has to be performed
> > by sugov_get_util() users (so that they can decide what to do with the
> > different signals).
> 
> Did not tried myself, but to me it would be nice to have this patch
> squashed with the first one of this series. After all, looking at this
> one it seems that [RFC PATH 1/8] is just adding util_dl but it's not
> really using it the proper way.
> 
> Here instead is where you better introduce two separate signals,
> tracked by struct sugov_cpu, and properly aggregate them.
> 
> But perhaps that's just me being picky ;-)
> 

Sure. It looked too invasive as a single patch to me. Also, I was trying
to follow the "one change one patch" rule. So, I'd keep them separate.
What others think?

Best,

- Juri
