From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 04/11] sched,x86: Enable Turbo Boost Max Technology
Date: Wed, 24 Aug 2016 10:50:57 -0700
Message-ID: <20160824175057.GA5032@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-5-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160824101853.GA25705@gmail.com>
Reply-To: tim.c.chen@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824101853.GA25705@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 24, 2016 at 12:18:53PM +0200, Ingo Molnar wrote:
> 
> * Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > From: Tim Chen <tim.c.chen@linux.intel.com>
> > 
> > On some Intel cores, they can boosted to a higher turbo frequency than
> > the other cores on the same die.  So we prefer processes to be run on
> > them vs other lower frequency ones for extra performance.
> > 
> > We extend the asym packing feature in the scheduler to support packing
> > task to the higher frequency core at the core sched domain level.
> > 
> > We set up a core priority metric to abstract the core preferences based
> > on the maximum boost frequency.  The priority is instantiated such that
> > the core with a higher priority is favored over the core with lower
> > priority when making scheduling decision using ASYM_PACKING.  The smt
> > threads that are of higher number are discounted in their priority so
> > we will not try to pack tasks onto all the threads of a favored core
> > before using other cpu cores.  The cpu that's of the highese priority
> > in a sched_group is recorded in sched_group->asym_prefer_cpu during
> > initialization to save lookup during load balancing.
> > 
> > A sysctl variable /proc/sys/kernel/sched_itmt_enabled is provided so
> > the scheduling based on favored core can be turned on or off at run time.
> 
> > +/*
> > + * Boolean to control whether we want to move processes to cpu capable
> > + * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
> > + * Technology 3.0.
> > + *
> > + * It can be set via /proc/sys/kernel/sched_itmt_enabled
> > + */
> > +unsigned int __read_mostly sysctl_sched_itmt_enabled = 0;
> 
> Ugh, no.
> 
> We don't add features to the scheduler in the hope that they might or might not 
> help. We either enable a new feature by default (and make damn sure it helps!),
> or don't add the feature at all.
> 
> Thanks,
> 
> 	Ingo

Ingo,

This feature will be a clear benefit for client machines and
less clear on servers.

This feature is most beneficial to single threaded workload running on
a single socket that operates in mostly Turbo mode.  Client platform
like Broadwell High End Desktop is the first one that supports it.
Enablng this feature for such platform by default will be a win as it
runs single threaded workload much of the time (10%-15% peformance
upside).

On the other hand, a heavily loaded server that rarely operates in Turbo
mode will benefit much less from this feature.  There is some overhead
incurred by migrating load to the favored cores.  Some server folks
have asked us to be cautious here and not to turn on ITMT scheduling
by default.   Even so, when the server is lightly loaded, this feature
can still be a win.  That said, this is future looking as we don't have
any server with this feature today.

So if we take the approach to enable this feature by default for only
single node system (using that as a criteria for client), will that seem
reasonable to you?

Thanks.

Tim
