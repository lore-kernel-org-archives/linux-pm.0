From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 09:42:46 +0000
Message-ID: <20160222094246.GC27380@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <1455900129.7375.231.camel@linux.intel.com>
 <20160219172545.GA27380@e106622-lin>
 <1882532.OhsNMeyWOd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1882532.OhsNMeyWOd@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 19/02/16 23:26, Rafael J. Wysocki wrote:
> On Friday, February 19, 2016 05:26:04 PM Juri Lelli wrote:
> > Hi Srinivas,
> > 
> > On 19/02/16 08:42, Srinivas Pandruvada wrote:
> > > On Fri, 2016-02-19 at 08:09 +0000, Juri Lelli wrote:
> > > Hi Juri,
> > > > > 
> > > > Hi Rafael,
> > > > 
> > > > On 18/02/16 21:22, Rafael J. Wysocki wrote:
> > > > > On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysocki.
> > > > > net> wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > 
> > > > 
> > > [...]
> > > 
> > > > However, I still don't quite get why we want to introduce an
> > > > interface
> > > > for explicit passing of util and max if we are not using such
> > > > parameters
> > > > yet. Also, I couldn't find any indication of how such parameters will
> > > > be
> > > > used in the future. If what we need today is a periodic kick for
> > > > cpufreq
> > > > governors that need it, we should simply do how we already do for RT
> > > > and
> > > > DL, IMHO. Also because the places where the current hooks reside
> > > > might
> > > > not be the correct and useful one once we'll start using the
> > > > utilization
> > > > parameters. I could probably make a case for DL where we should place
> > > > hooks in admission control path (or somewhere else when more
> > > > sophisticated mechanisms we'll be in place) rather then in the
> > > > periodic
> > > > tick.
> > > We did experiments using util/max in intel_pstate. For some benchmarks
> > > there were regression of 4 to 5%, for some benchmarks it performed at
> > > par with getting utilization from the processor. Further optimization
> > > in the algorithm is possible and still in progress. Idea is that we can
> > > change P-State fast enough and be more reactive. Once I have good data,
> > > I will send to this list. The algorithm can be part of the cpufreq
> > > governor too.
> > > 
> > 
> > Thanks for your answer. What you are experimenting with looks really
> > interesting and I'm certainly more than interested in looking at your
> > findings and patches when they will hit the list.
> > 
> > My point was more on what we can look at today, though. Without a clear
> > understanding about how and where util and max will be used and from
> > which scheduler paths such information should come from, it is a bit
> > difficult to tell if the current interface and hooks are fine, IMHO.
> 
> As I've just said, I may be able to show something shortly.
> 
> > I'd suggest we leave this part to the discussion we will have once your
> > proposal will be public; and to facilitate that we should remove those
> > arguments from the current interface.
> 
> I'm not really sure how this will help apart from removing some tiny extra
> overhead that is expected to be temporary anyway.
> 
> That said, since both you and Steve are making the point that the utilization
> arguments are problematic and I'd really like to be able to make progress here,
> I don't have any fundamental problems with dropping them for the time being,
> but I'm not going to rebase the 50+ commits I have queued up on top of the
> $subject patch.
> 
> So I can apply something like the appended patch if that helps to address
> your concerns.
> 
> Thanks,
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Rework the scheduler hooks for triggering updates
> 
> Commit fe7034338ba0 (cpufreq: Add mechanism for registering
> utilization update callbacks) added cpufreq_update_util() to be
> called by the scheduler (from the CFS part) on utilization updates.
> The goal was to allow CFS to pass utilization information to cpufreq
> and to trigger it to evaluate the frequency/voltage configuration
> (P-state) of every CPU on a regular basis.
> 
> However, the last two arguments of that function are never used by
> the current code, so CFS might simply call cpufreq_trigger_update()
> instead of it.
> 
> For this reason, drop the last two arguments of cpufreq_update_util(),
> rename it to cpufreq_trigger_update() and modify CFS to call it.
> 
> Moreover, since the utilization is not involved in that now, rename
> data types, functions and variables related to cpufreq_trigger_update()
> to reflect that (eg. struct update_util_data becomes struct
> freq_update_hook and so on).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This patch looks good to me. I didn't yet test it, but it shouldn't
break things AFAICT.

Thanks a lot for taking the time for this cleanup.

Best,

- Juri
