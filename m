From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Tue, 23 May 2017 21:29:27 +0200
Message-ID: <20170523192927.ri2n72hrobghlros@hirez.programming.kicks-ass.net>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523085351.18586-5-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523085351.18586-5-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, May 23, 2017 at 09:53:47AM +0100, Juri Lelli wrote:
> To be able to treat utilization signals of different scheduling classes
> in different ways (e.g., CFS signal might be stale while DEADLINE signal
> is never stale by design) we need to split sugov_cpu::util signal in two:
> util_cfs and util_dl.
> 
> This patch does that by also changing sugov_get_util() parameter list.
> After this change aggregation of the different signals has to be performed
> by sugov_get_util() users (so that they can decide what to do with the
> different signals).

So what I don't see this patch doing; and I don't remember if cpufreq is
ready for this at all, is set the util_dl as min/guaranteed freq and
util_cfs+util_dl as requested freq.
