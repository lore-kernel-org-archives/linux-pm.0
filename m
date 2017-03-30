From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFD PATCH 4/5] sched/cpufreq_schedutil: always consider all
 CPUs when deciding next freq
Date: Thu, 30 Mar 2017 09:58:05 +0100
Message-ID: <20170330085805.GF18960@e106622-lin>
References: <20170324140900.7334-1-juri.lelli@arm.com>
 <20170324140900.7334-5-juri.lelli@arm.com>
 <2348394.hDdCk9fbgK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2348394.hDdCk9fbgK@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 30/03/17 00:41, Rafael J. Wysocki wrote:
> On Friday, March 24, 2017 02:08:59 PM Juri Lelli wrote:
> > No assumption can be made upon the rate at which frequency updates get
> > triggered, as there are scheduling policies (like SCHED_DEADLINE) which
> > don't trigger them so frequently.
> > 
> > Remove such assumption from the code.
> 
> But the util/max values for idle CPUs may be stale, no?
> 

Right, that might be a problem. A proper solution I think would be to
remotely update such values for idle CPUs, and I believe Vincent is
working on a patch for that.

As mid-term workarounds, changing a bit the current one, come to my
mind:

 - consider TICK_NSEC (continue) only when SCHED_CPUFREQ_DL is not set
 - remove CFS contribution (without triggering a freq update) when a CPU
   enters IDLE; this might not work well, though, as we probably want
   to keep in blocked util contribution for a bit

What you think is the way to go?

Thanks,

- Juri
