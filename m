From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] cpufreq: User/admin documentation update and consolidation
Date: Mon, 20 Feb 2017 14:58:27 +0100
Message-ID: <4488503.27M9KJWnWE@aspire.rjw.lan>
References: <6949552.t0rZsBY3Lp@aspire.rjw.lan> <20170220095608.GS21911@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170220095608.GS21911@vireshk-i7>
Sender: linux-doc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 20, 2017 03:26:08 PM Viresh Kumar wrote:
> On 18-02-17, 02:36, Rafael J. Wysocki wrote:
> > +CPU Initialization
> > +==================
> > +
> 
> 
> > +Next, the scaling driver's ``->init()`` callback is invoked with the policy
> > +pointer of the new CPU passed to it as the argument.  If the policy object
> > +pointed to by it is new
> 
> The callbacks don't need to do anything special for a new policy.
> Infact, ->init() is only called for new policies or policies which
> don't have any active CPUs as of now.

Yes, it is called for new and inactive policies.

For new policies it has to populate policy->cpus (because otherwise the core
doesn't know what CPUs should be there), which quite arguably doesn't have
to (or even doesn't need to) be done for inactive policies (because they already
have policy->real_cpus and policy->related_cpus populated).

I would even argue that ->init() should not update policy->cpus for inactive
(but not new) policies.

> > , that callback is expected to initialize the performance
> > +scaling hardware interface for the given CPU (or, more precisely, for the set of
> > +CPUs sharing the hardware interface it belongs to, represented by its policy
> > +object) and to set parameters of the policy, like the minimum and maximum
> > +frequencies supported by the hardware, the table of available frequencies (if
> > +the set of supported P-states is not a continuous range), and the mask of CPUs
> > +that belong to the same policy.
> 
> Maybe we should explicitly mention that both online and offline CPUs
> should be set in the mask ?

I can do that.

But offline CPUs can only be set in that mask if the policy is actually new.

> > That mask is then used by the core to populate
> > +the policy pointers for all of the CPUs in it.
> > +
> > +The next major initialization step for a new policy object is to attach a
> > +scaling governor to it (to begin with, that is the default scaling governor
> > +determined by the kernel configuration, but it may be changed later
> > +via ``sysfs``).  First, a pointer to the new policy object is passed to the
> > +governor's ``->init()`` callback which is expected to initialize all of the
> > +data structures necessary to handle the given policy and, possibly, to add
> > +a governor ``sysfs`` interface to it.  Next, the governor is started by
> > +invoking its ``->start()`` callback.
> 
> The rest of it looked good. Nice work Rafael :)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

Cheers,
Rafael

