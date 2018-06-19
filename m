From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Tue, 19 Jun 2018 14:24:49 +0100
Message-ID: <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619122632.GS2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 14:26:32 (+0200), Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 03:25:00PM +0100, Quentin Perret wrote:
> > In order to use EAS, the task scheduler has to know about the Energy
> > Model (EM) of the platform. This commit extends the scheduler topology
> > code to take references on the frequency domains objects of the EM
> > framework for all online CPUs. Hence, the availability of the EM for
> > those CPUs is guaranteed to the scheduler at runtime without further
> > checks in latency sensitive code paths (i.e. task wake-up).
> 
> I'm confused by this patch,... what does it do? Why is em_cpu_get()
> (after you fix it) not sufficient?

Hmm, so maybe the confusing part is that this patch does two things:
1. it checks all conditions for starting EAS are met
  (SD_ASYM_CPUCAPACITY is set, the EM covers all online CPUs, the EM
  isn't too complex to be used during wakeup);
2. it builds a list of frequency domains for the private use of the
   scheduler in latency sensitive code paths, and sets the static key

So I guess your question is more about 2. It is nice to have a list of
frequency domains because that makes iteration over frequency domains
in the wake-up path very easy, and efficient (for_each_freq_domain() is
used in find_energy_efficient_cpu() and compute_energy(), patches 07 and
09/10).
And also, by making the scheduler maintain that list, we can be more
hotplug-aware. If you hotplug out all CPUs of a freq domain, the scheduler
can remove it from its list and have one less element to iterate against.
The idea was tp remove the unused things on hotplug, just like for
sched domains.

I think that not having that list would mean to play with cpumasks in
find_energy_efficient_cpu() and in compute_energy() to keep track of the
CPUs we have visited and stuff like that. That's doable but probably more
complex, and not more efficient, I think.

Is the overall idea any clearer ?

Thanks,
Quentin
