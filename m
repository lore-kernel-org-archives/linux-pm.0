From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 16:02:10 +0100
Message-ID: <20170321150210.GT3093@worktop>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <20170321132253.vjp7f72qkubpttmf@hirez.programming.kicks-ass.net>
 <CAKfTPtBp7GevDfnOTrOnrc79XP1mbY0onq=uh4Aw2tGu-DgHGw@mail.gmail.com>
 <3429350.K2FUBgvcIK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3429350.K2FUBgvcIK@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 21, 2017 at 03:26:06PM +0100, Rafael J. Wysocki wrote:
> +	if ((flags & SCHED_CPUFREQ_RT_DL) || this_rq()->rd->overload) {
>  		next_f = policy->cpuinfo.max_freq;

So this I think is wrong; rd->overload is set if _any_ of the CPUs in the
root domain is overloaded. And given the root domain is typically the
_entire_ machine, this would have a tendency to run at max_freq far too
often.
