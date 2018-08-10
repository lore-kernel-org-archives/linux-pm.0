From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management
 framework
Date: Fri, 10 Aug 2018 09:15:39 +0100
Message-ID: <20180810081537.w3utogy4ujxf2cp4@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-4-quentin.perret@arm.com>
 <1598998.9rBByrtVSM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1598998.9rBByrtVSM@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Thursday 09 Aug 2018 at 23:52:29 (+0200), Rafael J. Wysocki wrote:
> I'm a bit concerned that the code here appears to be designed around the
> frequency domains concept which seems to be a limitation and which probably
> is related to the properties of the current generation of hardware.

That's correct. I went for 'frequency domains' only because this is what
EAS and IPA are interested in, as of today at least. And both of them
are somewhat dependent on CPU-Freq, which is called CPU-*Freq*, not
CPU-Perf after all :-)

> Assumptions like that tend to get tangled into the code tightly over time
> and they may be hard to untangle from it when new use cases arise later.
> 
> For example, there probably will be more firmware involvement in future
> systems and the firmware may not be willing to expose "raw" frequency
> domains to the OS.  That already is the case with P-states on Intel HW and
> with ACPI CPPC in general.

Agreed, and embedded/mobile systems are going in that direction too ...

> IMO, frequency domains in your current code could be replaced with something
> more general, like "performance domains"

I don't mind using a more abstract name as long as we keep the same
assumptions, and especially that all CPUs in a perf. domain *must* have
the same micro-architecture. From that assumption result several
properties that EAS (in its current) form needs. The first one is that
all CPUs of a performance domain have the same capacity at any possible
performance state. And the second is that they all consume the same
amount of (active) power.

I know it is theoretically possible to mix CPU types in the same perf
domain, but that becomes nightmare-ish to manage in EAS, and I don't
think there is a single platform like this on the market today. And I
hope nobody will build one. Peter wanted to mandate that too, I think.

> providing the scheduler with the (relative) cost of running a task

What do you mean by relative ? That we should normalize the power costs ?
Or just use an abstract scale, without specifying the unit ?

The main reason I'm a bit reluctant to do that just now is because IPA
needs to compare the power of CPUs with the power of other components
(GPUs, for example). And the power of those other components is specified
with a specific unit too. So, not imposing a comparable unit for the
power of CPUs will result in an unspecified behaviour in IPA, and that
will break things for sure. I would very much like to avoid that, of
course.

What I am currently proposing is to keep the unit (mW) in the EM
framework so that migrating IPA to using it can be done in a (relatively)
painless way. On a system where drivers  don't know the exact wattage,
then they should just 'lie' to the EM framework, but it's their job to
lie coherently to all subsystems and keep things consistent, because all
subsystems have specified power in comparable units.

Another solution to solve this problem could be to extend the EM
framework introduced by this patch and make it manage the EM of any
device, not just CPUs. Then we could just specify that all power costs
must be in the same scale, regardless of the actual unit, and register
the EM of CPUs, GPUs, ...
However, I was hoping that this patch as-is was enough for a first step,
and that this extension of the framework could be done in a second step ?
Thoughts ?

In any case, if we decide to keep the mW unit for now, I should at least
explain clearly why in the commit message.

> on a busy (non-idle) CPU (and, analogously,
> "idle domains" that would provide the scheduler with the - relative - cost
> of waking up an idle CPU to run a task on it or, the other way around, the
> possible relative gain from taking all tasks away from a CPU in order to make
> it go idle).

+1 for idle costs as a second type of 'domains' which could be managed
by the EM framework, alongside the 'perf' domains. I don't think we have
users of that just now (or providers of idle costs ?) so maybe that is
for later too ?

What do you think ?

Thank you very much for the feedback,
Quentin
