From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Wed, 20 Jun 2018 08:58:09 +0100
Message-ID: <20180620075809.GA23168@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
 <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
 <20180619162042.GT2458@hirez.programming.kicks-ass.net>
 <20180619171316.GB29374@e108498-lin.cambridge.arm.com>
 <20180619184250.GF2494@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619184250.GF2494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 20:42:50 (+0200), Peter Zijlstra wrote:
> On Tue, Jun 19, 2018 at 06:13:17PM +0100, Quentin Perret wrote:
> > Would replacing the static_key by a flag attached to the root_domain be
> > reasonable ? 
> 
> Keep the static key as is, enable if any root domain needs it.

OK. So basically the semantics of the static key becomes: it is set if
at least one root domain has a non-empty list of freq domains. And a
root_domain has a non-empty list of frequency domains if it meets all
conditions for EAS (SD_ASYM_CPUCAPACITY flag set, low complexity for
the "portion" of the EM covering it, ...)

And then, checking the status of the list (empty or not) for a specific
root domain can replace my flag I guess. I'll need to check that somewhere
around select_task_rq_fair() in addition to the check on the static key to
decide if a task can go in find_energy_efficient_cpu().

> > Sorry but I didn't understand that ...
> 
> If you have only a single freq-domain, there is nothing to do, right?

Ah, right. Since we already agreed that all CPUs in a freq domain must
have the same micro-arch, that's correct. Checking the presence of the
SD_ASYM_CPUCAPACITY flag should cover this case I guess.

Thanks,
Quentin
