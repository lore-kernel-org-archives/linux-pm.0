From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering utilization update callbacks
Date: Wed, 24 Feb 2016 02:52:47 +0100
Message-ID: <4898593.Kfjv5WY6No@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <CAJZ5v0ha0_LroBiWfbE1HgRjrvk7zt4M+40JLnNHHLuewTF4hg@mail.gmail.com> <20160223111007.GK27380@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55617 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750850AbcBXBvP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 20:51:15 -0500
In-Reply-To: <20160223111007.GK27380@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Tuesday, February 23, 2016 11:10:07 AM Juri Lelli wrote:
> On 22/02/16 22:41, Rafael J. Wysocki wrote:
> > On Mon, Feb 22, 2016 at 10:42 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> > > Hi Rafael,
> > >
> > > On 19/02/16 23:26, Rafael J. Wysocki wrote:
> > >> On Friday, February 19, 2016 05:26:04 PM Juri Lelli wrote:
> > >> > Hi Srinivas,
> > 
> > [cut]
> > 
> > >> ---
> > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >> Subject: [PATCH] cpufreq: Rework the scheduler hooks for triggering updates
> > >>
> > >> Commit fe7034338ba0 (cpufreq: Add mechanism for registering
> > >> utilization update callbacks) added cpufreq_update_util() to be
> > >> called by the scheduler (from the CFS part) on utilization updates.
> > >> The goal was to allow CFS to pass utilization information to cpufreq
> > >> and to trigger it to evaluate the frequency/voltage configuration
> > >> (P-state) of every CPU on a regular basis.
> > >>
> > >> However, the last two arguments of that function are never used by
> > >> the current code, so CFS might simply call cpufreq_trigger_update()
> > >> instead of it.
> > >>
> > >> For this reason, drop the last two arguments of cpufreq_update_util(),
> > >> rename it to cpufreq_trigger_update() and modify CFS to call it.
> > >>
> > >> Moreover, since the utilization is not involved in that now, rename
> > >> data types, functions and variables related to cpufreq_trigger_update()
> > >> to reflect that (eg. struct update_util_data becomes struct
> > >> freq_update_hook and so on).
> > >>
> > >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > This patch looks good to me. I didn't yet test it, but it shouldn't
> > > break things AFAICT.
> > >
> > > Thanks a lot for taking the time for this cleanup.
> > 
> > Alas, I don't think I will apply it.
> > 
> > Peter says that he wants the arguments to stay and he has a point IMO.
> > 
> > The very idea behind hooking up cpufreq to the scheduler through those
> > hooks has always been to make it possible to use the utilization
> > information provided by the scheduler in cpufreq.  As it turns out, we
> > can make significant improvements even *without* using that
> > information, because just having the hooks in there alone makes it
> > possible to simplify the code quite a bit in general and make it more
> > straightforward, but that's a *bonus* and not the objective. :-)
> > 
> > The objective still is to use the utilization numbers from the scheduler.
> > 
> > Both sched-freq and my approach agree on that, so I don't quite see
> > why I should pretend that this isn't the case now?
> > 
> 
> As I said in the other reply, I'm not at all against having cpufreq
> hooks in the scheduler. I was only wondering if deciding where such
> hooks reside and which interface they have before we agreed on how they
> will be used might cause problems in the future. :-)

And I have said for a few times that I don't quite see what problems exactly
those might be.

Also having the hooks in there and with the util and max arguments allows
everybody to play with them and see what can be done and whether or not they
are suitable for particular purposes.  I've already sufficiently demonstrated
that they are generally useful I think.

And if they aren't suitable for a particular purpose, one can try different
types of changes and see what looks good, what's practical and what's not etc.
intel_pstate can do that, you can do that, I can look at that from the existing
cpufreq governors perspective and so on.  In other words, it facilitates future
development.

Thanks,
Rafael

