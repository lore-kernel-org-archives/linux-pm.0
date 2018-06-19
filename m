From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Tue, 19 Jun 2018 20:42:50 +0200
Message-ID: <20180619184250.GF2494@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
 <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
 <20180619162042.GT2458@hirez.programming.kicks-ass.net>
 <20180619171316.GB29374@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619171316.GB29374@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 19, 2018 at 06:13:17PM +0100, Quentin Perret wrote:
> I agree having one list per root_domain should be better. I'll change that
> in v4. But I also think the idea of a global static_key is broken then.

Static keys are global per definition, there is only a single copy of
the code.

You have to enable if there is a root domain with more than 1
freq-domain.

> We need a per root_domain thing as well. The SD_ASYM_CPUCAPACITY flag
> might be set on one hierarchy and not the other for ex. Not sure if
> attaching a static_key to each root_domain really makes sense though ...
> 
> Would replacing the static_key by a flag attached to the root_domain be
> reasonable ? 

Keep the static key as is, enable if any root domain needs it.

> > (and an empty list if there is but one entry on).
> 
> Sorry but I didn't understand that ...

If you have only a single freq-domain, there is nothing to do, right?
