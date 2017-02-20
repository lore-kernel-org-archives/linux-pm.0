From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] cpufreq: User/admin documentation update and consolidation
Date: Tue, 21 Feb 2017 00:47:40 +0100
Message-ID: <3286899.ZXTn8kPQWt@aspire.rjw.lan>
References: <6949552.t0rZsBY3Lp@aspire.rjw.lan> <20170220095608.GS21911@vireshk-i7> <4488503.27M9KJWnWE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4488503.27M9KJWnWE@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 20, 2017 02:58:27 PM Rafael J. Wysocki wrote:
> On Monday, February 20, 2017 03:26:08 PM Viresh Kumar wrote:
> > On 18-02-17, 02:36, Rafael J. Wysocki wrote:
> > > +CPU Initialization
> > > +==================
> > > +
> > 
> > 
> > > +Next, the scaling driver's ``->init()`` callback is invoked with the policy
> > > +pointer of the new CPU passed to it as the argument.  If the policy object
> > > +pointed to by it is new
> > 
> > The callbacks don't need to do anything special for a new policy.
> > Infact, ->init() is only called for new policies or policies which
> > don't have any active CPUs as of now.
> 
> Yes, it is called for new and inactive policies.
> 
> For new policies it has to populate policy->cpus (because otherwise the core
> doesn't know what CPUs should be there), which quite arguably doesn't have
> to (or even doesn't need to) be done for inactive policies (because they already
> have policy->real_cpus and policy->related_cpus populated).
> 
> I would even argue that ->init() should not update policy->cpus for inactive
> (but not new) policies.
> 
> > > , that callback is expected to initialize the performance
> > > +scaling hardware interface for the given CPU (or, more precisely, for the set of
> > > +CPUs sharing the hardware interface it belongs to, represented by its policy
> > > +object) and to set parameters of the policy, like the minimum and maximum
> > > +frequencies supported by the hardware, the table of available frequencies (if
> > > +the set of supported P-states is not a continuous range), and the mask of CPUs
> > > +that belong to the same policy.
> > 
> > Maybe we should explicitly mention that both online and offline CPUs
> > should be set in the mask ?
> 
> I can do that.
> 
> But offline CPUs can only be set in that mask if the policy is actually new.

Well, drivers actually always set them, so let me put it differently.

It is not very useful to update a policy that previously was inactive from
->init(), because the related_cpus mask is only populated if the policy is new
and the symbolic links from CPU directories in sysfs to it are only created
once etc.

So it would be OK to skip updating the policy in ->init() in that case.

Thanks,
Rafael

