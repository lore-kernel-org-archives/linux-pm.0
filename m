From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Tue, 23 Feb 2016 11:10:07 +0000
Message-ID: <20160223111007.GK27380@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <1455900129.7375.231.camel@linux.intel.com>
 <20160219172545.GA27380@e106622-lin>
 <1882532.OhsNMeyWOd@vostro.rjw.lan>
 <20160222094246.GC27380@e106622-lin>
 <CAJZ5v0ha0_LroBiWfbE1HgRjrvk7zt4M+40JLnNHHLuewTF4hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ha0_LroBiWfbE1HgRjrvk7zt4M+40JLnNHHLuewTF4hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 22/02/16 22:41, Rafael J. Wysocki wrote:
> On Mon, Feb 22, 2016 at 10:42 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> > Hi Rafael,
> >
> > On 19/02/16 23:26, Rafael J. Wysocki wrote:
> >> On Friday, February 19, 2016 05:26:04 PM Juri Lelli wrote:
> >> > Hi Srinivas,
> 
> [cut]
> 
> >> ---
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Subject: [PATCH] cpufreq: Rework the scheduler hooks for triggering updates
> >>
> >> Commit fe7034338ba0 (cpufreq: Add mechanism for registering
> >> utilization update callbacks) added cpufreq_update_util() to be
> >> called by the scheduler (from the CFS part) on utilization updates.
> >> The goal was to allow CFS to pass utilization information to cpufreq
> >> and to trigger it to evaluate the frequency/voltage configuration
> >> (P-state) of every CPU on a regular basis.
> >>
> >> However, the last two arguments of that function are never used by
> >> the current code, so CFS might simply call cpufreq_trigger_update()
> >> instead of it.
> >>
> >> For this reason, drop the last two arguments of cpufreq_update_util(),
> >> rename it to cpufreq_trigger_update() and modify CFS to call it.
> >>
> >> Moreover, since the utilization is not involved in that now, rename
> >> data types, functions and variables related to cpufreq_trigger_update()
> >> to reflect that (eg. struct update_util_data becomes struct
> >> freq_update_hook and so on).
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > This patch looks good to me. I didn't yet test it, but it shouldn't
> > break things AFAICT.
> >
> > Thanks a lot for taking the time for this cleanup.
> 
> Alas, I don't think I will apply it.
> 
> Peter says that he wants the arguments to stay and he has a point IMO.
> 
> The very idea behind hooking up cpufreq to the scheduler through those
> hooks has always been to make it possible to use the utilization
> information provided by the scheduler in cpufreq.  As it turns out, we
> can make significant improvements even *without* using that
> information, because just having the hooks in there alone makes it
> possible to simplify the code quite a bit in general and make it more
> straightforward, but that's a *bonus* and not the objective. :-)
> 
> The objective still is to use the utilization numbers from the scheduler.
> 
> Both sched-freq and my approach agree on that, so I don't quite see
> why I should pretend that this isn't the case now?
> 

As I said in the other reply, I'm not at all against having cpufreq
hooks in the scheduler. I was only wondering if deciding where such
hooks reside and which interface they have before we agreed on how they
will be used might cause problems in the future. :-)

Best,

- Juri
