From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Fri, 8 Jun 2018 09:25:12 +0100
Message-ID: <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Dietmar,

On Thursday 07 Jun 2018 at 17:55:32 (+0200), Dietmar Eggemann wrote:
> On 06/07/2018 05:19 PM, Quentin Perret wrote:
> > Hi Juri,
> > 
> > On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
> > > On 21/05/18 15:24, Quentin Perret wrote:
> 
> [...]
> 
> > > Mmm, this gets complicated pretty fast eh? :)
> > 
> > Yeah, hopefully I'll be able to explain/clarify that :-).
> > 
> > > 
> > > I had to go back and forth between patches to start understanding the
> > > different data structures and how they are use, and I'm not sure yet
> > > I've got the full picture. I guess some nice diagram (cover letter or
> > > documentation patch) would help a lot.
> 
> +1 on the diagram.

:-)

> 
> > Right, so I'd like very much to write a nice documentation patch once we
> > are more or less OK with the overall design of this framework, but I
> > felt like it was a little bit early for that. If we finally decide that
> > what I did is totally stupid and that it'd be better to do things
> > completely differently, my nice documentation patch would be a lot of
> > efforts for nothing.
> > 
> > But I agree that at the same time all this complex code has to be
> > explained. Hopefully the existing comments can help with that.
> > Otherwise, I'm more than happy to answer all questions :-)
> 
> I'm not sure that the current API is the final one. Not sure that
> em_rescale_cpu_capacity() is really needed.

I understand why this specific part of the design can be confusing, but
I couldn't find another _clean_ way to deal with fact that re-scaling
the CPU capacities at run-time can happens, and that the different
clients (thermal, scheduler) have different needs when it comes to
CPU capacities. But suggestions are more than welcome !

> We should first clarify the provider - consumer relation. Are multiple
> providers allowed, if yes, are they allowed to provide partial EM data? Do
> we really want to allow this overwriting of old EM data
> (em_rescale_cpu_capacity()). In case multiple provider are allowed, is there
> some kind of priority involved?

The comment above em_register_freq_domain() explains that, at least
partially. In the current implementation, if multiple providers register
the same frequency domain, all but the first will be ignored. The reason
I implemented this that way is because: 1) it's simple; 2) it should
cover the current use-cases for EAS and IPA.

But we could do something more clever. We could add a parameter to
em_register_freq_domain() that would represent some sort of priority. In
this case, if multiple providers register the same freq domain, the
higher priority would override the lower priority. For example, power
values coming from firmware could overwrite power values estimated with
P=CV^2f for example.

> The re-scaling thing comes from the requirement that the final cpu capacity
> values are only known after the arch_topology driver was able to scale the
> dmipz-capacity-values with the policy->cpuinfo.max_freq but why can't we
> create the EM on arm/arm64 after this?

What if you don't have dmips-capacity-mhz values in the DT and still
want to use IPA ? There is no good reason to create a dependency between
the thermal subsystem and the arch_topology driver IMO.

> Even though we would be forced to get cpufreq's related cpumask from
> somewhere.

That's the easy part. The difficult part is, where do you get power
values from ? You have to let the lower layers register those values
in a centralized location on a voluntary basis. And then it becomes easy
for consumers to access that data, because they know where it is.

> I guess the easiest model will be that the Energy Model (EM) is fully
> initialized with one init call (from the arch) and fixed after that.

Again, I don't think that's possible. You have to let the lower layers
tell you where the power values come from, at the very least. You could
let the archs do that aggregation I suppose, but I don't really see the
benefit over one centralized framework with a generic interface ...
What's your opinion ?

> 
> In case the EM should not be tight to cpufreq, the interface
> em_create_fd(cpumask_t *span, int nr_states, struct em_data_callback *cb)
> seems ok.

Cool :-)

> IMHO, part of the problem why this might be harder to understand is the fact
> that the patches show the use of the 2. init call
> 'em_rescale_cpu_capacity()' but not the 1. one 'em_register_freq_domain()'.
> I guess that Quentin wanted to keep the set as small as possible.

Yes, this is confusing. I'm now starting to think that patch 10/10 should
probably not be part of this patch-set, especially if I don't provide
the patches registering the freq domains from the CPUFreq drivers. And
it's the only "Arm-specific" patch in this arch-independent patch-set.

So I think I'll drop patch 10/10 for v4 ... That part should be
discussed separately, with the rest of the Arm-specific changes.

Thanks !
Quentin
