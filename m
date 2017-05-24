From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Wed, 24 May 2017 09:01:07 +0200
Message-ID: <20170524070107.xq7tmjxqg6afsrss@hirez.programming.kicks-ass.net>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523085351.18586-5-juri.lelli@arm.com>
 <20170523192927.ri2n72hrobghlros@hirez.programming.kicks-ass.net>
 <1941953.5pVr1esCdP@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1941953.5pVr1esCdP@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Juri Lelli <juri.lelli@arm.com>, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 24, 2017 at 01:30:36AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, May 23, 2017 09:29:27 PM Peter Zijlstra wrote:
> > On Tue, May 23, 2017 at 09:53:47AM +0100, Juri Lelli wrote:
> > > To be able to treat utilization signals of different scheduling classes
> > > in different ways (e.g., CFS signal might be stale while DEADLINE signal
> > > is never stale by design) we need to split sugov_cpu::util signal in two:
> > > util_cfs and util_dl.
> > > 
> > > This patch does that by also changing sugov_get_util() parameter list.
> > > After this change aggregation of the different signals has to be performed
> > > by sugov_get_util() users (so that they can decide what to do with the
> > > different signals).
> > 
> > So what I don't see this patch doing; and I don't remember if cpufreq is
> > ready for this at all, is set the util_dl as min/guaranteed freq and
> > util_cfs+util_dl as requested freq.
> 
> I'm totally unsure what you mean here.

I was thinking of the CPPC/HWP stuff, where you can set different
frequencies with different levels of guarantees.

We'd want to set util_dl as the minimum (guaranteed) performance, and
util_dl + util_cfs as the desired performance level.

> cpufreq doesn't have a "guaranteed frequency" concept of any sort right now.

I was afraid of that ;-) I think we want a comment in the code stating
that this is the desired goal though. Then once cpufreq is ready to deal
with it we can change it..
