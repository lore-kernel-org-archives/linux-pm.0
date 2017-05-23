From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC 4/8] sched/cpufreq_schedutil: split utilization signals
Date: Wed, 24 May 2017 01:30:36 +0200
Message-ID: <1941953.5pVr1esCdP@aspire.rjw.lan>
References: <20170523085351.18586-1-juri.lelli@arm.com> <20170523085351.18586-5-juri.lelli@arm.com> <20170523192927.ri2n72hrobghlros@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45083 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751670AbdEWXhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 19:37:22 -0400
In-Reply-To: <20170523192927.ri2n72hrobghlros@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>

On Tuesday, May 23, 2017 09:29:27 PM Peter Zijlstra wrote:
> On Tue, May 23, 2017 at 09:53:47AM +0100, Juri Lelli wrote:
> > To be able to treat utilization signals of different scheduling classes
> > in different ways (e.g., CFS signal might be stale while DEADLINE signal
> > is never stale by design) we need to split sugov_cpu::util signal in two:
> > util_cfs and util_dl.
> > 
> > This patch does that by also changing sugov_get_util() parameter list.
> > After this change aggregation of the different signals has to be performed
> > by sugov_get_util() users (so that they can decide what to do with the
> > different signals).
> 
> So what I don't see this patch doing; and I don't remember if cpufreq is
> ready for this at all, is set the util_dl as min/guaranteed freq and
> util_cfs+util_dl as requested freq.

I'm totally unsure what you mean here.

cpufreq doesn't have a "guaranteed frequency" concept of any sort right now.
